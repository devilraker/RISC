`timescale 1ns / 1ps

module top_stage_tb();
    logic clk;
    logic reset;
    logic [31:0] instr;
    logic [31:0] pc;
    
    top_stage top_stage_inst(
        .clk(clk),
        .reset(reset),
        .instr(instr),
        .pc(pc));
    
    always #5 clk=~clk;        
    initial begin
    clk=0;
    reset=1;
    #10;
    reset=0;
    #10;
    reset=1;
    #5;
    reset=0;
    end
    
    initial begin 
    $display("$time\tclk\trst\tpc\tinstr\t");
    $monitor(" %0t \t %d \t %b \t %h \t %h \t",$time,clk,reset,pc,instr);
    end
endmodule
