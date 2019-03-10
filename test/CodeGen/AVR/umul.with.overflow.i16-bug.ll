; RUN: llc -O1 < %s -march=avr | FileCheck %s

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9"

%Vs6UInt16 = type <{ i16 }>
%Sb = type <{ i1 }>

define hidden void @_TF4main13setServoAngleFT5angleVs6UInt16_T_(i16) #0 {
  ; CHECK-LABEL: entry
entry:
  %adjustedAngle = alloca %Vs6UInt16, align 2
  %1 = bitcast %Vs6UInt16* %adjustedAngle to i8*
  %adjustedAngle._value = getelementptr inbounds %Vs6UInt16, %Vs6UInt16* %adjustedAngle, i32 0, i32 0
  store i16 %0, i16* %adjustedAngle._value, align 2

;print(unsignedInt: adjustedAngle &* UInt16(11))
; breaks here
  %adjustedAngle._value2 = getelementptr inbounds %Vs6UInt16, %Vs6UInt16* %adjustedAngle, i32 0, i32 0
  %2 = load i16, i16* %adjustedAngle._value2, align 2

; CHECK: mov r22, r24
; CHECK: mov r23, r25

; CHECK-DAG: ldi r20, 0
; CHECK-DAG: ldi r21, 0
; CHECK-DAG: ldi r18, 11
; CHECK-DAG: ldi r19, 0

; CHECK: mov r24, r20
; CHECK: mov r25, r21
; CHECK: call  __mulsi3
  %3 = call { i16, i1 } @llvm.umul.with.overflow.i16(i16 %2, i16 11)
  %4 = extractvalue { i16, i1 } %3, 0
  %5 = extractvalue { i16, i1 } %3, 1

  ; above code looks fine, how is it lowered?
  %6 = call i1 @_TIF3AVR5printFT11unsignedIntVs6UInt1610addNewlineSb_T_A0_()
  call void @_TF3AVR5printFT11unsignedIntVs6UInt1610addNewlineSb_T_(i16 %4, i1 %6)

; CHECK: ret
  ret void
}

declare void @_TF3AVR5printFT11unsignedIntVs6UInt1610addNewlineSb_T_(i16, i1) #0
declare i1 @_TIF3AVR5printFT11unsignedIntVs6UInt1610addNewlineSb_T_A0_() #0

; Function Attrs: nounwind readnone speculatable
declare { i16, i1 } @llvm.umul.with.overflow.i16(i16, i16) #2

attributes #0 = { "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+fxsr,+mmx,+x87,+sse,+sse2,+sse3" }
attributes #2 = { nounwind readnone speculatable }
