.global _start
_start:
	@ Homework #7, Question #3
	@ Read a string from the UART
	@ Write string back to UART until Enter key is encountered (0x0A)
	@ No memory
	
	ldr r1, =0xff201000		@ base address of UART

read_AND_write:
	@ Read
	ldr r0, [r1]			@ read the UART data register
	cmp r0, #0x0a			@ compare char to Enter key
	BEQ stop				@ stop if equal to Enter key
	@ Write
	str r0, [r1]			@ write char to UART
	B read_AND_write

stop:
	B stop