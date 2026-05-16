# Pipelined RISC-V Processor (SystemVerilog)

**SystemVerilog · RTL Design · Computer Architecture · 5-Stage Pipeline · Hazard Detection · Forwarding · Vivado Simulation · FPGA Synthesis**

## Overview

This project implements a **5-stage pipelined RISC-V processor** in **SystemVerilog RTL**. The design follows the classic instruction pipeline structure:

```text
Instruction Fetch → Instruction Decode → Execute → Memory Access → Write Back
```

The processor includes datapath logic, controller logic, pipeline registers, hazard detection, forwarding, stall control, and flush control to support correct pipelined instruction execution.

The design was verified through SystemVerilog simulation and waveform analysis, then synthesized using **Xilinx Vivado**.

---

## What This Project Demonstrates

- SystemVerilog RTL design for a pipelined processor
- RV32I-style instruction execution
- 5-stage pipeline implementation: IF, ID, EX, MEM, WB
- Datapath and controller design
- Pipeline register implementation
- RAW hazard detection and forwarding logic
- Stall and flush control for correct execution
- Directed simulation-based verification
- Waveform analysis for instruction execution and pipeline behavior
- Vivado synthesis of processor RTL

---

## Quick Results

| Feature | Result |
|---|---|
| ISA | RV32I subset |
| Language | SystemVerilog |
| Architecture | 5-stage pipeline |
| Pipeline Stages | IF, ID, EX, MEM, WB |
| Hazard Handling | Forwarding, stall, and flush logic |
| Verification | SystemVerilog simulation and waveform analysis |
| Synthesis Tool | Xilinx Vivado |
| Target Device | xc7a100tcsg324-1 |

---

## Processor Architecture

The processor is organized into three major design areas:

- **Datapath** — register file, ALU, multiplexers, pipeline registers, and memory interfaces
- **Controller** — instruction decoding and control-signal generation
- **Hazard Unit** — forwarding, stall, and flush control for pipeline correctness

![RTL Architecture](docs/RTL_Analysis_Schematic.PNG)

The architecture separates instruction flow, control generation, datapath execution, and hazard management to support a structured pipelined processor design.

---

## Pipeline Stages

The processor follows a standard 5-stage RISC-V pipeline.

| Stage | Function |
|---|---|
| IF — Instruction Fetch | Fetches instruction from instruction memory |
| ID — Instruction Decode | Decodes instruction and reads register file |
| EX — Execute | Performs ALU operation and branch evaluation |
| MEM — Memory Access | Reads from or writes to data memory |
| WB — Write Back | Writes ALU or memory result back to register file |

---

## Pipeline Datapath

The datapath includes:

- Program counter logic
- Instruction memory interface
- Register file
- Immediate generation
- ALU
- Data memory interface
- Pipeline registers between stages
- Write-back selection logic
- Forwarding paths for dependency resolution

The design allows multiple instructions to be active in different stages of the pipeline at the same time.

---

## Controller

The controller decodes instructions and generates control signals for each pipeline stage.

Control responsibilities include:

- ALU operation selection
- register write enable
- memory read/write control
- branch control
- result selection for write-back
- pipeline control signal propagation

The controller works with the hazard unit to ensure that instructions execute correctly even when pipeline hazards occur.

---

## Hazard Handling

Pipelined processors must handle hazards caused by overlapping instruction execution. This design includes hazard detection, forwarding, stall, and flush logic.

### Data Hazards

RAW dependencies are handled using forwarding paths from later pipeline stages back to the execute stage.

Forwarding helps reduce unnecessary stalls by allowing the processor to use recently computed values before they are written back to the register file.

### Load-Use Hazards

When forwarding is not sufficient, the hazard unit can stall the pipeline to prevent an instruction from using unavailable data too early.

### Control Hazards

Branch-related hazards are handled using flush control. When a branch changes the instruction flow, incorrect instructions in the pipeline are flushed to preserve correct execution.

---

## Instruction Execution Verification

A reference instruction execution trace was created to validate instruction behavior before analyzing full pipeline timing.

![Instruction Execution](docs/Pipeline_Execution_Sequence.png)

This helped verify:

- instruction sequencing
- register updates
- ALU results
- memory behavior
- write-back correctness

---

## Pipeline Hazard Analysis

The following diagrams show how instructions move through the pipeline and how hazards are detected and handled.

Hazard analysis includes:

- RAW data dependencies
- forwarding paths
- pipeline stalls
- branch/control flush behavior

![Hazard Analysis Part 1](docs/Pipeline_Hazard_Analysis_Part1.png)

