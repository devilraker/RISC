module ex_stage(
    input logic [31:0] rd1,
    input logic [31:0] rd2,
    input logic alu_src,
    input logic [31:0] imm,
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode,
    output logic [3:0] alu_control,
    output logic [1:0] alu_op,
    output logic [31:0] result,
    output logic zero
);

logic [31:0] operand_b;

assign operand_b = (alu_src) ? imm : rd2;

alu_control alu_control_inst(
    .func7(func7),
    .func3(func3),
    .opcode(opcode),
    .alu_control(alu_control),
    .alu_op(alu_op)
);

alu alu_inst(
    .operand_a(rd1),
    .operand_b(operand_b),
    .alu_control(alu_control),
    .result(result),
    .zero(zero)
);

endmodule