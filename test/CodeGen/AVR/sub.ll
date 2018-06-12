; RUN: llc < %s -march=avr | FileCheck %s

define i8 @sub8_reg_reg(i8 %a, i8 %b) {
; CHECK-LABEL: sub8_reg_reg:
; CHECK: sub r24, r22
    %result = sub i8 %a, %b
    ret i8 %result
}

define i8 @sub8_reg_imm(i8 %a) {
; CHECK-LABEL: sub8_reg_imm:
; CHECK: subi r24, 5
    %result = sub i8 %a, 5
    ret i8 %result
}

define i8 @sub8_reg_decrement(i8 %a) {
; CHECK-LABEL: sub8_reg_decrement:
; CHECK: dec r24
    %result = sub i8 %a, 1
    ret i8 %result
}

define i16 @sub16_reg_reg(i16 %a, i16 %b) {
; CHECK-LABEL: sub16_reg_reg:
; CHECK: sub r24, r22
; CHECK: sbc r25, r23
    %result = sub i16 %a, %b
    ret i16 %result
}

define i16 @sub16_reg_imm(i16 %a) {
; CHECK-LABEL: sub16_reg_imm:
; CHECK: sbiw r24, 63
    %result = sub i16 %a, 63
    ret i16 %result
}

define i16 @sub16_reg_imm_subi(i16 %a) {
; CHECK-LABEL: sub16_reg_imm_subi:
; CHECK: subi r24, 210
; CHECK: sbci r25, 4
    %result = sub i16 %a, 1234
    ret i16 %result
}

define i32 @sub32_reg_reg(i32 %a, i32 %b) {
; CHECK-LABEL: sub32_reg_reg:
; CHECK: sub r24, r20
; CHECK: sbc r25, r21
; CHECK: sbc r25, r31
; CHECK: sbc r23, r19
    %result = sub i32 %a, %b
    ret i32 %result
}

define i32 @sub32_reg_imm(i32 %a) {
; CHECK-LABEL: sub32_reg_imm:
; CHECK: subi r24, 91
; CHECK: sbci r25, 7
; CHECK: subi r22, 21
; CHECK: sbci r23, 205
    %result = sub i32 %a, 123456789
    ret i32 %result
}

define i64 @sub64_reg_reg(i64 %a, i64 %b) {
; CHECK-LABEL: sub64_reg_reg:
; CHECK: sbc r23, r15
; CHECK: sbc r23, r9
; CHECK: sbc r25, r17
; CHECK: sbc r25, r31
; CHECK: sbc r25, r7
; CHECK: sbc r21, r13
; CHECK: sbc r21, r31
; CHECK: sbc r19, r11
    %result = sub i64 %a, %b
    ret i64 %result
}

define i64 @sub64_reg_imm(i64 %a) {
; CHECK-LABEL: sub64_reg_imm:
; CHECK: sbci r23, 22
; CHECK: sbc r23, r15
; CHECK: sbci r25, 190
; CHECK: sbc r25, r31
; CHECK: sbc r25, r13
; CHECK: sbci r21, 37
; CHECK: sbc r21, r31
; CHECK: sbci r19, 204
    %result = sub i64 %a, 13757395258967641292
    ret i64 %result
}
