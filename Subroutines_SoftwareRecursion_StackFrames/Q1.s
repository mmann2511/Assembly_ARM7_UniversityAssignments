.global _start
_start:
	@ Homework #6, Question #1
	mov r1, #10		@ r1 = x = 10
	mov r2, #5		@ r2 = y = 5
	BL sumSquare


stop:
	B stop

/*
sumSquare function
Parameter: r1(x) and r2(y)
Return: r0 = mult(x) + y
*/
sumSquare:
	PUSH {LR}
	mov r0, r1		@ parameter int x into r0
	BL mult
	add r0, r2, r0	@ r0 = mult(x) + y
	POP {LR}
	BX LR

/*
mult function
Parameter: r1(x)
Return: r0 (x*x)
*/
mult:
	mul r0, r0, r0	@ r0 = x * x
	BX LR