.global _start
_start:
	@ Homework 4 Question 3
	
	ldr r0, =0x10002010		@ memory location
	mov r1, #1000			@ set up counter			
	mov r2, #0				@ initialize sum to 0
	
loop:
	
	add r2, r1, r2			@ r2 += r1 and r2 (add current r1 number to sum)
	str r2, [r0]			@ store r2 at memory location r0
	subs r1, r1, #2			@ decrement counter by 2 for even numbers
	BNE loop
	
	@ total should be 250500 
	
	
	
	
	
	
stop:
	B stop 
	
.end