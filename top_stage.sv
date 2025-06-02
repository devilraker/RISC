`timescale 1ns / 1ps

module top_stage(
    input logic clk,
    input logic reset,
    input logic we,
    output logic [31:0] instr,
    output logic [31:0] pc,
    output logic [6:0] opcode,
    output logic [4:0] rd,
    output logic [2:0] func3,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [6:0] func7,
    output logic [31:0] imm,
    output logic [31:0] rd1,
    output logic [31:0] rd2,
    output logic [3:0] alu_control,
    output logic [1:0] alu_op,
    input logic [31:0] wd
    );
    
    logic [31:0] next_pc;
    
    decoder decoderinst (
        .instr(instr),
        .opcode(opcode),
        .rd(rd),
        .func3(func3),
        .rs1(rs1),
        .rs2(rs2),
        .func7(func7),
        .imm(imm));
    
    ProgramCounter uut(
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc));
    
    pc_adder uut2(
        .pc(pc),
        .next_pc(next_pc));
    
    memory memory_instan(
        .addr(pc),
        .instr(instr));
        
    registers resgistersinst(
        .clk(clk),
        .reset(reset),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2));

    alu_control alu_control_inst(
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .alu_control(alu_control),
        .alu_op(alu_op));

        
    
    
endmodule

