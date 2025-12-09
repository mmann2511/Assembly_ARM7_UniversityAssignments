.global _start
_start:
	@ Homework 4 Question 4
	
	ldr r0, =0x10002020		@ memory location
	mov r1, #11				@ set up counter			
	mov r2, #1				@ initialize sum to 1, to start with 11 (11 * 1)
	
loop:
	
	mul r2, r1, r2			@ r2 = r1 * r2 (multiply current r1 number to r2)
	str r2, [r0]			@ store r2 at memory location r0
	subs r1, r1, #1			@ decrement counter by 1 for (11!)(11*10*9*8....)
	BNE loop
	
	@ total should be 39,916,800 
	
	
	
	
	
	
stop:
	B stop 
	
.end