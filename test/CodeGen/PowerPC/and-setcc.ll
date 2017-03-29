; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=powerpc64le-unknown-unknown -verify-machineinstrs | FileCheck %s

define zeroext i1 @ne_neg1_and_ne_zero(i64 %x) {
; CHECK-LABEL: ne_neg1_and_ne_zero:
; CHECK:       # BB#0:
; CHECK-NEXT:    addi 3, 3, 1
; CHECK-NEXT:    li 4, 0
; CHECK-NEXT:    li 12, 1
; CHECK-NEXT:    cmpldi 3, 1
; CHECK-NEXT:    isel 3, 12, 4, 1
; CHECK-NEXT:    blr
  %cmp1 = icmp ne i64 %x, -1
  %cmp2 = icmp ne i64 %x, 0
  %and = and i1 %cmp1, %cmp2
  ret i1 %and
}

; PR32401 - https://bugs.llvm.org/show_bug.cgi?id=32401

define zeroext i1 @cmpeq_logical(i16 zeroext %a, i16 zeroext %b, i16 zeroext %c, i16 zeroext %d) {
; CHECK-LABEL: cmpeq_logical:
; CHECK:       # BB#0:
; CHECK-NEXT:    cmpw 0, 3, 4
; CHECK-NEXT:    cmpw 1, 5, 6
; CHECK-NEXT:    li 3, 1
; CHECK-NEXT:    crnand 20, 2, 6
; CHECK-NEXT:    isel 3, 0, 3, 20
; CHECK-NEXT:    blr
  %cmp1 = icmp eq i16 %a, %b
  %cmp2 = icmp eq i16 %c, %d
  %and = and i1 %cmp1, %cmp2
  ret i1 %and
}

