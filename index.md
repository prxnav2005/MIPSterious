# MIPS-Documentation

MIPS stands for Microprocessor without Interlocked Pipeline Stages. It is a type of RISC (Reduced Instruction Set Computing) architecture that was developed in the 1980s, known for its simplicity and efficiency in handling instructions. MIPS was designed to be a highly efficient processor for both general-purpose computing and embedded systems.

### Introduction

In MIPS architecture, a **register** is typically denoted by a `$` symbol followed by a number or a name. For example, `$t0` represents the first temporary register, and `$s0` represents the first saved register. MIPS uses a total of **32 general-purpose registers**, each 32 bits wide. These registers can be used to store values like data, addresses, or control information during program execution.

MIPS is a **byte-addressable** architecture, meaning each address refers to a single byte in memory. Memory addresses are represented as **32-bit values** in MIPS, and each byte is assigned a unique address. However, when accessing words (32-bit values), addresses must be word-aligned, meaning they should be divisible by 4.

In MIPS, instructions are generally 32 bits wide, and the **memory is organized into bytes**, with each byte having a unique address. The processor uses the **little-endian** byte order, meaning that the least significant byte of a word is stored at the smallest address.

### Design Principles 

- **Simplicity favors regularity**: The design is kept simple and consistent, which makes it easier to understand and optimize.
- **Make the common case fast**: MIPS focuses on optimizing the most frequently used operations.
- **Smaller is faster**: The processor design emphasizes simplicity and efficiency.
- **Good design demands good compromises**: MIPS makes reasonable trade-offs to balance performance and complexity.

## MIPS Register Set

The MIPS architecture has 32 general-purpose registers, along with some special-purpose registers. Below is a table summarizing the usage and names of the MIPS registers:

| Name     | Number  | Purpose                                      |
|----------|--------|----------------------------------------------|
| `$zero`  | 0      | Constant 0                                  |
| `$at`    | 1      | Assembler temporary (reserved for assembler)|
| `$v0-$v1`| 2-3    | Function return values (32 bits)             |
| `$a0-$a3`| 4-7    | Function arguments (4 registers for 32-bit)  |
| `$t0-$t7`| 8-15   | Temporary registers (caller-saved)           |
| `$s0-$s7`| 16-23  | Saved registers (callee-saved)               |
| `$t8-$t9`| 24-25  | More temporary registers                    |
| `$k0-$k1`| 26-27  | Reserved for kernel use                     |
| `$gp`    | 28     | Global pointer (used for accessing static data) |
| `$sp`    | 29     | Stack pointer                                |
| `$fp`    | 30     | Frame pointer (used in function calls)      |
| `$ra`    | 31     | Return address (used to store the return address for function calls) |

### Special Purpose Register

| Register | Name    | Purpose                                             |
|----------|---------|-----------------------------------------------------|
| `$pc`    |         | Program Counter (holds the address of the next instruction) |
| `$hi`    |         | High word of a result (used in multiplication and division) |
| `$lo`    |         | Low word of a result (used in multiplication and division) |

---

### Key Features of MIPS Architecture

- **RISC (Reduced Instruction Set Computing)**: MIPS is a RISC architecture, meaning it uses a small and simple set of instructions that execute in a single cycle.
- **Load/Store Architecture**: MIPS uses a load/store model, where only load and store instructions access memory, while all other operations take place between registers.
- **Pipelined**: MIPS processors are pipelined, meaning multiple instructions can be processed simultaneously at different stages of execution.

### Memory Layout and Addressing

- MIPS uses **byte-addressable memory**, where each memory location corresponds to a byte, and addresses increase by 1 for each byte.
- **Word-aligned access**: Access to 32-bit data must be word-aligned, meaning the address of the word must be a multiple of 4.
- MIPS supports **little-endian** byte ordering, where the least significant byte is stored at the lowest address.

---

## MIPS Instruction Set

MIPS instructions are 32 bits long and typically use the following formats:

- **R-type** (Register type) – For operations that use only registers.
- **I-type** (Immediate type) – For operations involving an immediate value.
- **J-type** (Jump type) – For jump instructions.

### Example of MIPS Instruction Storage

Consider the following MIPS instructions:

```assembly
add $t0, $t1, $t2     # Add contents of $t1 and $t2, store result in $t0
sub $t3, $t4, $t5     # Subtract contents of $t5 from $t4, store result in $t3
```

The `add` and `sub` instruction when converted into machine code is of the form `000000 01001 01010 01000 00000 100000` and `000000 01100 01101 01011 00000 100010` respectively. This is how it's stored in the memory.

| **Memory Address** | **Instruction (Hex)** |
|--------------------|-----------------------|
| `0x00400000`       | `0x012A4020`          |
| `0x00400004`       | `0x01AC6022`          |



