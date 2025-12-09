# ARM Assembly — FPGA Peripherals, Hardware Timers, 7-Segment Displays & UART Echo

## Overview

This module demonstrates **full hardware-peripheral control on the DE1-SoC board**, including:

* **GPIO LED manipulation**
* **Hardware timer configuration**
* **One-second time delays without loops**
* **Seven-segment display output**
* **UART read/write echoing**
* **Polling vs hardware wait**
* **Peripheral registers using memory-mapped I/O**

---

# Contents

---

## **Question 1 — Blink Left-Most & Right-Most LEDs (1-second interval)**

| File                   | Description                                                                                                                                                                      |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q1` | Toggles the left-most and right-most LEDs using a hardware timer to create a precise 1-second delay between transitions. The LEDs are read, XOR-toggled, and re-written forever. |

### Hardware Concepts

* **Memory-mapped GPIO at `0xFF200000`**
* **Memory-mapped timer at `0xFFFEC600`**
* **Polling timer flag register**
* **XOR bit-toggling**

### Behavior

* LEDs blink exactly once per second
* No CPU delay loops
* Pure hardware timing

```asm
ldr r0, =0xff200000     @ LED base
ldr r1, =0xfffec600     @ timer base
ldr r2, =0b1000000001   @ leftmost + rightmost bits
ldr r3, =200000000      @ 1-second timeout
str r3, [r1]            @ load timer
mov r3, #0b011
str r3, [r1,#8]

str r2, [r0]            @ initial LED state
wait:
ldr r3, [r1,#12]        @ read timer status
cmp r3, #1
bne wait
str r3, [r1,#12]        @ clear flag
ldr r4, [r0]
eor r4, r4, r2          @ toggle LEDs
str r4, [r0]
b wait
```

---

## **Question 2 — Display 0–9 on Right-Most Seven-Segment (1-second delay)**

| File                        | Description                                                                                                                                             |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q2` | Cycles through the hexadecimal seven-segment encoding values for digits `0–9`, displaying each for one second, using the hardware timer to pace output. |

### Hardware Concepts

* **Right-most 7-segment base at `0xFF200020`**
* Timer controlled pacing
* Byte-indexed lookup table in `.data`

### Behavior

* Displays `0 1 2 ... 9` in order
* Loops forever
* One second between each display

```asm
ldr r0, =0xff200020     @ 7-seg base
ldr r1, =0xfffec600
ldr r2, =200000000
str r2, [r1]
mov r2, #0b011
str r2, [r1,#8]

ldr r3, =myNumbers
mov r4, #0
wait:
ldr r2, [r1,#12]
cmp r2,#1
bne wait
str r2,[r1,#12]

ldrb r5,[r3,r4]
str r5,[r0]

add r4,r4,#1
cmp r4,#10
moveq r4,#0
b wait

.data
myNumbers: .byte 0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x27,0x7f,0x67
```

---

## **Question 3 — UART Echo until ENTER (no memory allowed)**

| File                      | Description                                                                                                                                                   |
| ------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q3` | Continuously reads characters from the UART and immediately writes them back until the ENTER key (`0x0A`) is encountered. Uses **no RAM storage** whatsoever. |

### Hardware Concepts

* **UART base at `0xFF201000`**
* Poll-read & write
* No buffers, no memory, no RAM — pure register echo
* Execution halts when ENTER received

### Behavior

* Reads live keystrokes coming from UART terminal
* Immediately echoes each byte back
* Stops when hex `0x0A` is detected

```asm
ldr r1, =0xff201000
read_AND_write:
ldr r0, [r1]
cmp r0, #0x0a
beq stop
str r0, [r1]
b read_AND_write
stop:
b stop
```


