`timescale 1ns / 1ps

module ProgramCounter (
    input logic clk,
    input logic reset,
    input logic [31:0] next_pc,
    output logic [31:0] pc
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 32'h00000000;  // Reset to address 0
        else
            pc <= next_pc;
    end
endmodule