![Hazard Analysis Part 2](docs/Pipeline_Hazard_Analysis_Part2.png)

---

## Simulation and Verification

Functional verification was performed using a SystemVerilog simulation testbench.

The simulation was used to validate:

- instruction fetch and decode behavior
- ALU operation correctness
- register file write-back
- memory write behavior
- forwarding control signals
- stall and flush behavior
- pipeline progression across IF, ID, EX, MEM, and WB stages

![Simulation Waveform](docs/Simulation_Waveform.PNG)

The waveform confirms correct instruction execution and shows the processor’s pipeline behavior during simulation.

---

## FPGA Synthesis

The design was synthesized using **Xilinx Vivado**.

Target FPGA device:

```text
xc7a100tcsg324-1
```

![Vivado Implementation Summary](docs/Project_Summary.PNG)

Synthesis confirms that the SystemVerilog RTL can be processed through an FPGA design flow.

---

## Processor Block Diagram

The overall processor block diagram is shown below.

![Processor Block Diagram](docs/Processor_Block_Diagram.png)

The block diagram illustrates the separation between datapath, control logic, pipeline registers, and hazard-management logic.

---

## Tools Used

- SystemVerilog
- Xilinx Vivado
- Vivado Simulator
- RTL simulation
- Waveform analysis
- FPGA RTL synthesis

---

## Design Specifications

| Feature | Description |
|---|---|
| ISA | RV32I subset |
| Architecture | 5-stage pipeline |
| Pipeline Stages | IF, ID, EX, MEM, WB |
| Hazard Handling | Forwarding, stall, and flush logic |
| Data Hazards | RAW dependencies resolved through forwarding when possible |
| Control Hazards | Branch flush mechanism |
| Memory Model | Separate instruction and data memory |
| Register File | 32 general-purpose registers |
| Implementation | SystemVerilog RTL |
| Verification | SystemVerilog testbench simulation |
| Synthesis | Xilinx Vivado |

---

## Key Design Components

### Controller

The controller decodes instructions and generates control signals for ALU operations, memory access, branch behavior, and register write-back.

### Datapath

The datapath contains the register file, ALU, multiplexers, immediate-generation logic, memory interfaces, and pipeline registers used for instruction execution.

### Hazard Unit

The hazard unit detects pipeline hazards and generates forwarding, stall, and flush signals to maintain correct execution.

### Forwarding Logic

The forwarding unit reduces pipeline stalls by routing results from later pipeline stages back to earlier stages when data dependencies occur.

### Pipeline Registers

Pipeline registers separate the IF, ID, EX, MEM, and WB stages, allowing multiple instructions to progress through the processor concurrently.

---

## Limitations

- Implements an RV32I subset rather than the complete RISC-V ISA.
- Verification is simulation-based and does not include UVM or formal verification.
- The current testbench focuses on directed instruction sequences.
- Cache, interrupt, exception, and privileged-mode support are not implemented.
- FPGA synthesis was completed, but this version is primarily presented as an RTL/simulation project rather than a fully deployed processor system.

---

## Future Improvements

Potential future improvements include:

- Expand instruction coverage for a larger RV32I subset
- Add a self-checking testbench
- Add more directed tests for load-use hazards and branch hazards
- Add instruction/data memory initialization examples
- Add synthesis utilization and timing summary tables
- Add FPGA board deployment notes
- Add branch prediction or improved control-hazard handling
- Add support for interrupts, exceptions, or additional RISC-V instructions
- Explore a more advanced verification flow using assertions or coverage

---

## Project Structure

```text
.
├── docs/                 # Architecture diagrams, waveform captures, and project documentation
├── rtl/                  # SystemVerilog RTL source files
├── simulation/           # Testbench and simulation-related files
├── PROJECT_OVERVIEW.md   # Additional project overview
├── README.md             # Project documentation
└── LICENSE
```

---

## Key Takeaways

This project demonstrates a complete RTL processor-design workflow:

```text
ISA Subset Definition → Datapath Design → Control Logic → Hazard Handling → Simulation → Synthesis
```

The project strengthened my experience with:

- computer architecture
- SystemVerilog RTL design
- pipelined processor implementation
- hazard detection and forwarding
- simulation-based verification
- waveform debugging
- FPGA synthesis using Vivado

---

## Author

**Oluwaferanmi Arowoshola**  
M.S. Electrical & Computer Engineering  
Digital Design · Computer Architecture · SystemVerilog · FPGA · Embedded Systems

## License

This project is licensed under the MIT License.
