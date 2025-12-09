.global _start
_start:
    @ Homework Question 2
    ldr r0, =0x20000030     @ memory location
    ldr r1, =0x20000038     @ memory location
    ldr r2, =a              @ address of a
    ldr r2, [r2]            @ r2 = value of a
    ldr r3, =b              @ address of b
    ldr r3, [r3]            @ r3 = value of b
    str r2, [r0]            @ stores a at r0 location
    str r3, [r1]            @ stores b at r1 location
    add r9, r2, r3          @ R9 = R0 + R1 = 0x335589EE
stop:
    B stop

.data
a:  .word    0x10102265
b:  .word    0x23456789

.end