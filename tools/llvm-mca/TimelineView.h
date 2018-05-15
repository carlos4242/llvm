//===--------------------- TimelineView.h -----------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
/// \brief
///
/// This file implements a timeline view for the llvm-mca tool.
///
/// Class TimelineView observes events generated by the backend. For every
/// instruction executed by the backend, it stores information related to
/// state transition. It then plots that information in the form of a table
/// as reported by the example below:
///
/// Timeline view:
///     	          0123456
/// Index	0123456789
///
/// [0,0]	DeER .    .    ..	vmovshdup  %xmm0, %xmm1
/// [0,1]	DeER .    .    ..	vpermilpd  $1, %xmm0, %xmm2
/// [0,2]	.DeER.    .    ..	vpermilps  $231, %xmm0, %xmm5
/// [0,3]	.DeeeER   .    ..	vaddss  %xmm1, %xmm0, %xmm3
/// [0,4]	. D==eeeER.    ..	vaddss  %xmm3, %xmm2, %xmm4
/// [0,5]	. D=====eeeER  ..	vaddss  %xmm4, %xmm5, %xmm6
///
/// [1,0]	.  DeE------R  ..	vmovshdup  %xmm0, %xmm1
/// [1,1]	.  DeE------R  ..	vpermilpd  $1, %xmm0, %xmm2
/// [1,2]	.   DeE-----R  ..	vpermilps  $231, %xmm0, %xmm5
/// [1,3]	.   D=eeeE--R  ..	vaddss  %xmm1, %xmm0, %xmm3
/// [1,4]	.    D===eeeER ..	vaddss  %xmm3, %xmm2, %xmm4
/// [1,5]	.    D======eeeER	vaddss  %xmm4, %xmm5, %xmm6
///
/// There is an entry for every instruction in the input assembly sequence.
/// The first field is a pair of numbers obtained from the instruction index.
/// The first element of the pair is the iteration index, while the second
/// element of the pair is a sequence number (i.e. a position in the assembly
/// sequence).
/// The second field of the table is the actual timeline information; each
/// column is the information related to a specific cycle of execution.
/// The timeline of an instruction is described by a sequence of character
/// where each character represents the instruction state at a specific cycle.
///
/// Possible instruction states are:
///  D: Instruction Dispatched
///  e: Instruction Executing
///  E: Instruction Executed (write-back stage)
///  R: Instruction retired
///  =: Instruction waiting in the Scheduler's queue
///  -: Instruction executed, waiting to retire in order.
///
/// dots ('.') and empty spaces are cycles where the instruction is not
/// in-flight.
///
/// The last column is the assembly instruction associated to the entry.
///
/// Based on the timeline view information from the example, instruction 0
/// at iteration 0 was dispatched at cycle 0, and was retired at cycle 3.
/// Instruction [0,1] was also dispatched at cycle 0, and it retired at
/// the same cycle than instruction [0,0].
/// Instruction [0,4] has been dispatched at cycle 2. However, it had to
/// wait for two cycles before being issued. That is because operands
/// became ready only at cycle 5.
///
/// This view helps further understanding bottlenecks and the impact of
/// resource pressure on the code.
///
/// To better understand why instructions had to wait for multiple cycles in
/// the scheduler's queue, class TimelineView also reports extra timing info
/// in another table named "Average Wait times" (see example below).
///
///
/// Average Wait times (based on the timeline view):
/// [0]: Executions
/// [1]: Average time spent waiting in a scheduler's queue
/// [2]: Average time spent waiting in a scheduler's queue while ready
/// [3]: Average time elapsed from WB until retire stage
///
///	[0]	[1]	[2]	[3]
/// 0.	 2	1.0	1.0	3.0	vmovshdup  %xmm0, %xmm1
/// 1.	 2	1.0	1.0	3.0	vpermilpd  $1, %xmm0, %xmm2
/// 2.	 2	1.0	1.0	2.5	vpermilps  $231, %xmm0, %xmm5
/// 3.	 2	1.5	0.5	1.0	vaddss  %xmm1, %xmm0, %xmm3
/// 4.	 2	3.5	0.0	0.0	vaddss  %xmm3, %xmm2, %xmm4
/// 5.	 2	6.5	0.0	0.0	vaddss  %xmm4, %xmm5, %xmm6
///
/// By comparing column [2] with column [1], we get an idea about how many
/// cycles were spent in the scheduler's queue due to data dependencies.
///
/// In this example, instruction 5 spent an average of ~6 cycles in the
/// scheduler's queue. As soon as operands became ready, the instruction
/// was immediately issued to the pipeline(s).
/// That is expected because instruction 5 cannot transition to the "ready"
/// state until %xmm4 is written by instruction 4.
///
//===----------------------------------------------------------------------===//

