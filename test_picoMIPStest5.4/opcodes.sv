
//opcodes

//INPUT %d SW[7:0]; %d = SW[7:0]
`define INPUT  3'b000

// ADD %d, %s;  %d = %d+%s
`define ADD  3'b001

// ADDI %d, %s, imm ;  %d = %s + imm
`define ADDI 3'b010

//`define SUB 3'b011
// MUL %d  %d imm;  %d = %d*imm
`define MULI 3'b011

// HOLD - branch
`define HOLD 3'b100
