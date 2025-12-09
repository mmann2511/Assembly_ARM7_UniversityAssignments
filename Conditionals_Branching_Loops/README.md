# ARM Assembly — Conditionals, Multi-Range Branching, Loops, Factorials, and Nested Loop Arithmetic 

## Overview

This module demonstrates **core ARM CPU control-flow behaviors** using CPUlator, including:

* Signed branching with `<`, `==`, `>`
* Multi-range decision logic with chained comparisons
* Even-number summation using a decrementing loop
* Factorial computation using iterative multiplication
* Translating high-level for-loops into ARM branching
* Nested loop arithmetic for 2D accumulation
* Storing final results to mapped memory

---

# Contents

## **Question 1 — Signed Comparison Result (Sign Classification)**

| File      | Description                                                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `Q1` | Tests a signed integer in `R0` and stores `−1`, `0`, or `1` into `R1` depending on whether the number is negative, zero, or positive. |

#### Key Concepts

* `CMP r0, #0` compares signed value to zero
* Conditional MOV instructions:

  * `MOVLT` fires if `< 0`
  * `MOVEQ` fires if `== 0`
  * `MOVGT` fires if `> 0`
* Useful for **fast sign extraction** without branching

#### Code

```asm
.global _start
_start:
    @ Question 1
    mov r0, #5
    cmp r0, #0
    movlt r1, #-1
    moveq r1, #0
    movgt r1, #1

stop:
    b stop
.end
```

---

## **Question 2 — Multi-Range Conditional Arithmetic (9x, 8x, 7x, 6x)**

| File      | Description                                                                                            |
| --------- | ------------------------------------------------------------------------------------------------------ |
| `Q2` | Implements chained range checks on `x` and computes `9x`, `8x`, `7x`, or `6x` depending on thresholds. |

#### Key Concepts

* ARM conditional execution removes many branches
* Cascading range logic:

  * `x ≤ 10` → multiply by 9
  * `10 < x ≤ 100` → multiply by 8
  * `100 < x ≤ 1000` → multiply by 7
  * `x > 1000` → multiply by 6
* `MULxx` performs multiplication only when condition matches

#### Code (minimal branch version — matches your assignment)

```asm
.global _start
_start:
    mov r0, #1010       @ x
    
    cmp r0, #10
    movle r2, #9
    mulle r1, r2, r0
    ble stop

    cmp r0, #10
    cmpgt r0, #100
    movle r2, #8
    mulle r1, r2, r0
    ble stop

    cmp r0, #10
    cmpgt r0, #1000
    movle r2, #7
    mulle r1, r2, r0
    ble stop

    cmp r0, #1000
    movgt r2, #6
    mulgt r1, r2, r0

stop:
    b stop
.end
```

---

## **Question 3 — Sum All Even Numbers from 0 to 1000**

| File                     | Description                                                                                                                                |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `Q3`                | Uses a loop that decrements by 2 starting from 1000 and accumulates all even numbers into `R2`, storing the total at address `0x10002010`. |
| **Final Expected Total** | **250,500**                                                                                                                                |

#### Key Concepts

* Iteration without modulo: decreasing by 2 guarantees even numbers only
* Memory-mapped storage of running sum
* `SUBS` + `BNE` implements loop termination
* Loop is branch-predictable and efficient

#### Code

```asm
.global _start
_start:
    ldr r0, =0x10002010
    mov r1, #1000
    mov r2, #0

loop:
    add r2, r1, r2
    str r2, [r0]
    subs r1, r1, #2
    bne loop

stop:
    b stop
.end
```

---

## **Question 4 — Iterative Factorial (11!)**

| File            | Description                                                                    |
| --------------- | ------------------------------------------------------------------------------ |
| `Q4`       | Computes factorial of 11 and stores running product in memory at `0x10002020`. |
| **Final Total** | **39,916,800**                                                                 |

#### Key Concepts

* Factorial is multiplicative countdown
* Pre-initialize accumulator to `1`
* Store intermediate values to observe function evolution inside CPUlator
* Uses:

  * `MUL`
  * `SUBS`
  * zero-crossing loop exit

#### Code

```asm
.global _start
_start:
    ldr r0, =0x10002020
    mov r1, #11
    mov r2, #1

loop:
    mul r2, r1, r2
    str r2, [r0]
    subs r1, r1, #1
    bne loop

stop:
    b stop
.end
```

---

## **Question 5 — High-Level Loop Translation (Sum of i²)**

| File            | Description                                                                   |
| --------------- | ----------------------------------------------------------------------------- |
| `Q5`       | Direct translation of: `s += i*i` for `i = 0…9`, storing `s` at `0x10002030`. |
| **Final Total** | **285**                                                                       |

#### Key Concepts

* C++/Java `for` loop structure:

  * init → test → body → increment
* Separation of:

  * loop index `i` (R2)
  * accumulator `s` (R1)
  * multiplication temp `i*i` (R3)
* Classic intro to **compiler lowering**

#### Code

```asm
.global _start
_start:
    ldr r0, =0x10002030
    mov r1, #0
    mov r2, #0
    mov r3, #0

loop:
    cmp r2, #10
    bge stop

    mul r3, r2, r2
    add r1, r1, r3
    str r1, [r0]

    add r2, r2, #1
    b loop

stop:
    b stop
.end
```

---

## **Question 6 — Nested Loops (Sum of i * j)**

| File            | Description                                                                                             |
| --------------- | ------------------------------------------------------------------------------------------------------- |
| `Q6`       | Translates a 2D nested loop performing `s += i*j` with `i,j = 0…4`. Final value stored at `0x10002040`. |
| **Final Total** | **100**                                                                                                 |

#### Key Concepts

* Two independent counters:

  * `i` (outer, R2)
  * `j` (inner, R4)
* Loop lowering of:

  ```c
  for i in 0..4
    for j in 0..4
      s += i*j
  ```
* Total number of iterations = 25
* Straight mapping using nested `CMP` and `BGE`

#### Code

```asm
.global _start
_start:
    ldr r0, =0x10002040
    mov r1, #0     @ s
    mov r2, #0     @ i

loop1:
    cmp r2, #5
    bge stop

    mov r4, #0     @ j = 0

loop2:
    cmp r4, #5
    addge r2, r2, #1
    bge loop1

    mul r3, r2, r4
    add r1, r1, r3
    str r1, [r0]

    add r4, r4, #1
    b loop2

stop:
    b stop
.end
```

