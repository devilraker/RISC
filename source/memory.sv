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
    mem[0] = 32'h06400093; // addi x1, x0, 100     // x1 = 100 (base address)
    mem[1] = 32'h00400113; // addi x2, x0, 4       // x2 = 4   (value to store)
    mem[2] = 32'h0020a023; // sw x2, 0(x1)         // Memory[x1+0] = x2 (store 4 at address 100)
    mem[3] = 32'h0020a223; // sw x2, 4(x1)         // Memory[x1+4] = x2 (store 4 at address 104)
    mem[4] = 32'h0000a183; // lw x3, 0(x1)         // x3 = Memory[x1+0] (should be 4)
    mem[5] = 32'h0040a203; // lw x4, 4(x1)         // x4 = Memory[x1+4] (should be 4)
    mem[6] = 32'h0020c283; // lb x5, 2(x1)         // x5 = sign-extended byte at Memory[x1+2]
    mem[7] = 32'h0020d303; // lbu x6, 2(x1)        // x6 = zero-extended byte at Memory[x1+2]
    mem[8] = 32'h0040c383; // lh x7, 4(x1)         // x7 = sign-extended halfword at Memory[x1+4]
    mem[9] = 32'h0040d403; // lhu x8, 4(x1)        // x8 = zero-extended halfword at Memory[x1+4]
    mem[10] = 32'h00000013; // nop (addi x0, x0, 0)
    end
endmodule
