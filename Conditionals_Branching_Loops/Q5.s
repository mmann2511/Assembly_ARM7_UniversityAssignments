.global _start
_start:
	@ Homework 4 Question 5
	
	ldr r0, =0x10002030		@ memory location
	mov r1, #0				@ initialize s to 0	(sum and addends)	
	mov r2, #0				@ initialize i to 0 (counter)
	mov r3, #0				@ initialize to 0 (multiplier)
	
loop:
	
	cmp r2, #10				@ compare counter(r2) and #10
	BGE stop				@ stop the loop once r2 is equal to or greater than #10
	mul r3, r2, r2			@ r3 = i * i or (r2 * r2)
	add r1, r1, r3			@ r1(s) = s + r3
	str r1, [r0]			@ store r1 at memory location r0
	add r2, r2, #1			@ increase counter by 1
	B loop
	
	@ total should be 285
	
	
	
	
	
	
stop:
	B stop 
	
.end