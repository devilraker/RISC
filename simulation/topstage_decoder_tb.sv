
module topstage_decoder_tb();
    logic clk;
    logic reset;
    logic we;
    logic [31:0] instr;
    logic [31:0] pc;
    logic [6:0] opcode;
    logic [4:0] rd;
    logic [2:0] func3;
    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [6:0] func7;
    logic [31:0] imm;
    logic [31:0] rd1;
    logic [31:0] rd2;
    logic [31:0] wd;
    logic [3:0] alu_control;
    logic [1:0] alu_op;
    logic [31:0] alu_result;
    logic reg_write;
    logic mem_to_reg;
    logic mem_read;
    logic mem_write;
    logic branch;
    logic alu_src;
    logic jump;
    logic zero;

    
    
top_stage uut(
    .clk(clk),
    .reset(reset),
    .we(we),
    .instr(instr),
    .pc(pc),
    .opcode(opcode),
    .rd(rd),
    .func3(func3),
    .rs1(rs1),
    .rs2(rs2),
    .func7(func7),
    .imm(imm),
    .rd1(rd1),
    .rd2(rd2),
    .alu_control(alu_control),
    .alu_op(alu_op),
    .alu_result(alu_result),
    .zero(zero),
    .wd(wd),
    .reg_write(reg_write),
    .mem_to_reg(mem_to_reg),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .branch(branch),
    .alu_src(alu_src),
    .jump(jump)
    );
initial clk = 0;
always #5 clk=~clk;   
initial begin

    reset = 1;
    we=0;
    #5;
    reset = 0;
    wd= 17;
    we=1;
    #5;
    reset = 1;
    #5;
    reset=0;
    we=0;
    #100;
    end
    
initial begin

    $display("$time\tclk\trst\tpc\tinstr\topcode\trd\tfunc3\trs1\trs2\tfunc7\timm");
    $monitor(" %0t \t %d \t %b \t %h \t %h \t %h \t %h \t %h \t %h \t %h \t %h \t %h \t",$time,clk,reset,pc,instr,opcode,rd,func3,rs1,rs2,func7,imm);
    end
endmodule
