.global _start
_start:
	@ Question 6 Homework 3
	
	
	ldr r0, =0xb4b3b2b1			@ after toggling and clearing r0 should = b44c00b1
	
	eor r0, r0, #0x00ff0000		@ use eor to toggle b3. b3 = 10110011...toggle...01001100 = 4c
	
	bic r0, r0, #0x0000ff00		@ use bic to clear b2
	
	
	
stop:
	B stop 
	
.end