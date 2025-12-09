
.global _start
_start:
	@ Question 6 Homework #5
	
	mov r0, #0			@ numerator (needs to be the sum of array)
	mov r1, #10			@ denominator (length of array)
	mov r2, #0			@ quotient with inital value 0
	ldr r3, =myArray	@ base location of myArray
	mov r4, #0			@ index
	ldr r8, =0x10001000	@ memory location
	
loop:
	ldr r5, [r3, r4, lsl #2]	@ r5 = temp location of myArray[r4]
	add r0, r0, r5				@ r0 += myArray[r4] 
	add r4, r4, #1
	cmp r4, r1
	BLT loop						@ while index < myArray.length
	
	BL div

stop:
	B stop
/*
div() function
Parameters: R0 (numerator), R1 (denominator)
Return values: R0 (quotient), R1 (remainder)
Store R0 (quotient) in memory at 0x10001000
*/

	
div:
	mov r2, #0			@ temporary register for quotient
div_loop:	
	cmp r0, r1
	BLT end_div
	sub r0, r0, r1		@ numerator - denominator
	add r2, r2, #1		@ increase the number of subtraction
	B div_loop

end_div:
	mov r1, r0			@ move remainder to r1
	mov r0, r2			@ move quotient to r0
	str r0, [r8]
	BX LR
	
	

.data
	myArray:	.word	298, 104, 841, 903, 492, 325, 23, 1200, 750, 24		@ sum is 4,960, avg = 496