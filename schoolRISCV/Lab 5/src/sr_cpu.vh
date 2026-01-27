/*
 * schoolRISCV - small RISC-V CPU 
 *
 * originally based on Sarah L. Harris MIPS CPU 
 *                   & schoolMIPS project
 * 
 * Copyright(c) 2017-2020 Stanislav Zhelnio 
 *                        Aleksandr Romanov 
 */ 

//ALU commands
`define ALU_ADD     3'b000
`define ALU_OR      3'b001
`define ALU_SRL     3'b010
`define ALU_SLTU    3'b011
`define ALU_SUB     3'b100
`define ALU_MUL     3'b111

// instruction opcode
`define RVOP_I      7'b0010011
`define RVOP_BRANCH 7'b1100011
`define RVOP_JUMP   7'b1100111
`define RVOP_L      7'b0110111
`define RVOP_R      7'b0110011

`define RVOP_ADDI   `RVOP_I
`define RVOP_BEQ    `RVOP_BRANCH
`define RVOP_LUI    `RVOP_L
`define RVOP_BNE    `RVOP_BRANCH
`define RVOP_ADD    `RVOP_R
`define RVOP_OR     `RVOP_R
`define RVOP_SRL    `RVOP_R
`define RVOP_SLTU   `RVOP_R
`define RVOP_SUB    `RVOP_R
`define RVOP_MUL    `RVOP_R
`define RVOP_SRLI   `RVOP_I
`define RVOP_JARL   `RVOP_JUMP

// instruction funct3
`define RVF3_ADDI   3'b000
`define RVF3_BEQ    3'b000
`define RVF3_BNE    3'b001
`define RVF3_ADD    3'b000
`define RVF3_OR     3'b110
`define RVF3_SRL    3'b101
`define RVF3_SLTU   3'b011
`define RVF3_SUB    3'b000
`define RVF3_MUL    3'b000
`define RVF3_SRLI   3'b101
`define RVF3_JARL   3'b000
`define RVF3_ANY    3'b???

// instruction funct7
`define RVF7_ADD    7'b0000000
`define RVF7_OR     7'b0000000
`define RVF7_SRL    7'b0000000
`define RVF7_SLTU   7'b0000000
`define RVF7_SUB    7'b0100000
`define RVF7_MUL    7'b0000001
`define RVF7_SRLI   7'b000000?
`define RVF7_ANY    7'b???????

`define PC_PC4_SRC    2'b00
`define PC_BRANCH_SRC 2'b01
`define PC_ALU_SRC    2'b10

`define WD_ALU_SRC    2'b00
`define WD_IMMU_SRC   2'b01
`define WD_PC4_SRC    2'b10
