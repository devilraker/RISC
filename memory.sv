`timescale 1ns / 1ps

module memory(
    input logic[31:0] addr,
    output logic [31:0] instr
    );
    
    logic [31:0] mem [0:255];
    
    assign instr = mem[addr[9:2]];
    
    initial begin
    integer i; 
    for (i=0; i<256 ; i=i+1) begin
    mem[i] = 32'h00000000;
    end
    end
    initial begin 
    mem[0] = 32'h00100093; // addi x1, x0, 1
    mem[1] = 32'h00200113; // addi x2, x0, 2
    mem[2] = 32'h002081b3; // add  x3, x1, x2
    mem[3] = 32'h00000013; // nop (addi x0, x0, 0)
    end
endmodule
