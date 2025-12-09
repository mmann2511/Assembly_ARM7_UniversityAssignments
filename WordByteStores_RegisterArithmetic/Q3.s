.global _start
_start:
    @ Homework Question 3
    ldr r0, =0x20000010     @ memory location
    ldr r1, =0x20000011     @ memory location

    ldr r2, =a              @ address of a
    ldrb r2, [r2]           @ r2 = value of a

    ldr r3, =b              @ address of b
    ldrb r3, [r3]           @ r3 = value of b

    strb r2, [r0]           @ stores a at r0 location
    strb r3, [r1]           @ stores b at r1 location

    ldr r4, =0x20000020     @ memory location
    strb r3, [r4]           @ stores b at r4 location
    
    ldr r2, [r4]            @ loads word value of r4 to r2
stop:
    B stop

.data    
a:  .byte   0x5A     @ 90 in decimal
b:  .byte   0x21     @ 33 in decimal
.end