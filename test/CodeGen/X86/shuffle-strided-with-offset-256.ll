; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx | FileCheck %s --check-prefix=AVX --check-prefix=AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx2 | FileCheck %s --check-prefix=AVX --check-prefix=AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512f | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512vl | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512VL
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512BW
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+avx512bw,+avx512vl | FileCheck %s --check-prefix=AVX512 --check-prefix=AVX512BWVL

define void @shuffle_v32i8_to_v16i8_1(<32 x i8>* %L, <16 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <1,3,5,7,9,11,13,15,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vextracti128 $1, %ymm0, %xmm1
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = <1,3,5,7,9,11,13,15,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX2-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX2-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovsxwd %ymm0, %zmm0
; AVX512F-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512F-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512VL-NEXT:    vpmovsxwd %ymm0, %zmm0
; AVX512VL-NEXT:    vpmovdb %zmm0, %xmm0
; AVX512VL-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovwb %zmm0, %ymm0
; AVX512BW-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v16i8_1:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlw $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovwb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <16 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15, i32 17, i32 19, i32 21, i32 23, i32 25, i32 27, i32 29, i32 31>
  store <16 x i8> %strided.vec, <16 x i8>* %S
  ret void
}

define void @shuffle_v16i16_to_v8i16_1(<16 x i16>* %L, <8 x i16>* %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = [2,3,6,7,10,11,14,15,14,15,10,11,12,13,14,15]
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm0[0],xmm1[0]
; AVX1-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[2,3,6,7,10,11,14,15,10,11,14,15,14,15],zero,zero,ymm0[18,19,22,23,26,27,30,31,26,27,30,31,30,31],zero,zero
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512BW-NEXT:    vmovdqa %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v8i16_1:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, <16 x i16>* %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <8 x i32> <i32 1, i32 3, i32 5, i32 7, i32 9, i32 11, i32 13, i32 15>
  store <8 x i16> %strided.vec, <8 x i16>* %S
  ret void
}

