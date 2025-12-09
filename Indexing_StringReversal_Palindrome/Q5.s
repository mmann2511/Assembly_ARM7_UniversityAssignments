.global _start
_start:
	@ Question 5 Homework #5
	@ Palindrome Check
	
	ldr r0, =myString			@ base location of myString
	mov r2, #0					@ index 1 [end]
	mov r3, #0					@ index 2 [start]
		
loop1:
	ldrb r1, [r0, r2]				@ load as byte myString[r2]
	cmp r1, #0						@ compare string value to #0(end of string)
	BEQ reverse_loop				@ once end of string reached - branch to reverse loop
	add r2, r2, #1					@ add 1 to counter to loop through string
	b loop1

reverse_loop:
	subs r2, r2, #1					@ index1-- [9..8...7..6], skipping the null first
	ldrb r4, [r0, r3]				@ r4 = myString[r3][starts at 0]
	ldrb r5, [r0, r2]				@ r5 = myString[r2][starts at last index]
	cmp r4, r5
	movne r0, #0
	BNE stop
	
	add r3, r3, #1					@ index2++ [0...1...2...3]
	
	cmp r3, r2
	BGE if_palindrome						@ if r3 >= r2, branch to check
	b reverse_loop
	
if_palindrome:
	mov r0, #1
	B stop
	
	


stop:
	B	stop

.data
	myString:	.asciz		"racecar"