; RUN: llc < %s -march=avr -mcpu=avr5 | FileCheck %s

; This testcase covers an old bug caused by the SelectionDAGBuilder not splitting up arguments properly.
;
; It was fixed by adding some extra logic into AVRTargetLowering::LowerReturn to work around it.
;
; Here's the original backtrace.
;
; UNREACHABLE executed at /home/dylan/projects/llvm-project/llvm/lib/Target/AVR/AVRInstrInfo.cpp:75!
; Stack dump:
; 0.      Program arguments: ./bin/llc -march=avr -mcpu=atmega328p -filetype=obj issue-92.ll
; 1.      Running pass 'Function Pass Manager' on module 'issue-92.ll'.
; 2.      Running pass 'Post-RA pseudo instruction expansion pass' on function '@chapstick'
; #0 0x00007f279cb0e046 llvm::sys::PrintStackTrace(llvm::raw_ostream&) /home/dylan/projects/llvm-project/llvm/lib/Support/Unix/Signals.inc:488:11
; #1 0x00007f279cb0e249 PrintStackTraceSignalHandler(void*) /home/dylan/projects/llvm-project/llvm/lib/Support/Unix/Signals.inc:552:1
; #2 0x00007f279cb0c713 llvm::sys::RunSignalHandlers() /home/dylan/projects/llvm-project/llvm/lib/Support/Signals.cpp:66:5
; #3 0x00007f279cb0e67d SignalHandler(int) /home/dylan/projects/llvm-project/llvm/lib/Support/Unix/Signals.inc:0:3
; #4 0x00007f279b96fb90 __restore_rt (/usr/lib/libpthread.so.0+0x11b90)
; #5 0x00007f279aca5efb __GI_raise (/usr/lib/libc.so.6+0x34efb)
; #6 0x00007f279aca72c1 __GI_abort (/usr/lib/libc.so.6+0x362c1)
; #7 0x00007f279c9d5f70 llvm::install_out_of_memory_new_handler() /home/dylan/projects/llvm-project/llvm/lib/Support/ErrorHandling.cpp:193:0
; #8 0x00007f27a1c42649 llvm::AVRInstrInfo::copyPhysReg(llvm::MachineBasicBlock&, llvm::MachineInstrBundleIterator<llvm::MachineInstr, false>, llvm::DebugLoc const&, unsigned int, unsigned int, bool) const /home/dylan/projects/llvm-project/llvm/lib/Target/AVR/AVRInstrInfo.cpp:0:7
; #9 0x00007f279f5a21cb (anonymous namespace)::ExpandPostRA::LowerCopy(llvm::MachineInstr*) /home/dylan/projects/llvm-project/llvm/lib/CodeGen/ExpandPostRAPseudos.cpp:167:7
; #10 0x00007f279f5a1619 (anonymous namespace)::ExpandPostRA::runOnMachineFunction(llvm::MachineFunction&) /home/dylan/projects/llvm-project/llvm/lib/CodeGen/ExpandPostRAPseudos.cpp:213:23
; #11 0x00007f279f7890f1 llvm::MachineFunctionPass::runOnFunction(llvm::Function&) /home/dylan/projects/llvm-project/llvm/lib/CodeGen/MachineFunctionPass.cpp:62:8
; #12 0x00007f279ec67562 llvm::FPPassManager::runOnFunction(llvm::Function&) /home/dylan/projects/llvm-project/llvm/lib/IR/LegacyPassManager.cpp:1581:23
; #13 0x00007f279ec678e2 llvm::FPPassManager::runOnModule(llvm::Module&) /home/dylan/projects/llvm-project/llvm/lib/IR/LegacyPassManager.cpp:1603:16
; #14 0x00007f279ec68180 (anonymous namespace)::MPPassManager::runOnModule(llvm::Module&) /home/dylan/pro

; CHECK-LABEL: chapstick
define { i8, i32 } @chapstick() {
start:
  ret { i8, i32 } zeroinitializer
}

