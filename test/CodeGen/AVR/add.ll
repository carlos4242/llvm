; RUN: llc -mattr=addsubiw < %s -march=avr | FileCheck %s

define i8 @add8_reg_reg(i8 %a, i8 %b) {
; CHECK-LABEL: add8_reg_reg:
; CHECK: add r24, r22
    %result = add i8 %a, %b
    ret i8 %result
}

define i8 @add8_reg_imm(i8 %a) {
; CHECK-LABEL: add8_reg_imm:
; CHECK: subi r24, -5
    %result = add i8 %a, 5
    ret i8 %result
}

define i8 @add8_reg_increment(i8 %a) {
; CHECK-LABEL: add8_reg_increment:
; CHECK: inc r24
    %result = add i8 %a, 1
    ret i8 %result
}


define i16 @add16_reg_reg(i16 %a, i16 %b) {
; CHECK-LABEL: add16_reg_reg:
; CHECK: add r24, r22
; CHECK: adc r25, r23
    %result = add i16 %a, %b
    ret i16 %result
}

define i16 @add16_reg_imm(i16 %a) {
; CHECK-LABEL: add16_reg_imm:
; CHECK: adiw r24, 63
    %result = add i16 %a, 63
    ret i16 %result
}

define i16 @add16_reg_imm_subi(i16 %a) {
; CHECK-LABEL: add16_reg_imm_subi:
; CHECK: subi r24, 133
; CHECK: sbci r25, 255
    %result = add i16 %a, 123
    ret i16 %result
}

define i32 @add32_reg_reg(i32 %a, i32 %b) {
; CHECK-LABEL: add32_reg_reg:
; CHECK: add r24, r20
; CHECK: adc r25, r21
; CHECK: adc r19, r23
; CHECK: adc r25, r21
    %result = add i32 %a, %b
    ret i32 %result
}

define i32 @add32_reg_imm(i32 %a) {
; CHECK-LABEL: add32_reg_imm:
; CHECK: adiw r24, 1
; CHECK: sub r24, r18
; CHECK: sbc r25, r19
; CHECK: adiw r30, 5
    %result = add i32 %a, 5
    ret i32 %result
}

define i64 @add64_reg_reg(i64 %a, i64 %b) {
; CHECK-LABEL: add64_reg_reg:
; CHECK: add r14, r22
; CHECK: adc r15, r23
; CHECK: adc r13, r21
; CHECK: adc r11, r19
; CHECK: adc r25, r17
; CHECK: adc r13, r27
; CHECK: adc r25, r23
; CHECK: adc r23, r15
; CHECK: adc r25, r19
    %result = add i64 %a, %b
    ret i64 %result
}

define i64 @add64_reg_imm(i64 %a) {
; CHECK-LABEL: add64_reg_imm:
; CHECK: sub r26, r16
; CHECK: sbc r27, r17
; CHECK: sub r24, r22
; CHECK: sbc r25, r23
; CHECK: sub r24, r14
; CHECK: sbc r25, r15
; CHECK: sub r30, r18
; CHECK: sbc r31, r19
    %result = add i64 %a, 5
    ret i64 %result
}
