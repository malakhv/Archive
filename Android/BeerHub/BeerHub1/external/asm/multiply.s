 // This file is multiply.s
  .text
  .align  2
  .global  multiply
  .type  multiply, %function
multiply:
  // Multiply by 3. Input value and return value in r0
  //stmfd  sp, {fp-ip,lr}
  //mul  r0, r1, r0
  //ldmfd  sp!, {fp,ip,lr}
  //bx  lr
  //movl r1,r2
  movl 0x5, %%edi;
  movl $0x5,%r0
.size  multiply, .-multiply