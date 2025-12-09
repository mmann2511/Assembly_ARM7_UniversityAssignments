.global _start
_start:
	@ Question 3 Homework #5

	ldr r0, =string1			@ base location of string1
	ldr r1, =string2			@ base location of string2
	mov r2, #0					@ index
		
loop1:
	ldrb r3, [r0, r2]				@ load as byte string1[r2]
	cmp r3, #0						@ compare string value to #0(end of string)
	BEQ reverse_loop				@ once end of string reached - branch to reverse loop
	add r2, r2, #1					@ add 1 to counter to loop through string
	b loop1

reverse_loop:
	subs r2, r2, #1					@ index-- to last character
	blt stop						@ if r2 < 0, end
	
	ldrb r3, [r0, r2]			    @ load as byte r3 = string1[r2]
	strb r3, [r1], #1				@ store byte at [r3] to string2, then increment
	b reverse_loop
	


stop:
	B	stop

.data
	string1:	.asciz		"Hello World"
	string2: 	.space		20