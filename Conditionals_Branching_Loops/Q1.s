.global _start
_start:
	@ Homework 4 Question 1
	
	mov r0, #5		@ integer x
	
	cmp r0, #0		@ compare r0 with #0
	movlt r1, #-1	@ if x is less than 0, r1(y) = -1
	moveq r1, #0	@ if x is equal to 0, r1(y) = 0
	movgt r1, #1	@ if x is greater than 0, r1(y) = 1
	
	
	
stop:
	B stop 
	
.end