.global _start
_start:
	@ Question 4 Homework #5

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
	ldrb r5, [r0, r2]				@ r5 = myString[r2][starts at 9]
	
	strb r4, [r0, r2]				@ store index 0 at index 9
	strb r5, [r0, r3]				@ store index 9 at index 0
	
	add r3, r3, #1					@ index2++ [0...1...2...3]
	
	cmp r3, r2
	BGE stop						@ if r3 >= r2, stop
	
	b reverse_loop
	


stop:
	B	stop

.data
	myString:	.asciz		"Hello World"