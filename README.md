# Traffic Light Controller using Verilog HDL

A simple Finite State Machine (FSM) based Traffic Light Controller designed and simulated using Verilog HDL and Icarus Verilog (iverilog).

## Project Objective

The objective of this project is to design and simulate a digital traffic light controller using Verilog HDL. The system changes traffic lights sequentially using FSM (Finite State Machine) logic.

## Features

- FSM-based design
- RED → GREEN → YELLOW sequence
- Reset functionality
- Counter-based timing control
- Verilog HDL implementation
- Testbench verification
- Simulation using Icarus Verilog


## State Timing

| State  | Duration |
|--------|----------|
| RED    | 6 clock cycles |
| GREEN  | 4 clock cycles |
| YELLOW | 2 clock cycles |


## FSM Diagram

        RED
         |
         v
      GREEN
         |
         v
      YELLOW
         |
         v
        RED

## Project Files

| File Name             | Description           |
| --------------------- | --------------------- |
| traffic_light.v       | Main FSM design       |
| test_traffic_light.v  | Testbench file        |
| output.txt            | Simulation output     |
| simulation_output.png | Simulation screenshot |

## Tools Used

* Verilog HDL
* Icarus Verilog (iverilog)
* VS Code


## Compilation and Simulation

### Compile

iverilog -o traffic_sim traffic_light.v test_traffic_light.v

### Run Simulation

vvp traffic_sim

### Save Simulation Output

vvp traffic_sim > output.txt

## Sample Simulation Output

```text
================================================
   Traffic Light Controller FSM - Simulation
================================================

[TEST 1] Applying Reset...
[MONITOR] Time=0 ns | RED=1 GREEN=0 YELLOW=0

[TEST 2] RED Phase
Cycle 1 | R=1 G=0 Y=0
Cycle 2 | R=1 G=0 Y=0

[MONITOR] Time=65000 ns | RED=0 GREEN=1 YELLOW=0

[TEST 3] GREEN Phase
Cycle 7 | R=0 G=1 Y=0

[MONITOR] Time=105000 ns | RED=0 GREEN=0 YELLOW=1

## Simulation Screenshot

![Simulation Output](simulation_output.png)


## Learning Outcomes

Through this project, the following concepts were learned:

* Finite State Machine (FSM)
* Sequential Logic
* Clocked Circuits
* Verilog HDL Basics
* Testbench Design
* Digital System Simulation

## Author

Rownak
Electrical & Computer Engineering
RUET


