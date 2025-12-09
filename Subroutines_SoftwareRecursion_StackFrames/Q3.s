.global _start
_start:
	@ Homework #6, Question #3
	@ call pow(2, 10)
	mov r0, #2		@ x
	mov r1, #10		@ y
	BL pow


stop:
	B stop

/*
pow function
Parameters: x, y
Return: r0 (x * pow(x, y-1)
Uses: r0 (value of x and return value)

int pow(int x, int y) {
	if(y == 0)
		return 1;
	else
		return x * pow(x, y-1);
}	

Stack Frame
--------------------
Contents	Address
x			FP - 12
y			FP - 8
Old FP		FP - 4
LR			FP
--------------------

*/
pow:
	@ Prologue
	PUSH {FP, LR}		@ push LR and old FP to stack frame
	add FP, sp, #4		@ set FP to base of current stack
	sub sp, sp, #8		@ allocate space for parameters x and y (4 each)
	str r0, [FP, #-12]	@ store parameters (x)
	str r1, [FP, #-8]	@ store parameters (y)
	
	@ Body
	ldr r0, [FP, #-12]	@ load x into r0
	ldr r1, [FP, #-8]	@ load y into r1
	cmp r1, #0
	BEQ base_case
	sub r1, r1, #1		@ r1 = y - 1
	BL pow				@ recursive call
	ldr r2, [FP, #-12]	@ load original x into r2
	mul r0, r0, r2 	@ r0 = x * pow(x, y - 1)
	B done
	
base_case:
	mov r0, #1			@ load 1 into r0 for return
	
done:
	@ Epilogue
	add sp, sp, #8		@ deallocate space resevred for parameters
	POP {FP, LR}		@ pop LR and old FP
	BX LR