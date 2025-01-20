# Pipelining in MIPS Architecture

## Introduction
Pipelining is a technique used to improve the performance of processors by breaking down the execution of instructions into smaller stages, where different stages can execute simultaneously. In the context of the MIPS architecture, pipelining helps increase instruction throughput by allowing multiple instructions to be processed in parallel at different stages of execution.

In a pipelined MIPS processor, instructions are processed in multiple stages, where each stage performs a specific part of the instruction cycle. The standard five-stage pipeline for MIPS consists of the following stages:

- **IF (Instruction Fetch)**: The instruction is fetched from memory.
- **ID (Instruction Decode)**: The instruction is decoded, and operands are fetched from the register file.
- **EX (Execute)**: The ALU performs operations on the operands, and the effective memory address is calculated.
- **MEM (Memory Access)**: Data is read from or written to memory.
- **WB (Write-back)**: The result of the instruction is written back to the register file.

### Pipeline Stages Breakdown

1. **Instruction Fetch (IF)**
   - The instruction is fetched from memory using the program counter (PC).
   - The PC is incremented to point to the next instruction.

2. **Instruction Decode (ID)**
   - The instruction is decoded to determine the type of operation.
   - The source registers are read from the register file.
   - Immediate values are extracted from the instruction.

3. **Execution (EX)**
   - The ALU performs the required operation on the operands.
   - For memory access instructions, the effective memory address is computed.
   
4. **Memory Access (MEM)**
   - For load or store instructions, the data is read from or written to memory.
   
5. **Write-back (WB)**
   - The result of the ALU operation or memory access is written back into the destination register in the register file.

## Pipelining Hazards
While pipelining improves the throughput of the processor, it introduces some challenges known as **pipeline hazards**. There are three types of hazards that can occur in a pipelined processor:

1. **Data Hazards**
   - Occur when an instruction depends on the result of a previous instruction that has not yet completed.
   - Types:
     - **Read-after-write (RAW)**: The instruction needs to read a register that is yet to be written by an earlier instruction.
     - **Write-after-read (WAR)**: The instruction writes to a register that is being read by a later instruction.
     - **Write-after-write (WAW)**: The instruction writes to a register that will be written by an earlier instruction.

2. **Control Hazards**
   - Occur when the pipeline makes wrong decisions based on branch instructions, such as conditional branches, and the outcome of the branch is not yet known.
   
3. **Structural Hazards**
   - Occur when hardware resources are insufficient to support the parallelism of the pipeline, leading to conflicts in resource usage.

### Handling Hazards

- **Data Forwarding**: Data forwarding (also known as bypassing) is a technique used to avoid data hazards by sending the result of an instruction directly to the input of a later instruction.
- **Pipeline Stalls**: In cases where data forwarding is not possible, the pipeline may insert bubbles (no-op operations) to delay execution of an instruction until the necessary data becomes available.
- **Branch Prediction**: To handle control hazards, branch prediction techniques are used to predict the outcome of branches before the condition is fully evaluated.
- **Pipeline Interlocks**: Hardware mechanisms that prevent incorrect data from being used during instruction execution.

## Pipelined MIPS Processor Example

### Instruction Pipeline

Let's consider a simple example with the following MIPS instruction sequence:

```assembly
1. add $1, $2, $3      # R1 = R2 + R3
2. sub $4, $5, $6      # R4 = R5 - R6
3. lw $7, 0($8)        # R7 = Mem[R8]
4. sw $9, 4($10)       # Mem[R10] = R9
```
In a pipelined MIPS processor, the execution of the above instructions would overlap as follows:

| Cycle | IF    | ID    | EX    | MEM   | WB    |
|-------|-------|-------|-------|-------|-------|
| 1     | 1     |       |       |       |       |
| 2     | 2     | 1     |       |       |       |
| 3     | 3     | 2     | 1     |       |       |
| 4     | 4     | 3     | 2     | 1     |       |
| 5     |       | 4     | 3     | 2     | 1     |

Here, each instruction is processed in parallel at each stage of the pipeline. The number of cycles required to complete all instructions is reduced from the non-pipelined 16 cycles (5 cycles per instruction) to 9 cycles (for 4 instructions), significantly improving throughput.