#ifndef LLVM_TOOLS_LLVM_MCA_TIMELINEVIEW_H
#define LLVM_TOOLS_LLVM_MCA_TIMELINEVIEW_H

#include "SourceMgr.h"
#include "View.h"
#include "llvm/MC/MCInstPrinter.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/FormattedStream.h"
#include "llvm/Support/raw_ostream.h"
#include <map>

namespace mca {

/// This class listens to instruction state transition events
/// in order to construct a timeline information.
///
/// For every instruction executed by the Backend, this class constructs
/// a TimelineViewEntry object. TimelineViewEntry objects are then used
/// to print the timeline information, as well as the "average wait times"
/// for every instruction in the input assembly sequence.
class TimelineView : public View {
  const llvm::MCSubtargetInfo &STI;
  llvm::MCInstPrinter &MCIP;
  const SourceMgr &AsmSequence;

  unsigned CurrentCycle;
  unsigned MaxCycle;
  unsigned LastCycle;

  struct TimelineViewEntry {
    unsigned CycleDispatched;
    unsigned CycleReady;
    unsigned CycleIssued;
    unsigned CycleExecuted;
    unsigned CycleRetired;
  };
  std::vector<TimelineViewEntry> Timeline;

  struct WaitTimeEntry {
    unsigned Executions;
    unsigned CyclesSpentInSchedulerQueue;
    unsigned CyclesSpentInSQWhileReady;
    unsigned CyclesSpentAfterWBAndBeforeRetire;
  };
  std::vector<WaitTimeEntry> WaitTime;

  void printTimelineViewEntry(llvm::formatted_raw_ostream &OS,
                              const TimelineViewEntry &E, unsigned Iteration,
                              unsigned SourceIndex) const;
  void printWaitTimeEntry(llvm::formatted_raw_ostream &OS,
                          const WaitTimeEntry &E, unsigned Index) const;

  const unsigned DEFAULT_ITERATIONS = 10;

  void initialize(unsigned MaxIterations);

  // Display characters for the TimelineView report output.
  struct DisplayChar {
    static const char Dispatched = 'D';
    static const char Executed = 'E';
    static const char Retired = 'R';
    static const char Waiting = '='; // Instruction is waiting in the scheduler.
    static const char Executing = 'e';
    static const char RetireLag = '-'; // The instruction is waiting to retire.
  };

public:
  TimelineView(const llvm::MCSubtargetInfo &sti, llvm::MCInstPrinter &Printer,
               const SourceMgr &Sequence, unsigned MaxIterations,
               unsigned Cycles)
      : STI(sti), MCIP(Printer), AsmSequence(Sequence), CurrentCycle(0),
        MaxCycle(Cycles == 0 ? 80 : Cycles), LastCycle(0) {
    initialize(MaxIterations);
  }

  // Event handlers.
  void onCycleEnd() override { ++CurrentCycle; }
  void onInstructionEvent(const HWInstructionEvent &Event) override;

  // print functionalities.
  void printTimeline(llvm::raw_ostream &OS) const;
  void printAverageWaitTimes(llvm::raw_ostream &OS) const;
  void printView(llvm::raw_ostream &OS) const override {
    printTimeline(OS);
    printAverageWaitTimes(OS);
  }
};
} // namespace mca

#endif
