; RUN: llc < %s -O1 -march=avr | FileCheck %s
; check that block ordering isn't messed up
; in the broken version, it passes with -O0 and fails with -O3

target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.9"

%Vs6UInt16 = type <{ i16 }>
%Vs5UInt8 = type <{ i8 }>
%Vs6UInt32 = type <{ i32 }>
%Sb = type <{ i1 }>

@_Tv4main24storedBrightnessLocationVs6UInt16 = hidden local_unnamed_addr global %Vs6UInt16 zeroinitializer, align 2
@_Tv4main19storedOnOffLocationVs6UInt16 = hidden local_unnamed_addr global %Vs6UInt16 zeroinitializer, align 2
@_Tv4main21brightnessi2cRegisterVs5UInt8 = hidden local_unnamed_addr global %Vs5UInt8 zeroinitializer, align 1
@_Tv4main16onOffi2cRegisterVs5UInt8 = hidden local_unnamed_addr global %Vs5UInt8 zeroinitializer, align 1
@_Tv4main11delayFactorVs5UInt8 = hidden local_unnamed_addr global %Vs5UInt8 zeroinitializer, align 1
@_Tv4main7delayUsVs6UInt32 = hidden local_unnamed_addr global %Vs6UInt32 zeroinitializer, align 4
@_Tv4main7enabledSb = hidden local_unnamed_addr global %Sb zeroinitializer, align 1
@__swift_reflection_version = linkonce_odr hidden constant i16 1
@llvm.used = appending global [1 x i8*] [i8* bitcast (i16* @__swift_reflection_version to i8*)], section "llvm.metadata"

; Function Attrs: noreturn
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
entry:
  store i16 34, i16* getelementptr inbounds (%Vs6UInt16, %Vs6UInt16* @_Tv4main24storedBrightnessLocationVs6UInt16, i64 0, i32 0), align 2
  store i16 35, i16* getelementptr inbounds (%Vs6UInt16, %Vs6UInt16* @_Tv4main19storedOnOffLocationVs6UInt16, i64 0, i32 0), align 2
  store i8 6, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main21brightnessi2cRegisterVs5UInt8, i64 0, i32 0), align 1
  store i8 7, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main16onOffi2cRegisterVs5UInt8, i64 0, i32 0), align 1
  store i8 90, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main11delayFactorVs5UInt8, i64 0, i32 0), align 1
  store i32 9000, i32* getelementptr inbounds (%Vs6UInt32, %Vs6UInt32* @_Tv4main7delayUsVs6UInt32, i64 0, i32 0), align 4
  store i1 false, i1* getelementptr inbounds (%Sb, %Sb* @_Tv4main7enabledSb, i64 0, i32 0), align 1
  %2 = tail call i8 @_TF3AVR10readEEPROMFT7addressVs6UInt16_Vs5UInt8(i16 34)
  %3 = icmp ugt i8 %2, 90
  %4 = icmp ult i8 %2, 5
  %.1 = select i1 %4, i8 5, i8 %2
  %5 = select i1 %3, i8 90, i8 %.1
  store i8 %5, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main11delayFactorVs5UInt8, i64 0, i32 0), align 1
  %6 = zext i8 %5 to i32
  %7 = mul nuw nsw i32 %6, 100
  store i32 %7, i32* getelementptr inbounds (%Vs6UInt32, %Vs6UInt32* @_Tv4main7delayUsVs6UInt32, i64 0, i32 0), align 4
  tail call void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16 34, i8 %5)
  %8 = tail call i8 @_TF3AVR10readEEPROMFT7addressVs6UInt16_Vs5UInt8(i16 35)
  %9 = icmp ne i8 %8, 0
  store i1 %9, i1* getelementptr inbounds (%Sb, %Sb* @_Tv4main7enabledSb, i64 0, i32 0), align 1
  tail call void @_TF3AVR36i2cSlaveSetupRegisterReceiveCallbackFT8callbackcTVs5UInt8S0__T__T_(i8* bitcast (void (i8, i8)* @_TToF4mainU_FTVs5UInt8S0__T_ to i8*))
  br label %10

; <label>:10:                                     ; preds = %10, %entry
  br label %10
}

declare i8 @_TF3AVR10readEEPROMFT7addressVs6UInt16_Vs5UInt8(i16) local_unnamed_addr #1

declare void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16, i8) local_unnamed_addr #1

declare void @_TF3AVR36i2cSlaveSetupRegisterReceiveCallbackFT8callbackcTVs5UInt8S0__T__T_(i8*) local_unnamed_addr #1

; Function Attrs: norecurse nounwind readnone
define hidden i1 @_TF4main12boolForUInt8FVs5UInt8Sb(i8) local_unnamed_addr #2 {
entry:
  %1 = icmp ne i8 %0, 0
  ret i1 %1
}

; Function Attrs: norecurse nounwind readnone
define hidden i8 @_TF4main12uint8ForBoolFSbVs5UInt8(i1) local_unnamed_addr #2 {
entry:
  %. = zext i1 %0 to i8
  ret i8 %.
}

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
  ; CHECK-NEXT: .Lfunc_end
  ret void
}

; CHECK-LABEL: _TF4main11updateDelayFVs5UInt8T_
define hidden void @_TF4main11updateDelayFVs5UInt8T_(i8) local_unnamed_addr #1 {
entry:
  %1 = icmp ugt i8 %0, 90
  %2 = icmp ult i8 %0, 5
  %. = select i1 %2, i8 5, i8 %0
  %3 = select i1 %1, i8 90, i8 %.
  store i8 %3, i8* getelementptr inbounds (%Vs5UInt8, %Vs5UInt8* @_Tv4main11delayFactorVs5UInt8, i64 0, i32 0), align 1
  %4 = zext i8 %3 to i32
  %5 = mul nuw nsw i32 %4, 100
  store i32 %5, i32* getelementptr inbounds (%Vs6UInt32, %Vs6UInt32* @_Tv4main7delayUsVs6UInt32, i64 0, i32 0), align 4
  tail call void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16 34, i8 %3)
  ret void
}

define hidden void @_TF4main13updateEnabledFSbT_(i1) local_unnamed_addr #1 {
entry:
  store i1 %0, i1* getelementptr inbounds (%Sb, %Sb* @_Tv4main7enabledSb, i64 0, i32 0), align 1
  %. = zext i1 %0 to i8
  tail call void @_TF3AVR11writeEEPROMFT7addressVs6UInt165valueVs5UInt8_T_(i16 35, i8 %.)
  ret void
}

define linkonce_odr hidden void @_TToF4mainU_FTVs5UInt8S0__T_(i8 zeroext, i8 zeroext) #1 {
entry:
  tail call void @_TF4main9i2cUpdateFT8registerVs5UInt85valueS0__T_(i8 %0, i8 %1) #3
  ret void
}

define linkonce_odr hidden void @_TF4mainU_FTVs5UInt8S0__T_(i8, i8) local_unnamed_addr #1 {
  tail call void @_TF4main9i2cUpdateFT8registerVs5UInt85valueS0__T_(i8 %0, i8 %1) #1
  ret void
}

attributes #0 = { noreturn "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+fxsr,+mmx,+x87,+sse,+sse2,+sse3" }
attributes #1 = { "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+fxsr,+mmx,+x87,+sse,+sse2,+sse3" }
attributes #2 = { norecurse nounwind readnone "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+fxsr,+mmx,+x87,+sse,+sse2,+sse3" }
attributes #3 = { noinline }
