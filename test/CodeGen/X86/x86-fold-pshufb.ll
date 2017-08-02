; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -relocation-model=pic -mtriple=x86_64-unknown-unknown -mattr=+ssse3 < %s | FileCheck %s
; RUN: llc -mtriple=x86_64-unknown-unknown -mattr=+ssse3 < %s | FileCheck %s

; Verify that the backend correctly folds the shuffle in function 'fold_pshufb'
; into a simple load from constant pool.

define <2 x i64> @fold_pshufb() {
; CHECK-LABEL: fold_pshufb:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    movaps {{.*#+}} xmm0 = [0,0,0,0,1,0,0,0,2,0,0,0,3,0,0,0]
; CHECK-NEXT:    retq
entry:
  %0 = tail call <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8> <i8 0, i8 0, i8 0, i8 0, i8 1, i8 0, i8 0, i8 0, i8 2, i8 0, i8 0, i8 0, i8 3, i8 0, i8 0, i8 0>, <16 x i8> <i8 0, i8 1, i8 2, i8 3, i8 4, i8 5, i8 6, i8 7, i8 8, i8 9, i8 10, i8 11, i8 12, i8 13, i8 14, i8 15>)
  %1 = bitcast <16 x i8> %0 to <2 x i64>
  ret <2 x i64> %1
}

; The pshufb from function @pr24562 was wrongly folded into its first operand
; as a result of a late target shuffle combine on the legalized selection dag.
;
; Check that the pshufb is correctly folded to a zero vector.

define <2 x i64> @pr24562() {
; CHECK-LABEL: pr24562:
; CHECK:       # BB#0: # %entry
; CHECK-NEXT:    xorps %xmm0, %xmm0
; CHECK-NEXT:    retq
entry:
  %0 = call <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8> <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>, <16 x i8> <i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1, i8 -1>) #2
  %1 = bitcast <16 x i8> %0 to <2 x i64>
  ret <2 x i64> %1
}

declare <16 x i8> @llvm.x86.ssse3.pshuf.b.128(<16 x i8>, <16 x i8>)
