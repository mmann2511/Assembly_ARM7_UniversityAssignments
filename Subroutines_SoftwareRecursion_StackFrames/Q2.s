.global _start
_start:
	@ Homework #6, Question #2
	@ call sum(10)
	mov r0, #10		@ r0(x) = 10
	BL sum


stop:
	B stop

/*
sum function
Parameters: x
Return: r0 (sum of x)
Uses: r0 (value of x and return value)

int sum(int x) {
	if(x == 1)
		return 1;
	else
		return x + sum(x-1);
}	

Stack Frame
--------------------
Contents	Address
x			FP - 8
Old FP		FP - 4
LR			FP
--------------------

*/
sum:
	@ Prologue
	PUSH {FP, LR}		@ push LR and old FP to stack frame
	add FP, sp, #4		@ set FP to base of current stack
	sub sp, sp, #4		@ allocate space for parameters
	str r0, [FP, #-8]	@ store parameters (x)
	
	@ Body
	ldr r0, [FP, #-8]	@ load x into r0
	cmp r0, #1
	BEQ base_case
	sub r0, r0, #1		@ r0 = x - 1
	BL sum				@ recursive call
	ldr r1, [FP, #-8]	@ load into r1 since r0 contains return value
	add r0, r0, r1		@ r0 = x + sum(x-1)
	B done
	
base_case:
	mov r0, #1			@ load 1 into r0 for return
	
done:
	@ Epilogue
	add sp, sp, #4		@ deallocate space resevred for parameters
	POP {LR, FP}		@ pop LR and old FP
	BX LR