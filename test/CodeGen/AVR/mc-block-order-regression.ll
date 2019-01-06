; RUN: llc < %s -O3 -march=avr | FileCheck %s
; check that block ordering isn't messed up
; if broken, it passes with -O0 and fails with -O1 or above

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9"

%Vs5UInt8 = type <{ i8 }>
%Vs6UInt32 = type <{ i32 }>
%Sb = type <{ i1 }>

@_Tv4main11delayFactorVs5UInt8 = hidden local_unnamed_addr global %Vs5UInt8 zeroinitializer, align 1
@_Tv4main7delayUsVs6UInt32 = hidden local_unnamed_addr global %Vs6UInt32 zeroinitializer, align 4
@_Tv4main7enabledSb = hidden local_unnamed_addr global %Sb zeroinitializer, align 1

declare void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16, i8) local_unnamed_addr #1

; CHECK-LABEL: _TF4main9i2cUpdateFT8registerVs5UInt85valueS0__T_
define hidden void @_TF4main9i2cUpdateFT8registerVs5UInt85valueS0__T_(i8, i8) local_unnamed_addr #1 {
entry:
  ; CHECK: push [[PRELUDER:r[0-9]+]]
  ; CHECK: cpi  r24, 7
  switch i8 %0, label %9 [
    i8 6, label %2
    i8 7, label %8
  ]

  ; CHECK-NOT: ret
; <label>:2:                                      ; preds = %entry
  %3 = icmp ugt i8 %1, 90
  %4 = icmp ult i8 %1, 5
  %. = select i1 %4, i8 5, i8 %1
  %5 = select i1 %3, i8 90, i8 %.
  ; CHECK: sts _Tv4main11delayFactorVs5UInt8, r{{[0-9]+}}
  store i8 %5, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main11delayFactorVs5UInt8, i64 0, i32 0), align 1
  %6 = zext i8 %5 to i32
  ; CHECK: call  __mulsi3
  %7 = mul nuw nsw i32 %6, 100
  ; CHECK: sts  _Tv4main7delayUsVs6UInt32+3, r{{[0-9]+}}
  ; CHECK-NEXT: sts  _Tv4main7delayUsVs6UInt32+2, r{{[0-9]+}}
  ; CHECK-NEXT: sts  _Tv4main7delayUsVs6UInt32+1, r{{[0-9]+}}
  ; CHECK-NEXT: sts  _Tv4main7delayUsVs6UInt32, r{{[0-9]+}}
  store i32 %7, i32* getelementptr inbounds (%Vs6UInt32, %Vs6UInt32* @_Tv4main7delayUsVs6UInt32, i64 0, i32 0), align 4
  ; CHECK: call  _TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_
  tail call void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16 34, i8 %5)
  br label %9

  ; CHECK-NOT: ret
; <label>:8:                                      ; preds = %entry
  %not. = icmp ne i8 %1, 0
  %.2 = zext i1 %not. to i8
  ; CHECK: sts _Tv4main7enabledSb, r{{[0-9]+}}
  store i1 %not., i1* getelementptr inbounds (%Sb, %Sb* @_Tv4main7enabledSb, i64 0, i32 0), align 1
  ; CHECK: call _TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_
  tail call void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16 35, i8 %.2)
  br label %9

; <label>:9:                                      ; preds = %8, %2, %entry
  ; CHECK: pop [[PRELUDER]]
  ; CHECK-NEXT: ret
  ret void
}
; CHECK-LABEL: .Lfunc_end0