define void @shuffle_v8i32_to_v4i32_1(<8 x i32>* %L, <4 x i32>* %S) nounwind {
; AVX-LABEL: shuffle_v8i32_to_v4i32_1:
; AVX:       # BB#0:
; AVX-NEXT:    vmovaps (%rdi), %ymm0
; AVX-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm1[1,3]
; AVX-NEXT:    vmovaps %xmm0, (%rsi)
; AVX-NEXT:    vzeroupper
; AVX-NEXT:    retq
;
; AVX512-LABEL: shuffle_v8i32_to_v4i32_1:
; AVX512:       # BB#0:
; AVX512-NEXT:    vmovaps (%rdi), %ymm0
; AVX512-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX512-NEXT:    vshufps {{.*#+}} xmm0 = xmm0[1,3],xmm1[1,3]
; AVX512-NEXT:    vmovaps %xmm0, (%rsi)
; AVX512-NEXT:    vzeroupper
; AVX512-NEXT:    retq
  %vec = load <8 x i32>, <8 x i32>* %L
  %strided.vec = shufflevector <8 x i32> %vec, <8 x i32> undef, <4 x i32> <i32 1, i32 3, i32 5, i32 7>
  store <4 x i32> %strided.vec, <4 x i32>* %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_1(<32 x i8>* %L, <8 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <1,5,9,13,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[1,u,5,u,9,u,13,u,u,u,u,u,u,u,u,u,17,u,21,u,25,u,29,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_1:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlw $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  store <8 x i8> %strided.vec, <8 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_2(<32 x i8>* %L, <8 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <2,6,10,14,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[2,3,6,7,10,11,14,15,14,15,10,11,12,13,14,15,18,19,22,23,26,27,30,31,30,31,26,27,28,29,30,31]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_2:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  store <8 x i8> %strided.vec, <8 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v8i8_3(<32 x i8>* %L, <8 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <3,7,11,15,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[3,u,7,u,11,u,15,u,u,u,u,u,u,u,u,u,19,u,23,u,27,u,31,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovdw %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,2,4,6,8,10,12,14,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v8i8_3:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovdb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>
  store <8 x i8> %strided.vec, <8 x i8>* %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_1(<16 x i16>* %L, <4 x i16>* %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[0,2,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[1,3,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[0,2,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[1,3,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_1:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, <16 x i16>* %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  store <4 x i16> %strided.vec, <4 x i16>* %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_2(<16 x i16>* %L, <4 x i16>* %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[2,0,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[2,0,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm0 = [1,3,5,7,5,7,7,7]
; AVX2-NEXT:    vpermd (%rdi), %ymm0, %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_2:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, <16 x i16>* %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  store <4 x i16> %strided.vec, <4 x i16>* %S
  ret void
}

define void @shuffle_v16i16_to_v4i16_3(<16 x i16>* %L, <4 x i16>* %S) nounwind {
; AVX1-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm1[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm1 = xmm1[3,1,2,3,4,5,6,7]
; AVX1-NEXT:    vpshufd {{.*#+}} xmm0 = xmm0[3,1,2,3]
; AVX1-NEXT:    vpshuflw {{.*#+}} xmm0 = xmm0[3,1,2,3,4,5,6,7]
; AVX1-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX1-NEXT:    vmovq %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512F-NEXT:    vmovq %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,1,4,5,8,9,12,13,8,9,12,13,12,13,14,15]
; AVX512BW-NEXT:    vmovq %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v16i16_to_v4i16_3:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqw %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <16 x i16>, <16 x i16>* %L
  %strided.vec = shufflevector <16 x i16> %vec, <16 x i16> undef, <4 x i32> <i32 3, i32 7, i32 11, i32 15>
  store <4 x i16> %strided.vec, <4 x i16>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_1(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <1,9,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512VL-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlw $8, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_1:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlw $8, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 1, i32 9, i32 17, i32 25>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_2(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <2,10,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $16, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_2:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $16, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 2, i32 10, i32 18, i32 26>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_3(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <3,11,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrld $24, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_3:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrld $24, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 3, i32 11, i32 19, i32 27>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_4(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <4,12,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa {{.*#+}} ymm0 = [1,3,5,7,5,7,7,7]
; AVX2-NEXT:    vpermd (%rdi), %ymm0, %ymm0
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_4:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpshufd {{.*#+}} ymm0 = mem[1,1,3,3,5,5,7,7]
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 4, i32 12, i32 20, i32 28>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_5(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <5,13,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrlq $40, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $40, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrlq $40, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $40, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_5:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlq $40, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 5, i32 13, i32 21, i32 29>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_6(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <6,14,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $48, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_6:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlq $48, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 6, i32 14, i32 22, i32 30>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

define void @shuffle_v32i8_to_v4i8_7(<32 x i8>* %L, <4 x i8>* %S) nounwind {
; AVX1-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX1:       # BB#0:
; AVX1-NEXT:    vmovdqa (%rdi), %ymm0
; AVX1-NEXT:    vextractf128 $1, %ymm0, %xmm1
; AVX1-NEXT:    vmovdqa {{.*#+}} xmm2 = <7,15,u,u,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX1-NEXT:    vpshufb %xmm2, %xmm1, %xmm1
; AVX1-NEXT:    vpshufb %xmm2, %xmm0, %xmm0
; AVX1-NEXT:    vpunpcklwd {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
; AVX1-NEXT:    vmovd %xmm0, (%rsi)
; AVX1-NEXT:    vzeroupper
; AVX1-NEXT:    retq
;
; AVX2-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX2:       # BB#0:
; AVX2-NEXT:    vmovdqa (%rdi), %ymm0
; AVX2-NEXT:    vpsrlq $56, %ymm0, %ymm0
; AVX2-NEXT:    vpshufd {{.*#+}} ymm0 = ymm0[0,2,2,3,4,6,6,7]
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,2,3]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm0, (%rsi)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
;
; AVX512F-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512F:       # BB#0:
; AVX512F-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512F-NEXT:    vpsrlq $56, %ymm0, %ymm0
; AVX512F-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512F-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512F-NEXT:    vmovd %xmm0, (%rsi)
; AVX512F-NEXT:    vzeroupper
; AVX512F-NEXT:    retq
;
; AVX512VL-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512VL:       # BB#0:
; AVX512VL-NEXT:    vpsrlq $56, (%rdi), %ymm0
; AVX512VL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512VL-NEXT:    vzeroupper
; AVX512VL-NEXT:    retq
;
; AVX512BW-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512BW:       # BB#0:
; AVX512BW-NEXT:    vmovdqa (%rdi), %ymm0
; AVX512BW-NEXT:    vpsrlq $56, %ymm0, %ymm0
; AVX512BW-NEXT:    vpmovqd %zmm0, %ymm0
; AVX512BW-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX512BW-NEXT:    vmovd %xmm0, (%rsi)
; AVX512BW-NEXT:    vzeroupper
; AVX512BW-NEXT:    retq
;
; AVX512BWVL-LABEL: shuffle_v32i8_to_v4i8_7:
; AVX512BWVL:       # BB#0:
; AVX512BWVL-NEXT:    vpsrlq $56, (%rdi), %ymm0
; AVX512BWVL-NEXT:    vpmovqb %ymm0, (%rsi)
; AVX512BWVL-NEXT:    vzeroupper
; AVX512BWVL-NEXT:    retq
  %vec = load <32 x i8>, <32 x i8>* %L
  %strided.vec = shufflevector <32 x i8> %vec, <32 x i8> undef, <4 x i32> <i32 7, i32 15, i32 23, i32 31>
  store <4 x i8> %strided.vec, <4 x i8>* %S
  ret void
}

