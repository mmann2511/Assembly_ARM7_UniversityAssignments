.global _start
_start:
	@ Question 5 Homework 3
	
	mov r0, #0x35
	mov r1, #0x65
	
	eor r0, r0, r1		@ r0 = 35 eor 65 = 50
	eor r1, r0, r1		@ r1 = 50 eor 65 = 35
	eor r0, r0, r1		@ r0 = 50 eor 35 = 65
	
	@ Random Values # 2
	mov r0, #0x93
	mov r1, #0x17
	
	eor r0, r0, r1		@ r0 = 93 eor 17 = 84
	eor r1, r0, r1		@ r1 = 84 eor 17 = 93
	eor r0, r0, r1		@ r0 = 84 eor 93 = 17
	
	
	
stop:
	B stop 
	
.end