.global _start
_start:
	@ Question #2, Homework #7
	@ Using the right most seven-segment display
	@ Display 0-9 with a 1 second time delay
	
	ldr r0, =0xff200020		@ 7 segment display base
	ldr r1, =0xfffec600		@ timer base
	ldr r2, =200000000		@ timeout = 1 sec
	str r2, [r1]			@ load timeout to timer
	mov r2, #0b011			@ set timer control bits
	str r2, [r1, #8]		@ write to timer register
	
	@ Index through myNumbers
	ldr r3, =myNumbers		@ base location of myNumbers
	mov r4, #0				@ index counter
	
	
	
	
wait:
	@ Timer
	ldr r2, [r1, #12]		@ read timer
	cmp r2, #1				
	BNE wait				@ keep branching when timer != 1
	str r2, [r1, #12]		@ reset timer flag bit
	@ Loop through array
	ldrb r5, [r3, r4]		@ load next item in myNumbers
	str r5, [r0]			@ display it on 7-segment
	add r4, r4, #1			@ index++
	cmp r4, #10				@ compare with myNumbers.length
	moveq r4, #0			@ if equal, reset and do it again
	
	B wait					@ then loop normal
	
	
	
stop:
	B stop

.data
	myNumbers:		.byte	0x3f, 0x6, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x27, 0x7f, 0x67	