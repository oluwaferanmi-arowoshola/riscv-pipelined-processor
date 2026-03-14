# Pipelined RISC-V Processor (SystemVerilog)

This project implements a five-stage pipelined RISC-V processor in SystemVerilog.
The design includes hazard detection, data forwarding, and pipeline control
mechanisms to support correct and efficient instruction execution.

The processor was verified through simulation and synthesized using Xilinx Vivado.

---

## Processor Architecture

The processor consists of several major components:

- **Controller** – instruction decoding and generation of control signals  
- **Datapath** – ALU operations, register interactions, and data routing  
- **Hazard Unit** – detection and resolution of data and control hazards  
- **Instruction and Data Memory Interfaces**

![RTL Architecture](docs/RTL_Analysis_Schematic.PNG)

---

## Pipeline Stages

The processor follows a standard five-stage pipeline:

1. **Instruction Fetch (IF)** – fetch instruction from instruction memory  
2. **Instruction Decode (ID)** – decode instruction and read register file  
3. **Execute (EX)** – perform ALU operations and branch evaluation  
4. **Memory Access (MEM)** – access data memory for load/store instructions  
5. **Write Back (WB)** – write results back to the register file

---

## Instruction Execution Verification

A single-cycle reference execution trace was created to verify the correctness
of instruction results before evaluating pipeline behavior.

![Instruction Execution](docs/Pipeline_Execution_Sequence.png)

---

## Pipeline Hazard Analysis

The following diagrams show how instructions progress through the pipeline
and illustrate the detection and handling of hazards, including:

- RAW data hazards  
- Forwarding paths  
- Pipeline stalls  
- Control hazard flushes

![Hazard Analysis Part 1](docs/Pipeline_Hazard_Analysis_Part1.png)

![Hazard Analysis Part 2](docs/Pipeline_Hazard_Analysis_Part2.png)

---

## Simulation Results

The processor was verified using a SystemVerilog testbench in the Vivado simulator.
The waveform demonstrates correct operation of pipeline registers, forwarding
signals, hazard detection signals, and memory write operations.

![Simulation Waveform](docs/Simulation_Waveform.PNG)

---

## FPGA Synthesis

The design was synthesized using Xilinx Vivado.

Target FPGA:
xc7a100tcsg324-1

![Vivado Implementation Summary](docs/Project_Summary.PNG)

---

## Tools Used

- SystemVerilog  
- Xilinx Vivado  
- Vivado Simulator  
- FPGA RTL synthesis and implementation

---

## Author

Oluwaferanmi Arowoshola  
Electrical & Computer Engineering  
Minnesota State University, Mankato
