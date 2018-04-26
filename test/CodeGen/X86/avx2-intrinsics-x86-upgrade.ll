; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=avx2 | FileCheck %s --check-prefix=CHECK --check-prefix=AVX2 --check-prefix=X86 --check-prefix=X86-AVX2
; RUN: llc < %s -mtriple=i686-apple-darwin -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512 --check-prefix=X86 --check-prefix=X86-AVX512
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=avx2 | FileCheck %s --check-prefix=CHECK --check-prefix=AVX2 --check-prefix=X64 --check-prefix=X64-AVX2
; RUN: llc < %s -mtriple=x86_64-apple-darwin -mattr=+avx512f,+avx512bw,+avx512vl | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512 --check-prefix=X64 --check-prefix=X64-AVX512

define <16 x i16> @test_x86_avx2_pblendw(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: test_x86_avx2_pblendw:
; X86:       ## %bb.0:
; X86-NEXT:    vpblendw {{.*#+}} ymm0 = ymm1[0,1,2],ymm0[3,4,5,6,7],ymm1[8,9,10],ymm0[11,12,13,14,15]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pblendw:
; X64:       ## %bb.0:
; X64-NEXT:    vpblendw {{.*#+}} ymm0 = ymm1[0,1,2],ymm0[3,4,5,6,7],ymm1[8,9,10],ymm0[11,12,13,14,15]
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pblendw(<16 x i16> %a0, <16 x i16> %a1, i32 7) ; <<16 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pblendw(<16 x i16>, <16 x i16>, i32) nounwind readnone


define <4 x i32> @test_x86_avx2_pblendd_128(<4 x i32> %a0, <4 x i32> %a1) {
; X86-LABEL: test_x86_avx2_pblendd_128:
; X86:       ## %bb.0:
; X86-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[3]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pblendd_128:
; X64:       ## %bb.0:
; X64-NEXT:    vblendps {{.*#+}} xmm0 = xmm1[0,1,2],xmm0[3]
; X64-NEXT:    retq
  %res = call <4 x i32> @llvm.x86.avx2.pblendd.128(<4 x i32> %a0, <4 x i32> %a1, i32 7) ; <<4 x i32>> [#uses=1]
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.avx2.pblendd.128(<4 x i32>, <4 x i32>, i32) nounwind readnone


define <8 x i32> @test_x86_avx2_pblendd_256(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: test_x86_avx2_pblendd_256:
; X86:       ## %bb.0:
; X86-NEXT:    vblendps {{.*#+}} ymm0 = ymm1[0,1,2],ymm0[3,4,5,6,7]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pblendd_256:
; X64:       ## %bb.0:
; X64-NEXT:    vblendps {{.*#+}} ymm0 = ymm1[0,1,2],ymm0[3,4,5,6,7]
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pblendd.256(<8 x i32> %a0, <8 x i32> %a1, i32 7) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pblendd.256(<8 x i32>, <8 x i32>, i32) nounwind readnone


define <4 x i64> @test_x86_avx2_movntdqa(i8* %a0) {
; X86-LABEL: test_x86_avx2_movntdqa:
; X86:       ## %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vmovntdqa (%eax), %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_movntdqa:
; X64:       ## %bb.0:
; X64-NEXT:    vmovntdqa (%rdi), %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.movntdqa(i8* %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.movntdqa(i8*) nounwind readonly


define <16 x i16> @test_x86_avx2_mpsadbw(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: test_x86_avx2_mpsadbw:
; X86:       ## %bb.0:
; X86-NEXT:    vmpsadbw $7, %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_mpsadbw:
; X64:       ## %bb.0:
; X64-NEXT:    vmpsadbw $7, %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.mpsadbw(<32 x i8> %a0, <32 x i8> %a1, i32 7) ; <<16 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.mpsadbw(<32 x i8>, <32 x i8>, i32) nounwind readnone


define <4 x i64> @test_x86_avx2_psll_dq_bs(<4 x i64> %a0) {
; X86-LABEL: test_x86_avx2_psll_dq_bs:
; X86:       ## %bb.0:
; X86-NEXT:    vpslldq {{.*#+}} ymm0 = zero,zero,zero,zero,zero,zero,zero,ymm0[0,1,2,3,4,5,6,7,8],zero,zero,zero,zero,zero,zero,zero,ymm0[16,17,18,19,20,21,22,23,24]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_psll_dq_bs:
; X64:       ## %bb.0:
; X64-NEXT:    vpslldq {{.*#+}} ymm0 = zero,zero,zero,zero,zero,zero,zero,ymm0[0,1,2,3,4,5,6,7,8],zero,zero,zero,zero,zero,zero,zero,ymm0[16,17,18,19,20,21,22,23,24]
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.psll.dq.bs(<4 x i64> %a0, i32 7) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.psll.dq.bs(<4 x i64>, i32) nounwind readnone


define <4 x i64> @test_x86_avx2_psrl_dq_bs(<4 x i64> %a0) {
; X86-LABEL: test_x86_avx2_psrl_dq_bs:
; X86:       ## %bb.0:
; X86-NEXT:    vpsrldq {{.*#+}} ymm0 = ymm0[7,8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,ymm0[23,24,25,26,27,28,29,30,31],zero,zero,zero,zero,zero,zero,zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_psrl_dq_bs:
; X64:       ## %bb.0:
; X64-NEXT:    vpsrldq {{.*#+}} ymm0 = ymm0[7,8,9,10,11,12,13,14,15],zero,zero,zero,zero,zero,zero,zero,ymm0[23,24,25,26,27,28,29,30,31],zero,zero,zero,zero,zero,zero,zero
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.psrl.dq.bs(<4 x i64> %a0, i32 7) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.psrl.dq.bs(<4 x i64>, i32) nounwind readnone


define <4 x i64> @test_x86_avx2_psll_dq(<4 x i64> %a0) {
; X86-LABEL: test_x86_avx2_psll_dq:
; X86:       ## %bb.0:
; X86-NEXT:    vpslldq {{.*#+}} ymm0 = zero,ymm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],zero,ymm0[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_psll_dq:
; X64:       ## %bb.0:
; X64-NEXT:    vpslldq {{.*#+}} ymm0 = zero,ymm0[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14],zero,ymm0[16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.psll.dq(<4 x i64> %a0, i32 8) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.psll.dq(<4 x i64>, i32) nounwind readnone


define <4 x i64> @test_x86_avx2_psrl_dq(<4 x i64> %a0) {
; X86-LABEL: test_x86_avx2_psrl_dq:
; X86:       ## %bb.0:
; X86-NEXT:    vpsrldq {{.*#+}} ymm0 = ymm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,ymm0[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_psrl_dq:
; X64:       ## %bb.0:
; X64-NEXT:    vpsrldq {{.*#+}} ymm0 = ymm0[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15],zero,ymm0[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],zero
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.psrl.dq(<4 x i64> %a0, i32 8) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.psrl.dq(<4 x i64>, i32) nounwind readnone


define <2 x i64> @test_x86_avx2_vextracti128(<4 x i64> %a0) {
; X86-LABEL: test_x86_avx2_vextracti128:
; X86:       ## %bb.0:
; X86-NEXT:    vextractf128 $1, %ymm0, %xmm0
; X86-NEXT:    vzeroupper
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vextracti128:
; X64:       ## %bb.0:
; X64-NEXT:    vextractf128 $1, %ymm0, %xmm0
; X64-NEXT:    vzeroupper
; X64-NEXT:    retq
  %res = call <2 x i64> @llvm.x86.avx2.vextracti128(<4 x i64> %a0, i8 7)
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.avx2.vextracti128(<4 x i64>, i8) nounwind readnone


define <4 x i64> @test_x86_avx2_vinserti128(<4 x i64> %a0, <2 x i64> %a1) {
; X86-LABEL: test_x86_avx2_vinserti128:
; X86:       ## %bb.0:
; X86-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vinserti128:
; X64:       ## %bb.0:
; X64-NEXT:    vinsertf128 $1, %xmm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.vinserti128(<4 x i64> %a0, <2 x i64> %a1, i8 7)
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.vinserti128(<4 x i64>, <2 x i64>, i8) nounwind readnone


define <4 x double> @test_x86_avx2_vbroadcast_sd_pd_256(<2 x double> %a0) {
; X86-LABEL: test_x86_avx2_vbroadcast_sd_pd_256:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastsd %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vbroadcast_sd_pd_256:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastsd %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x double> @llvm.x86.avx2.vbroadcast.sd.pd.256(<2 x double> %a0)
  ret <4 x double> %res
}
declare <4 x double> @llvm.x86.avx2.vbroadcast.sd.pd.256(<2 x double>) nounwind readonly


define <4 x float> @test_x86_avx2_vbroadcast_ss_ps(<4 x float> %a0) {
; X86-LABEL: test_x86_avx2_vbroadcast_ss_ps:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastss %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vbroadcast_ss_ps:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastss %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <4 x float> @llvm.x86.avx2.vbroadcast.ss.ps(<4 x float> %a0)
  ret <4 x float> %res
}
declare <4 x float> @llvm.x86.avx2.vbroadcast.ss.ps(<4 x float>) nounwind readonly


define <8 x float> @test_x86_avx2_vbroadcast_ss_ps_256(<4 x float> %a0) {
; X86-LABEL: test_x86_avx2_vbroadcast_ss_ps_256:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastss %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vbroadcast_ss_ps_256:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastss %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x float> @llvm.x86.avx2.vbroadcast.ss.ps.256(<4 x float> %a0)
  ret <8 x float> %res
}
declare <8 x float> @llvm.x86.avx2.vbroadcast.ss.ps.256(<4 x float>) nounwind readonly


define <16 x i8> @test_x86_avx2_pbroadcastb_128(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastb_128:
; X86:       ## %bb.0:
; X86-NEXT:    vpbroadcastb %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastb_128:
; X64:       ## %bb.0:
; X64-NEXT:    vpbroadcastb %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <16 x i8> @llvm.x86.avx2.pbroadcastb.128(<16 x i8> %a0)
  ret <16 x i8> %res
}
declare <16 x i8> @llvm.x86.avx2.pbroadcastb.128(<16 x i8>) nounwind readonly


define <32 x i8> @test_x86_avx2_pbroadcastb_256(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastb_256:
; X86:       ## %bb.0:
; X86-NEXT:    vpbroadcastb %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastb_256:
; X64:       ## %bb.0:
; X64-NEXT:    vpbroadcastb %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pbroadcastb.256(<16 x i8> %a0)
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pbroadcastb.256(<16 x i8>) nounwind readonly


define <8 x i16> @test_x86_avx2_pbroadcastw_128(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastw_128:
; X86:       ## %bb.0:
; X86-NEXT:    vpbroadcastw %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastw_128:
; X64:       ## %bb.0:
; X64-NEXT:    vpbroadcastw %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <8 x i16> @llvm.x86.avx2.pbroadcastw.128(<8 x i16> %a0)
  ret <8 x i16> %res
}
declare <8 x i16> @llvm.x86.avx2.pbroadcastw.128(<8 x i16>) nounwind readonly


define <16 x i16> @test_x86_avx2_pbroadcastw_256(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastw_256:
; X86:       ## %bb.0:
; X86-NEXT:    vpbroadcastw %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastw_256:
; X64:       ## %bb.0:
; X64-NEXT:    vpbroadcastw %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pbroadcastw.256(<8 x i16> %a0)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pbroadcastw.256(<8 x i16>) nounwind readonly


define <4 x i32> @test_x86_avx2_pbroadcastd_128(<4 x i32> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastd_128:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastss %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastd_128:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastss %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <4 x i32> @llvm.x86.avx2.pbroadcastd.128(<4 x i32> %a0)
  ret <4 x i32> %res
}
declare <4 x i32> @llvm.x86.avx2.pbroadcastd.128(<4 x i32>) nounwind readonly


define <8 x i32> @test_x86_avx2_pbroadcastd_256(<4 x i32> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastd_256:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastss %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastd_256:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastss %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pbroadcastd.256(<4 x i32> %a0)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pbroadcastd.256(<4 x i32>) nounwind readonly


define <2 x i64> @test_x86_avx2_pbroadcastq_128(<2 x i64> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastq_128:
; X86:       ## %bb.0:
; X86-NEXT:    vpbroadcastq %xmm0, %xmm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastq_128:
; X64:       ## %bb.0:
; X64-NEXT:    vpbroadcastq %xmm0, %xmm0
; X64-NEXT:    retq
  %res = call <2 x i64> @llvm.x86.avx2.pbroadcastq.128(<2 x i64> %a0)
  ret <2 x i64> %res
}
declare <2 x i64> @llvm.x86.avx2.pbroadcastq.128(<2 x i64>) nounwind readonly


define <4 x i64> @test_x86_avx2_pbroadcastq_256(<2 x i64> %a0) {
; X86-LABEL: test_x86_avx2_pbroadcastq_256:
; X86:       ## %bb.0:
; X86-NEXT:    vbroadcastsd %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pbroadcastq_256:
; X64:       ## %bb.0:
; X64-NEXT:    vbroadcastsd %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pbroadcastq.256(<2 x i64> %a0)
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pbroadcastq.256(<2 x i64>) nounwind readonly


define <8 x i32> @test_x86_avx2_pmovsxbd(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxbd:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxbd %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxbd:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxbd %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmovsxbd(<16 x i8> %a0) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmovsxbd(<16 x i8>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovsxbq(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxbq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxbq %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxbq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxbq %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovsxbq(<16 x i8> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovsxbq(<16 x i8>) nounwind readnone


define <16 x i16> @test_x86_avx2_pmovsxbw(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxbw:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxbw %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxbw:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxbw %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pmovsxbw(<16 x i8> %a0) ; <<8 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pmovsxbw(<16 x i8>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovsxdq(<4 x i32> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxdq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxdq %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxdq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxdq %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovsxdq(<4 x i32> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovsxdq(<4 x i32>) nounwind readnone


define <8 x i32> @test_x86_avx2_pmovsxwd(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxwd:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxwd %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxwd:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxwd %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmovsxwd(<8 x i16> %a0) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmovsxwd(<8 x i16>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovsxwq(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pmovsxwq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovsxwq %xmm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovsxwq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovsxwq %xmm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovsxwq(<8 x i16> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovsxwq(<8 x i16>) nounwind readnone


define <8 x i32> @test_x86_avx2_pmovzxbd(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxbd:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxbd {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero,xmm0[4],zero,zero,zero,xmm0[5],zero,zero,zero,xmm0[6],zero,zero,zero,xmm0[7],zero,zero,zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxbd:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxbd {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero,xmm0[4],zero,zero,zero,xmm0[5],zero,zero,zero,xmm0[6],zero,zero,zero,xmm0[7],zero,zero,zero
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmovzxbd(<16 x i8> %a0) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmovzxbd(<16 x i8>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovzxbq(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxbq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxbq {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero,xmm0[2],zero,zero,zero,zero,zero,zero,zero,xmm0[3],zero,zero,zero,zero,zero,zero,zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxbq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxbq {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,zero,zero,zero,zero,xmm0[1],zero,zero,zero,zero,zero,zero,zero,xmm0[2],zero,zero,zero,zero,zero,zero,zero,xmm0[3],zero,zero,zero,zero,zero,zero,zero
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovzxbq(<16 x i8> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovzxbq(<16 x i8>) nounwind readnone


define <16 x i16> @test_x86_avx2_pmovzxbw(<16 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxbw:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxbw {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero,xmm0[8],zero,xmm0[9],zero,xmm0[10],zero,xmm0[11],zero,xmm0[12],zero,xmm0[13],zero,xmm0[14],zero,xmm0[15],zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxbw:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxbw {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero,xmm0[8],zero,xmm0[9],zero,xmm0[10],zero,xmm0[11],zero,xmm0[12],zero,xmm0[13],zero,xmm0[14],zero,xmm0[15],zero
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pmovzxbw(<16 x i8> %a0) ; <<16 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pmovzxbw(<16 x i8>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovzxdq(<4 x i32> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxdq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxdq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxdq {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovzxdq(<4 x i32> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovzxdq(<4 x i32>) nounwind readnone


define <8 x i32> @test_x86_avx2_pmovzxwd(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxwd:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxwd:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxwd {{.*#+}} ymm0 = xmm0[0],zero,xmm0[1],zero,xmm0[2],zero,xmm0[3],zero,xmm0[4],zero,xmm0[5],zero,xmm0[6],zero,xmm0[7],zero
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmovzxwd(<8 x i16> %a0) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmovzxwd(<8 x i16>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmovzxwq(<8 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pmovzxwq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmovzxwq {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmovzxwq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmovzxwq {{.*#+}} ymm0 = xmm0[0],zero,zero,zero,xmm0[1],zero,zero,zero,xmm0[2],zero,zero,zero,xmm0[3],zero,zero,zero
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmovzxwq(<8 x i16> %a0) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmovzxwq(<8 x i16>) nounwind readnone

; This is checked here because the execution dependency fix pass makes it hard to test in AVX mode since we don't have 256-bit integer instructions
define void @test_x86_avx_storeu_dq_256(i8* %a0, <32 x i8> %a1) {
  ; add operation forces the execution domain.
; X86-LABEL: test_x86_avx_storeu_dq_256:
; X86:       ## %bb.0:
; X86-NEXT:    movl {{[0-9]+}}(%esp), %eax
; X86-NEXT:    vpcmpeqd %ymm1, %ymm1, %ymm1
; X86-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; X86-NEXT:    vmovdqu %ymm0, (%eax)
; X86-NEXT:    vzeroupper
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx_storeu_dq_256:
; X64:       ## %bb.0:
; X64-NEXT:    vpcmpeqd %ymm1, %ymm1, %ymm1
; X64-NEXT:    vpsubb %ymm1, %ymm0, %ymm0
; X64-NEXT:    vmovdqu %ymm0, (%rdi)
; X64-NEXT:    vzeroupper
; X64-NEXT:    retq
  %a2 = add <32 x i8> %a1, <i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1, i8 1>
  call void @llvm.x86.avx.storeu.dq.256(i8* %a0, <32 x i8> %a2)
  ret void
}
declare void @llvm.x86.avx.storeu.dq.256(i8*, <32 x i8>) nounwind

define <32 x i8> @mm256_max_epi8(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: mm256_max_epi8:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epi8:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxsb %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pmaxs.b(<32 x i8> %a0, <32 x i8> %a1)
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pmaxs.b(<32 x i8>, <32 x i8>) nounwind readnone

define <16 x i16> @mm256_max_epi16(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: mm256_max_epi16:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epi16:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxsw %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pmaxs.w(<16 x i16> %a0, <16 x i16> %a1)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pmaxs.w(<16 x i16>, <16 x i16>) nounwind readnone

define <8 x i32> @mm256_max_epi32(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: mm256_max_epi32:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epi32:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxsd %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmaxs.d(<8 x i32> %a0, <8 x i32> %a1)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmaxs.d(<8 x i32>, <8 x i32>) nounwind readnone

define <32 x i8> @mm256_max_epu8(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: mm256_max_epu8:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxub %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epu8:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxub %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pmaxu.b(<32 x i8> %a0, <32 x i8> %a1)
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pmaxu.b(<32 x i8>, <32 x i8>) nounwind readnone

define <16 x i16> @mm256_max_epu16(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: mm256_max_epu16:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxuw %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epu16:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxuw %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pmaxu.w(<16 x i16> %a0, <16 x i16> %a1)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pmaxu.w(<16 x i16>, <16 x i16>) nounwind readnone

define <8 x i32> @mm256_max_epu32(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: mm256_max_epu32:
; X86:       ## %bb.0:
; X86-NEXT:    vpmaxud %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_max_epu32:
; X64:       ## %bb.0:
; X64-NEXT:    vpmaxud %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmaxu.d(<8 x i32> %a0, <8 x i32> %a1)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmaxu.d(<8 x i32>, <8 x i32>) nounwind readnone

define <32 x i8> @mm256_min_epi8(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: mm256_min_epi8:
; X86:       ## %bb.0:
; X86-NEXT:    vpminsb %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epi8:
; X64:       ## %bb.0:
; X64-NEXT:    vpminsb %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pmins.b(<32 x i8> %a0, <32 x i8> %a1)
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pmins.b(<32 x i8>, <32 x i8>) nounwind readnone

define <16 x i16> @mm256_min_epi16(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: mm256_min_epi16:
; X86:       ## %bb.0:
; X86-NEXT:    vpminsw %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epi16:
; X64:       ## %bb.0:
; X64-NEXT:    vpminsw %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pmins.w(<16 x i16> %a0, <16 x i16> %a1)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pmins.w(<16 x i16>, <16 x i16>) nounwind readnone

define <8 x i32> @mm256_min_epi32(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: mm256_min_epi32:
; X86:       ## %bb.0:
; X86-NEXT:    vpminsd %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epi32:
; X64:       ## %bb.0:
; X64-NEXT:    vpminsd %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pmins.d(<8 x i32> %a0, <8 x i32> %a1)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pmins.d(<8 x i32>, <8 x i32>) nounwind readnone

define <32 x i8> @mm256_min_epu8(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: mm256_min_epu8:
; X86:       ## %bb.0:
; X86-NEXT:    vpminub %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epu8:
; X64:       ## %bb.0:
; X64-NEXT:    vpminub %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pminu.b(<32 x i8> %a0, <32 x i8> %a1)
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pminu.b(<32 x i8>, <32 x i8>) nounwind readnone

define <16 x i16> @mm256_min_epu16(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: mm256_min_epu16:
; X86:       ## %bb.0:
; X86-NEXT:    vpminuw %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epu16:
; X64:       ## %bb.0:
; X64-NEXT:    vpminuw %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pminu.w(<16 x i16> %a0, <16 x i16> %a1)
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pminu.w(<16 x i16>, <16 x i16>) nounwind readnone

define <8 x i32> @mm256_min_epu32(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: mm256_min_epu32:
; X86:       ## %bb.0:
; X86-NEXT:    vpminud %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_min_epu32:
; X64:       ## %bb.0:
; X64-NEXT:    vpminud %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pminu.d(<8 x i32> %a0, <8 x i32> %a1)
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pminu.d(<8 x i32>, <8 x i32>) nounwind readnone

define <32 x i8> @mm256_avg_epu8(<32 x i8> %a0, <32 x i8> %a1) {
; X86-LABEL: mm256_avg_epu8:
; X86:       ## %bb.0:
; X86-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_avg_epu8:
; X64:       ## %bb.0:
; X64-NEXT:    vpavgb %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pavg.b(<32 x i8> %a0, <32 x i8> %a1) ; <<32 x i8>> [#uses=1]
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pavg.b(<32 x i8>, <32 x i8>) nounwind readnone

define <16 x i16> @mm256_avg_epu16(<16 x i16> %a0, <16 x i16> %a1) {
; X86-LABEL: mm256_avg_epu16:
; X86:       ## %bb.0:
; X86-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: mm256_avg_epu16:
; X64:       ## %bb.0:
; X64-NEXT:    vpavgw %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pavg.w(<16 x i16> %a0, <16 x i16> %a1) ; <<16 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pavg.w(<16 x i16>, <16 x i16>) nounwind readnone

define <32 x i8> @test_x86_avx2_pabs_b(<32 x i8> %a0) {
; X86-LABEL: test_x86_avx2_pabs_b:
; X86:       ## %bb.0:
; X86-NEXT:    vpabsb %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pabs_b:
; X64:       ## %bb.0:
; X64-NEXT:    vpabsb %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <32 x i8> @llvm.x86.avx2.pabs.b(<32 x i8> %a0) ; <<32 x i8>> [#uses=1]
  ret <32 x i8> %res
}
declare <32 x i8> @llvm.x86.avx2.pabs.b(<32 x i8>) nounwind readnone

define <8 x i32> @test_x86_avx2_pabs_d(<8 x i32> %a0) {
; X86-LABEL: test_x86_avx2_pabs_d:
; X86:       ## %bb.0:
; X86-NEXT:    vpabsd %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pabs_d:
; X64:       ## %bb.0:
; X64-NEXT:    vpabsd %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <8 x i32> @llvm.x86.avx2.pabs.d(<8 x i32> %a0) ; <<8 x i32>> [#uses=1]
  ret <8 x i32> %res
}
declare <8 x i32> @llvm.x86.avx2.pabs.d(<8 x i32>) nounwind readnone


define <16 x i16> @test_x86_avx2_pabs_w(<16 x i16> %a0) {
; X86-LABEL: test_x86_avx2_pabs_w:
; X86:       ## %bb.0:
; X86-NEXT:    vpabsw %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pabs_w:
; X64:       ## %bb.0:
; X64-NEXT:    vpabsw %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <16 x i16> @llvm.x86.avx2.pabs.w(<16 x i16> %a0) ; <<16 x i16>> [#uses=1]
  ret <16 x i16> %res
}
declare <16 x i16> @llvm.x86.avx2.pabs.w(<16 x i16>) nounwind readnone


define <4 x i64> @test_x86_avx2_vperm2i128(<4 x i64> %a0, <4 x i64> %a1) {
; X86-LABEL: test_x86_avx2_vperm2i128:
; X86:       ## %bb.0:
; X86-NEXT:    vpermpd {{.*#+}} ymm0 = ymm0[2,3,0,1]
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_vperm2i128:
; X64:       ## %bb.0:
; X64-NEXT:    vpermpd {{.*#+}} ymm0 = ymm0[2,3,0,1]
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.vperm2i128(<4 x i64> %a0, <4 x i64> %a1, i8 1) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.vperm2i128(<4 x i64>, <4 x i64>, i8) nounwind readonly


define <4 x i64> @test_x86_avx2_pmulu_dq(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: test_x86_avx2_pmulu_dq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmulu_dq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmuludq %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmulu.dq(<8 x i32> %a0, <8 x i32> %a1) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmulu.dq(<8 x i32>, <8 x i32>) nounwind readnone


define <4 x i64> @test_x86_avx2_pmul_dq(<8 x i32> %a0, <8 x i32> %a1) {
; X86-LABEL: test_x86_avx2_pmul_dq:
; X86:       ## %bb.0:
; X86-NEXT:    vpmuldq %ymm1, %ymm0, %ymm0
; X86-NEXT:    retl
;
; X64-LABEL: test_x86_avx2_pmul_dq:
; X64:       ## %bb.0:
; X64-NEXT:    vpmuldq %ymm1, %ymm0, %ymm0
; X64-NEXT:    retq
  %res = call <4 x i64> @llvm.x86.avx2.pmul.dq(<8 x i32> %a0, <8 x i32> %a1) ; <<4 x i64>> [#uses=1]
  ret <4 x i64> %res
}
declare <4 x i64> @llvm.x86.avx2.pmul.dq(<8 x i32>, <8 x i32>) nounwind readnone
