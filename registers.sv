`timescale 1ns / 1ps

module registers(
    input logic clk,
    input logic reset,
    input logic we,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic [31:0] wd,
    output logic [31:0] rd1,
    output logic [31:0] rd2
 );
 
    logic [31:0] register[0:31];
    
   initial begin
   integer i;
   register[0] = 32'b0;
   for (i=0;i<32;i++) begin
        register[i] = 32'b0;
   end
   register[1]=12;
   register[2]=13;
  end
  always_comb begin 
        rd1  =  register[rs1];
        rd2  =  register[rs2];
    end
   always_ff @(posedge(clk)) begin
   if (reset) begin
        integer i;
            for (i=0;i<32;i++) begin
                register[i] <= 32'b0;
            end
   end
   else begin
        if ((we)&~(rd==5'b0)) begin
        register[rd] <= wd;
        end
    end;
    end
        
endmodule
