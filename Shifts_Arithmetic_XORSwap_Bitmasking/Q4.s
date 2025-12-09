.global _start
_start:
	@ Question 4 Homework 3
	
	ldr r1, =0x168cbf12				@ loading any random value into r1 (r1 should change to 0x140cbf12)
	bic r1, r1, #0x03f00000			@ clearing bits 25-20 (0011 1111)
	
	
	
stop:
	B stop 
	
.end