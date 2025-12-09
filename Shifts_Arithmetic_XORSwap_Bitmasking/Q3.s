.global _start
_start:
	@ Question 3 Homework 3
	
	@ #33 = 2^5 + 1
	mov r0, #2			@ Test number (should come out 2 * 33 = 66)
	lsl r1, r0, #5		@ R1 = R0 * 32 (shift left by 5)
	add r0, r1, r0		@ R0 = R1 + R0 (R0 x 32) + (R0 x 1)
	
	@ #1025 = 2^10 + 1
	mov r0, #7			@ Test number (should come out 7 * 1025 = 7175)
	lsl r1, r0, #10		@ R1 = R0 * 1024 (shift left by 10)
	add r0, r1, r0		@ R0 = R1 + R0 (R0 x 1024) + (R0 x 1)
	
	@ #4095 = 2^12 - 1
	mov r0, #5			@ Test number (should come out 5 * 4095 = 20,475)
	lsl r1, r0, #12		@ R1 = R0 * 4096 (shift left by 12)
	subs r0, r1, r0		@ R0 = R1 - R0 (R0 x 4096) - (R0 x 1)
	
stop:
	B stop 
	
.end