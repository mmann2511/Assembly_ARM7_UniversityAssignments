.global _start
_start:
	@ Question 1 Homework 3
	
	mov r0, #0x33		@ r0 = 0x33 (0x00000033)
	
	ror r1, r0, #28		@ r1 = 0x00000330 (4 bits = 1 hex)(32-4 = 28 to the right)
	
	ror r2, r0, #24		@ r2 = 0x00003300 (8 bits = 2 hex) (32-8 = 24 to the right)
	
	ror r3, r0, #20		@ r3 = 0x00033000 (12 bits = 3 hex) (32-12 = 20 to the right)


stop:
	B stop 
	
.end