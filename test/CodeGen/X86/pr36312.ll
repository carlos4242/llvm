; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

%struct.anon = type { i32, i32 }

@c = common  global %struct.anon zeroinitializer, align 4
@d =  local_unnamed_addr global %struct.anon* @c, align 8
@a = common  local_unnamed_addr global i32 0, align 4
@b = common  local_unnamed_addr global i32 0, align 4

; Function Attrs: norecurse nounwind uwtable
define  void @g() local_unnamed_addr #0 {
; CHECK-LABEL: g:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movq {{.*}}(%rip), %rax
; CHECK-NEXT:    movl {{.*}}(%rip), %ecx
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    incl %ecx
; CHECK-NEXT:    setne %dl
; CHECK-NEXT:    addl 4(%rax), %edx
; CHECK-NEXT:    movl %ecx, {{.*}}(%rip)
; CHECK-NEXT:    movl %edx, {{.*}}(%rip)
; CHECK-NEXT:    retq
entry:
  %0 = load %struct.anon*, %struct.anon** @d, align 8
  %y = getelementptr inbounds %struct.anon, %struct.anon* %0, i64 0, i32 1
  %1 = load i32, i32* %y, align 4
  %2 = load i32, i32* @b, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, i32* @b, align 4
  %tobool = icmp ne i32 %inc, 0
  %land.ext = zext i1 %tobool to i32
  %add = add nsw i32 %1, %land.ext
  store i32 %add, i32* @a, align 4
  ret void
}
