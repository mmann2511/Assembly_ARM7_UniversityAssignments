.global _start
_start:
	@ Question #1, Homework #7
	
	ldr r0, =0xff200000		@ LED base
	ldr r1, =0xfffec600		@ timer base
	ldr r2, =0b1000000001	@ value to set LEDs
	ldr r3, =200000000		@ timeout = 1 sec
	str r3, [r1]			@ load timeout to timer
	mov r3, #0b011			@ set timer control bits
	str r3, [r1, #8]		@ write to timer register
	str r2, [r0]			@ load LEDs
	
wait:
	ldr r3, [r1, #12]		@ read timer
	cmp r3, #1				
	BNE wait				@ keep branching when timer != 1
	str r3, [r1, #12]		@ reset timer flag bit
	ldr r4, [r0]			@ read current status of LEDs into temporary register
	eor r4, r4, r2			@ toggle the bits for blinking temporary vs original
	str r4, [r0]			@ store current status into LEDs
	B wait					@ then loop normal
	
stop:
	B stop
	