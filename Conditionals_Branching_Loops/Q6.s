.global _start
_start:
	@ Homework 4 Question 6
	
	ldr r0, =0x10002040		@ memory location
	mov r1, #0				@ initialize s to 0	(sum and addends)	
	mov r2, #0				@ initialize i to 0 (1st counter)
	mov r3, #0				@ initizlize multiplier sum to 0 (i * j)
	
loop1:						@ outerloop
	
	cmp r2, #5				@ compare 1st counter(r2)(i) and #5
	BGE stop				@ end outerloop
	
	mov r4, #0				@ initializing r4(j) to #0
	
loop2:						@ inner loop

	cmp r4, #5				@ compare 2nd counter(r4)(j) and #5
	addge	r2, r2, #1		@ i++ if inner loop ends
	BGE loop1				@ inner loop ends once r4(j) is equal to or greater than #5
	mul r3, r2, r4			@ r3 = (r2(i) * r4(j)) 
	add r1, r1, r3			@ r1(s) = s + r3
	str r1, [r0]			@ store r1 at memory location r0
	add r4, r4, #1			@ increase 2nd counter(j) by 1
	B loop2
	
	@ total should be 100
	
	
	
	
	
	
stop:
	B stop 
	
.end	