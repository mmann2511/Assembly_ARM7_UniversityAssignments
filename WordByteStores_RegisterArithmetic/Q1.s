.global _start
_start:
    @ Homework Question 1
    ldr r0, =0x20000000     @ memory location
    ldr r1, =0x20000004     @ memory location
    ldr r2, =a              @ address of a
    ldrb r2, [r2]           @ r2 = value of a
    ldr r3, =b              @ address of b
    ldrb r3, [r3]           @ r3 = value of b
    str r2, [r0]            @ stores a at r0 location
    str r3, [r1]            @ stores b at r1 location
stop:
    B stop

.data
a:  .byte       0x30        @ 48 in decimal
b:  .byte       0x97        @ 151 in decimal

.end