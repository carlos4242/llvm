; RUN: llc -O3 -march=avr -mcpu=atmega328p < %s | FileCheck %s

%bytePtrType = type <{ i8* }>
%wideStruct = type <{ i16 }>
%longLongPtr = type { i64 }

; Function Attrs: nounwind
define hidden { i8*, i64 } @subFunc1(i8*, [24 x i8]* nocapture dereferenceable(24), i8, %bytePtrType* nocapture readonly dereferenceable(8)) local_unnamed_addr #1 {

  ; CHECK-LABEL: entry
entry:
  %object._value = getelementptr inbounds [24 x i8], [24 x i8]* %1, i64 0, i64 0

  store i8 %2, i8* %object._value, align 8
; CHECK: st Z, r18

  %4 = bitcast %bytePtrType* %3 to %wideStruct**

  %5 = load %wideStruct*, %wideStruct** %4, align 8

  %6 = zext i8 %2 to i64
  %._value = getelementptr inbounds %wideStruct, %wideStruct* %5, i64 %6, i32 0
  %7 = load i16, i16* %._value, align 2

  %._value1 = bitcast i8* %0 to i16*
  store i16 %7, i16* %._value1, align 2

  %8 = insertvalue { i8*, i64 } undef, i8* %0, 0
  %9 = insertvalue { i8*, i64 } %8, i64 ptrtoint (void (i8*, [24 x i8]*, %bytePtrType*, %longLongPtr*)* @subFunc2 to i64), 1

; CHECK: ret
  ret { i8*, i64 } %9
}

; Function Attrs: nounwind
declare hidden void @subFunc2(i8* nocapture readonly, [24 x i8]* nocapture readonly dereferenceable(24), %bytePtrType* nocapture readonly dereferenceable(8), %longLongPtr* nocapture readnone) #1
attributes #1 = { nounwind "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="core2" "target-features"="+ssse3,+cx16,+fxsr,+mmx,+x87,+sse,+sse2,+sse3" }

;...original swift code...
;extension UnsafeMutablePointer where Pointee == UInt16 {
;  subscript(index: UInt8) -> UInt16 {
;    get {
;      return self[Int(index)]
;    }
;    // the methods created by this seem to be the source of the out of registers crash...
;    set {
;      self[Int(index)] = newValue
;    }
;  }
;}
