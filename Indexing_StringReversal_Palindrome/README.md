# ARM Assembly — Pointer Indexing, String Reversal, Palindrome Detection, Max Scanning & Integer Division 

## Overview

Key instructional behaviors demonstrated:

* **Pre/post-indexed memory writes** (`STR`, `STRB`, offset, write-back)
* **Maximum scanning in a memory array**
* **Manual text copying with reversed ordering**
* **In-place string reversal without temporary buffers**
* **Palindrome detection using symmetric pointer comparison**
* **Integer averaging using repeated subtraction division**
* **Memory-mapped result storage for CPUlator inspection**


---

# Contents

---

## **Question 2 — Maximum Value in Word Array**

| File      | Description                                                          |
| --------- | -------------------------------------------------------------------- |
| `Q2` | Scans a 10-element word list and stores the maximum value into `R1`. |

### Key Concepts

* Array access via:

  ```
  LDR r2, [r3, r4, LSL #2]
  ```

  where `r3` is **base pointer** and `r4` is **index**
* Conditional update:

  ```
  CMP r2, r1
  MOVGT r1, r2
  ```
* Loop termination via:

  ```
  CMP r4, r0
  BLT loop
  ```

### Code

```asm
.global _start
_start:
    mov r0, #10
    mov r1, #0
    ldr r3, =myArray
    mov r4, #0

loop:
    ldr r2, [r3, r4, lsl #2]
    cmp r2, r1
    movgt r1, r2
    add r4, r4, #1
    cmp r4, r0
    blt loop

stop:
    b stop

.data
myArray: .word 34, 92, 45, 52, 93, 25, 52, 82, 53, 92
```

---

## **Question 3 — Reverse Copy Between Two Strings**

| File      | Description                                                                                        |
| --------- | -------------------------------------------------------------------------------------------------- |
| `Q3` | Finds end of `string1`, then copies characters backward into `string2`, producing `"dlrow olleH"`. |

### Key Concepts

* Byte-wise load/store: `LDRB`, `STRB`
* End-of-string detection via `cmp r3,#0`
* Write pointer increments while read pointer decrements
* Opposing index motion: forward scan → backward copy

### Code

```asm
.global _start
_start:
    ldr r0, =string1
    ldr r1, =string2
    mov r2, #0

loop1:
    ldrb r3, [r0, r2]
    cmp r3, #0
    beq reverse_loop
    add r2, r2, #1
    b loop1

reverse_loop:
    subs r2, r2, #1
    blt stop
    ldrb r3, [r0, r2]
    strb r3, [r1], #1
    b reverse_loop

stop:
    b stop

.data
string1: .asciz "Hello World"
string2: .space 20
```

---

## **Question 4 — In-Place String Reversal (No Temporary Buffer)**

| File      | Description                                                                                                       |
| --------- | ----------------------------------------------------------------------------------------------------------------- |
| `Q4` | Reverses the string `"Hello world"` **inside its own storage**, swapping symmetric bytes until middle is reached. |

### Core Embedded Behavior

* Two pointers:

  * start pointer = `r3`
  * end pointer = `r2`
* Swap:

  * read `myString[r3]`
  * read `myString[r2]`
  * write each to the other’s index
* Loop ends when pointers meet or cross

This is a foundational **firmware-safe** technique:

> Rearranging buffers without dynamic allocation or extra RAM

### Code

```asm
.global _start
_start:
    ldr r0, =myString
    mov r2, #0
    mov r3, #0

loop1:
    ldrb r1, [r0, r2]
    cmp r1, #0
    beq reverse_loop
    add r2, r2, #1
    b loop1

reverse_loop:
    subs r2, r2, #1
    ldrb r4, [r0, r3]
    ldrb r5, [r0, r2]
    strb r4, [r0, r2]
    strb r5, [r0, r3]
    add r3, r3, #1
    cmp r3, r2
    bge stop
    b reverse_loop

stop:
    b stop

.data
myString: .asciz "Hello World"
```

---

## **Question 5 — Palindrome Detection**

| File      | Description                                                                                               |
| --------- | --------------------------------------------------------------------------------------------------------- |
| `Q5` | Checks if a string is symmetric (`racecar`) and outputs: <br> `R0 = 1` if palindrome, `R0 = 0` otherwise. |

### Key Concepts

* Same pointer motion as Question 4
* BUT instead of swapping:

  * Compare characters
  * If mismatch detected → exit early
* Efficient termination because detection is **O(k)** where **k = half length**

### Code

```asm
.global _start
_start:
    ldr r0, =myString
    mov r2, #0
    mov r3, #0

loop1:
    ldrb r1, [r0, r2]
    cmp r1, #0
    beq reverse_loop
    add r2, r2, #1
    b loop1

reverse_loop:
    subs r2, r2, #1
    ldrb r4, [r0, r3]
    ldrb r5, [r0, r2]
    cmp r4, r5
    movne r0, #0
    bne stop
    add r3, r3, #1
    cmp r3, r2
    bge if_palindrome
    b reverse_loop

if_palindrome:
    mov r0, #1

stop:
    b stop

.data
myString: .asciz "racecar"
```

---

## **Question 6 — Integer Average Using Manual Division**

| File             | Description                                                                                                                |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `Q6`        | Computes the average of 10 array values using a **manual division routine**, and stores quotient into memory `0x10001000`. |
| **Final Answer** | Sum = 4960, Average = 496                                                                                                  |

### Key Concepts

* Software division via repeated subtraction
* Embedded-safe math where no hardware divider exists
* Results:

  * `R0` = quotient
  * `R1` = remainder
* Stores quotient directly to mapped memory

### Code

```asm
.global _start
_start:
    mov r0, #0
    mov r1, #10
    mov r2, #0
    ldr r3, =myArray
    mov r4, #0
    ldr r8, =0x10001000

loop:
    ldr r5, [r3, r4, lsl #2]
    add r0, r0, r5
    add r4, r4, #1
    cmp r4, r1
    blt loop
    bl div

stop:
    b stop

div:
    mov r2, #0

div_loop:
    cmp r0, r1
    blt end_div
    sub r0, r0, r1
    add r2, r2, #1
    b div_loop

end_div:
    mov r1, r0
    mov r0, r2
    str r0, [r8]
    bx lr

.data
myArray: .word 298, 104, 841, 903, 492, 325, 23, 1200, 750, 24
```

