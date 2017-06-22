; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

; Vary the operand sizes for extra coverage, but the transform should be identical in all cases.

; (X == 0) ? 0 : -1 --> (X == 0) - 1

define i8 @i8_select_0_or_neg1(i8 %x) {
; CHECK-LABEL: i8_select_0_or_neg1:
; CHECK:       # BB#0:
; CHECK-NEXT:    negb %dil
; CHECK-NEXT:    sbbb %al, %al
; CHECK-NEXT:    retq
  %cmp = icmp eq i8 %x, 0
  %sel = select i1 %cmp, i8 0, i8 -1
  ret i8 %sel
}

; (X == 0) ? 0 : -1 --> (X == 0) - 1

define i16 @i16_select_0_or_neg1_as_math(i16 %x) {
; CHECK-LABEL: i16_select_0_or_neg1_as_math:
; CHECK:       # BB#0:
; CHECK-NEXT:    negw %di
; CHECK-NEXT:    sbbw %ax, %ax
; CHECK-NEXT:    retq
  %cmp = icmp eq i16 %x, 0
  %ext = zext i1 %cmp to i16
  %add = add i16 %ext, -1
  ret i16 %add
}

; (X !== 0) ? -1 : 0 --> 0 - (X != 0)

define i32 @i32_select_0_or_neg1_commuted(i32 %x) {
; CHECK-LABEL: i32_select_0_or_neg1_commuted:
; CHECK:       # BB#0:
; CHECK-NEXT:    negl %edi
; CHECK-NEXT:    sbbl %eax, %eax
; CHECK-NEXT:    retq
  %cmp = icmp ne i32 %x, 0
  %sel = select i1 %cmp, i32 -1, i32 0
  ret i32 %sel
}

; (X !== 0) ? -1 : 0 --> 0 - (X != 0)

define i64 @i64_select_0_or_neg1_commuted_as_math(i64 %x) {
; CHECK-LABEL: i64_select_0_or_neg1_commuted_as_math:
; CHECK:       # BB#0:
; CHECK-NEXT:    negq %rdi
; CHECK-NEXT:    sbbq %rax, %rax
; CHECK-NEXT:    retq
  %cmp = icmp ne i64 %x, 0
  %ext = zext i1 %cmp to i64
  %add = sub i64 0, %ext
  ret i64 %add
}

