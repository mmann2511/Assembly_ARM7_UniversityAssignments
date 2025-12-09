# ARM7 Assembly — Memory-Mapped I/O, Word/Byte Stores, and Register Arithmetic

## Overview
This module demonstrates foundational **ARMv7 assembly language programming** in a realistic memory-mapped environment using CPUlator.  
It includes:

- Direct memory access with `LDR`, `STR`, `LDRB`, `STRB`
- Static data section allocation (`.data`, `.byte`, `.word`)
- Memory-mapped reads and writes into addresses representing external devices
- Register arithmetic and multi-word value operations
- Endianness inspection through word-sized loads

---

# Contents

### Homework Question 1 — Byte Writes to Memory-Mapped Locations

| File | Description |
|---|---|
| `Q1 Code` | Stores byte values `0x30` and `0x97` into fixed hardware addresses `0x20000000` and `0x20000004`. Demonstrates 8-bit load from `.data` section and 32-bit store to mapped RAM. |

#### Key Concepts
- Data section allocation using `.byte`
- 8-bit load from `.data` using `LDRB`
- Word-aligned store using `STR`
- Memory location verification via CPUlator

#### Code Snippet (Q1)
```asm
.global _start
_start:
    @ Homework Question 1
    ldr r0, =0x20000000
    ldr r1, =0x20000004

    ldr r2, =a
    ldrb r2, [r2]

    ldr r3, =b
    ldrb r3, [r3]

    str r2, [r0]
    str r3, [r1]

stop:
    b stop

.data
a: .byte 0x30
b: .byte 0x97
.end
```

---

### Homework Question 2 — Word Stores and Register Arithmetic

| File | Description |
|---|---|
| `Q2 Code` | Stores two 32-bit `.word` constants into mapped memory, then performs a 32-bit addition in a register and inspects the result. |
| `Computed Output` | `R9 = 0x335589EE` |

#### Key Concepts
- `.word` declaration
- Full word-sized `LDR` and `STR`
- Register arithmetic (`ADD`)
- Multi-word values and signed/unsigned interpretation
- Endianness reflected in memory window

#### Code Snippet (Q2)
```asm
.global _start
_start:
    @ Homework Question 2
    ldr r0, =0x20000030
    ldr r1, =0x20000038

    ldr r2, =a
    ldr r2, [r2]

    ldr r3, =b
    ldr r3, [r3]

    str r2, [r0]
    str r3, [r1]

    add r9, r2, r3   @ Expected: 0x335589EE

stop:
    b stop

.data
a: .word 0x10102265
b: .word 0x23456789
.end
```

---

### Homework Question 3 — Parameterized Student-ID Byte Storage and Word Load

| File | Description |
|---|---|
| `Q3 Code` | Stores student-ID–derived 8-bit values into memory, reloads a word from a single-byte location, and inspects word interpretation. |
| `Student ID Rule` | A = first two digits (decimal), B = last two digits (decimal) |
| `R2 Word Value` | `0x00000021` *(ARM view may show padded high bytes — e.g., `0xAAAAAA21` depending on uninitialized space)* |

#### Key Concepts
- **Byte-only writes** using `STRB`
- Data abstraction via `.byte`
- Loading a full register from a byte location (`LDR` from 0x20000020)
- Implicit endianness and word inflation when loading

#### Code Snippet (Q3)
```asm
.global _start
_start:
    @ Homework Question 3

    ldr r0, =0x20000010
    ldr r1, =0x20000011

    ldr r2, =a
    ldrb r2, [r2]

    ldr r3, =b
    ldrb r3, [r3]

    strb r2, [r0]
    strb r3, [r1]

    ldr r4, =0x20000020
    strb r3, [r4]

    ldr r2, [r4]    @ Full 32-bit word load

stop:
    b stop

.data
a: .byte 0x5A      @ decimal 90
b: .byte 0x21      @ decimal 33
.end
```

---