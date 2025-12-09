# **ARM Module 6 — Recursion, Subroutines & Stack Frames**

# **What This Module Demonstrates**

* **Subroutine abstraction**
* **Nested function calls**
* **Return value discipline**
* **Caller/callee register responsibility**
* **Recursion using stack frames**
* **Safe parameter storage**
* **Software arithmetic and function simulation**

---

## **Question 1 — Subroutine Calling (sumSquare + mult)**

| File                  | Description                                                                                                                                                                                  |
| --------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q1` | Implements two callable ARM subroutines: `mult(x)` and `sumSquare(x,y)`. Demonstrates a nested `BL` call where `sumSquare` internally invokes `mult`, and returns a computed result in `R0`. |

**Key ARM Concepts**

* Subroutine call chaining
* Passing parameters in registers (R1, R2)
* Return value written to R0
* Caller restoring LR

**Expected Result**

* For x=10, y=5 → **R0 = 105**

---

## **Question 2 — Recursive Summation**

| File                 | Description                                                                                                                                                                                |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `Q2` | Implements `sum(x)` recursively using full stack-frame discipline: stores parameter `x` on stack, creates a recursive call until base case, and accumulates return values while unwinding. |

**Key ARM Concepts**

* Recursion using stack frames
* Base case detection (`x == 1`)
* FP-relative addressing for locals
* Proper teardown via prologue/epilogue

**Expected Result**

* `sum(10) = 55` → in **R0**

---

## **Question 3 — Recursive Power Function**

| File                 | Description                                                                                                                                                               |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q3` | Implements `pow(x,y)` recursively using two parameters stored in stack memory. Demonstrates exponent decrementing, call unwinding, and multiplication of partial results. |

**Key ARM Concepts**

* Multi-parameter stack frame
* Recursion on exponent (`y-1`)
* Computed return written to R0
* Base case when exponent = 0

**Expected Result**

* `pow(2,10) = 1024` → in **R0**

---

## **Question 4 — Recursive Tribonacci**

| File                        | Description                                                                                                                                                |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Q4` | Computes the n-th tribonacci value using triple-recursion: `T(n)=T(n-1)+T(n-2)+T(n-3)`. Stack frame stores three partial results and original parameter n. |

**Key ARM Concepts**

* Triple recursion
* Multiple stored partial results per frame
* Stack-based preservation of state
* Full unwind with accumulation

**Expected Result**

* `tribonacci(10) = 149` → in **R0**

---





