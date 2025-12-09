.global _start
_start:
	@ Homework 4 Question 2
	
	mov r0, #1010		@ integer x
	
	cmp r0, #10			@ compare r0(x) and #10
	movle r2, #9		@ if x is less than 10 move #9 to r2
	mulle r1, r2, r0	@ if x is less than 10 then (r1 = 9 * x)
	ble stop			@ if x is less than 10 jump to stop
	
	
	@ if x is greater than 10 AND less than or equal to #100
	cmp r0, #10			@ compare x and #10
	cmpgt r0, #100		@ if x is greater than #10, compare x and #100
	movle r2, #8		@ if x is less than 100, move #8 to r2
	mulle r1, r2, r0	@ if x if less than 100, r1 = (8 * x)
	ble stop			@ if x is less than 100 jump to stop
	
	
	@ if x is greater than 10 and less than or equal to 1000
	cmp r0, #10			@ compare x and #10
	cmpgt r0, #1000		@ if x is greater than #10, compare x and #1000
	movle r2, #7		@ if x is less than #1000 move #7 to r2
	mulle r1, r2, r0	@ if x is less than #1000 r1 = (7 * x)
	ble stop			@ if x is less than #1000 jump to stop
	
	@ if x is greater than 1000
	cmp r0, #1000		@ compare x and #1000
	movgt r2, #6		@ if x greater than #1000 move #6 to r2
	mulgt r1, r2, r0	@ if x greater than #1000 r1 = (6 * x)
	
	
	
	
stop:
	B stop 
	
.end