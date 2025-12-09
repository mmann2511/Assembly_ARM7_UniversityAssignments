# Assembly_ARM7_UniversityAssignments

## Repository Overview

This repository contains a **collection of ARM Assembly programs** The code runs on a **ARMv7 DE1-SoC platform using CPUlator**, demonstrating:

* memory-mapped FPGA peripherals
* structured arithmetic, loops, branching, and function calls
* nested recursion via stack frames
* live hardware control (LEDs, timers, UART, 7-segment displays)
* bit-level manipulation and array indexing
* zero-memory UART echo and string algorithms

Every folder is self-contained and includes:

* clean ARM source files (`.s`)
* well-commented logic
* test examples
* expected register/memory results
* academic scope aligned with real embedded applications

---

# 📂 Folder Structure

## **1) `Conditionals_Branching_Loops/`**

### Description

Implements basic program-flow mechanisms:

* condition codes (`EQ`, `NE`, `GT`, `LT`, etc.)
* arithmetic branching
* software loop counters
* if-else logic
* multi-range number classification
* sum accumulation

### Embedded Concepts

* `CMP`, `BXX`, and conditional execution
* software loop construction
* memory-mapped sum storage
* performance-correct flow control

---

## **2) `Shifts_Arithmetic_XORSwap_Bitmasking/`**

### Description

Arithmetic and logical operations using only registers:

* rotation and bit shifts (`LSL`, `LSR`, `ROR`)
* arithmetic sign extraction via bit shifting
* integer multiplication via shift/ADD
* XOR register swap (no temp registers)
* bit clearing and selective byte inversion

### Embedded Concepts

* no MUL instruction requirement
* bitfield masking for register I/O
* toggling / clearing specific byte ranges
* memory-safe register-only operations

---

## **3) `Indexing_StringReversal_Palindrome/`**

### Description

Array and string algorithmics:

* max-element scanning using indexed load
* reverse-copy string to new destination
* reverse string **in-place** with no extra buffer
* palindrome detection using two moving indices

### Embedded Concepts

* byte vs word memory loads
* `LDRB` with index scaling
* no-buffer constraints (pure register swap)
* branch-controlled two-pointer traversal


---

## **4) `Subroutines_SoftwareRecursion_StackFrames/`**

### Description

Fully structured function architectures:

* `BL`-driven subroutine calls
* correct prologue/epilogue
* local parameter stack allocation
* sum, power, and tribonacci via recursion
* return propagation via `R0`

### Embedded Concepts

* stack frame layout (`FP`, `LR`)
* nested recursive call depth
* high-level function lowering into pure ARM assembly
* mathematical computation as firmware routines


---

## **5) `FPGAPeriph_Timers_7SegmentDisplay_UART/`**

### Description

Direct **hardware peripheral control** over SoC FPGA:

* LED blinking using hardware timer interrupt flag
* real 7-segment digit cycling (0–9)
* UART echo until ENTER, with **no memory**
* polling hardware registers instead of software delays

### Embedded Concepts

* memory-mapped peripherals (`0xFF20xxxx`, `0xFFFE C600`)
* timer control bits
* exact 1-second hardware waits
* live UART terminal echo



