# **ARM Assembly — Shifts, XOR Swaps, Bit Masking, and Arithmetic Without MUL** 

## Overview

This module demonstrates **intermediate ARMv7 assembly concepts** using CPUlator, including:

* Bit rotation using `ROR`
* Arithmetic shift right (`ASR`) and sign propagation
* Multiplying without MUL using **bit shifts (LSL), ADD, and SUB**
* Selective bit clearing using `BIC`
* Performing register swaps using **XOR-based algorithms**
* Bit-level field manipulation to toggle individual bytes


---

# Contents

### Question 1 — Rotate an 8-bit Value Left by 4, 8, and 12 Bits

| File      | Description                                                                                                                                                                                            |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Q1` | Uses `ROR` instruction to implement left-rotations of the constant `0x33` by 4, 8, and 12 bits. Demonstrates using right-rotations to simulate left-rotations (`rotate left N = rotate right (32−N)`). |

#### Key Concepts

* ROTATE LEFT is not a separate instruction — ARM uses `ROR`
* `ROR rN, rSrc, #shift` produces cyclic bit motion
* Rotations preserve all bits and wrap around the word boundary
* Useful for: cryptography, CRCs, DSP math

#### Code

```asm
.global _start
_start:
    @ Question 1
    mov r0, #0x33        @ r0 = 0x00000033

    ror r1, r0, #28      @ == rotate left 4
    ror r2, r0, #24      @ == rotate left 8
    ror r3, r0, #20      @ == rotate left 12

stop:
    b stop
.end
```

---

### Question 3 — Multiply Without MUL or Loops

| File      | Description                                                                                                                          |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `Q3` | Demonstrates multiplication using **bit-wise shifts and addition/subtraction**: `33 = 2^5 + 1`, `1025 = 2^10 + 1`, `4095 = 2^12 − 1` |
| **Goal**  | Maintain speed using LSL (hardware multiply) instead of MUL                                                                          |

#### Key Concepts

* `LSL #N` = multiply by `2^N`
* `ADD` & `SUB` build compound constants
* Useful when hardware MUL is slow or unavailable
* Common in DSP, graphics blitting, embedded math

#### Code

```asm
.global _start
_start:
    @ ---- Multiply by 33 = 2^5 + 1 ----
    mov r0, #2
    lsl r1, r0, #5
    add r0, r1, r0        @ r0 = r0*32 + r0

    @ ---- Multiply by 1025 = 2^10 + 1 ----
    mov r0, #7
    lsl r1, r0, #10
    add r0, r1, r0        @ r0 = r0*1024 + r0

    @ ---- Multiply by 4095 = 2^12 - 1 ----
    mov r0, #5
    lsl r1, r0, #12
    subs r0, r1, r0       @ r0 = r0*4096 - r0

stop:
    b stop
.end
```

---

### Question 4 — Clear Bits 20 Through 25 (Inclusive)

| File      | Description                                                                                                                         |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `Q4` | Demonstrates selective field clearing using `BIC`. Mask removes bit range 20–25 inside register R1 while preserving all other bits. |

#### Key Concepts

* `BIC Rd, Rn, mask` clears **only the masked bits**
* Designed for field editing in packed registers
* Typical use cases:

  * device configuration registers
  * GPIO direction masks
  * pixel channels
  * control word cleanup

#### Code

```asm
.global _start
_start:
    @ Clear bits 20–25
    ldr r1, =0x168cbf12
    bic r1, r1, #0x03f00000

stop:
    b stop
.end
```

---

### Question 5 — Swap R0 and R1 Without Temporary Storage

| File      | Description                                                                        |
| --------- | ---------------------------------------------------------------------------------- |
| `Q5` | Implements a register-swap using XOR instead of using an extra register or memory. |

#### Key Concepts

* XOR swap is reversible
* Requires:

  * no temp variable
  * no RAM access
  * constant time
* Extremely useful in low-level firmware where registers are scarce

#### Code

```asm
.global _start
_start:

    mov r0, #0x35
    mov r1, #0x65

    eor r0, r0, r1
    eor r1, r0, r1
    eor r0, r0, r1

    @ Example 2:
    mov r0, #0x93
    mov r1, #0x17

    eor r0, r0, r1
    eor r1, r0, r1
    eor r0, r0, r1

stop:
    b stop
.end
```

---

### Question 6 — Toggle Byte b3 and Clear Byte b2 Inside a Word

| File         | Description                                                                       |
| ------------ | --------------------------------------------------------------------------------- |
| `Q6`    | Shows how to selectively toggle one byte and clear another using `EOR` and `BIC`. |
| **Behavior** | b3 → inverted, b2 → all zero, b4 and b1 unchanged                                 |

#### Key Concepts

* Byte-wide field editing using hexadecimal masks
* EOR toggles bits
* BIC zeroes bit field
* Common for protocol fields, packed sensor data, RGB channel edits

#### Code

```asm
.global _start
_start:
    @ Example packed word
    ldr r0, =0xb4b3b2b1

    @ toggle b3 (0x00FF0000)
    eor r0, r0, #0x00ff0000

    @ clear b2 (0x0000FF00)
    bic r0, r0, #0x0000ff00

stop:
    b stop
.end
```

---


