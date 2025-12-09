.global _start
_start:
	@ Question 2 Homework #5

	mov r0, #10			@ array size
	mov r1, #0			@ highest value so far
	
	ldr r3, =myArray	@ base location of myArray
	
	mov r4, #0			@ index counter
	
	
loop:
	ldr r2, [r3, r4, lsl #2]		@ load myArray[r4] into temporary location [r2]
	
	cmp r2, r1						@ compare new value to old value
	movgt r1, r2					@ if new value greater than, move into [r1]
	
	add r4, r4, #1					@ increment index
	cmp r4, r0						@ compare index with length of array
	BLT loop						@ loop while r4 < 10


stop:
	B	stop

.data
	myArray:	.word	34, 92, 45, 52, 93, 25, 52, 82, 53, 92