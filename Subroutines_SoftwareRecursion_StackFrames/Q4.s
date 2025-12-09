.global _start
_start:
	@ Homework #6, Question #4
	@ call tribonacci(10)
	mov r0, #10		@ n
	BL tribonacci


stop:
	B stop

/*
tribonacci function
Parameters: n
Return: r0 (the n-th tribonacci number)
Uses: r0 (value of n and return value)

int tribonacci(int n) {
	if(n == 1)
		return 1;
	else if (n == 2)no
		return 1;
	else if (n == 3)
		return 2;
	else
		return tribonacci(n-1) + tribonacci(n-2) + tribonacci(n-3);
}	

Stack Frame
----------------------------
Contents			Address
tribonacii(n-2)		FP - 16
tribonacci(n-1)		FP - 12
n					FP - 8
Old FP				FP - 4
LR					FP
----------------------------

*/
tribonacci:
	@ Prologue
	PUSH {FP, LR}		@ push LR and old FP to stack frame
	add FP, sp, #4		@ set FP to base of current stack
	sub sp, sp, #16		@ allocate space for parameters n, trib(n-1), trib(n-2)
	str r0, [FP, #-8]	@ store parameters (n)
	
	@ Body
	ldr r0, [FP, #-8]	@ load n into r0
	cmp r0, #1
	BEQ base1
	cmp r0, #2
	BEQ base1
	cmp r0, #3
	BEQ base2
	
	sub r0, r0, #1		@ n = n - 1
	BL tribonacci
	str r0, [FP, #-12]	@ store result of tribonacci n-1 in stack frame
	
	ldr r0, [FP, #-8]	@ load n into r0 for 2nd time
	sub r0, r0, #2		@ n = n - 2
	BL tribonacci
	str r0, [FP, #-16]	@ store trib(n-2)
	
	ldr r0, [FP, #-8]	@ load n into r0 for 3rd time
	sub r0, r0, #3		@ n = n -3
	BL tribonacci
	
	ldr r1, [FP, #-12]	@ trib(n-1)
	ldr r2, [FP, #-16]	@ trib(n-2)
	add r0, r0, r1
	add r0, r0, r2
	B done
	
base1:
	mov r0, #1			@ load 1 into r0 for return
	B done

base2:
	mov r0, #2			@ load 2 into r0 for return
	
done:
	@ Epilogue
	add sp, sp, #16		@ deallocate space resevred for parameters
	POP {FP, LR}		@ pop LR and old FP
	BX LR