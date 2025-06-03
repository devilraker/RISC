module alu(
    input logic [31:0] operand_a,
    input logic [31:0] operand_b,
    input logic [3:0] alu_control,
    output logic [31:0] result,
    output logic zero
);
always_comb begin
    case(alu_control)
        4'b0010: result = operand_a + operand_b;  //addition
        4'b0110: result = operand_a - operand_b;  //subtraction
        4'b1000: result = operand_a ^ operand_b;  //xor
        4'b0001: result = operand_a | operand_b;  //or
        4'b0000: result = operand_a & operand_b;  //and
        4'b1001: result = operand_a << operand_b[4:0];//sll logical left shift only lower 5 bits because usual shift amount is 5 getting all 32 bits in a word or smthin
        4'b1010: result = operand_a >> operand_b[4:0]; //srl logical right shift
        4'b1011: result = $signed(operand_a) >>> operand_b[4:0]; //sra arithmetic right shift (u use >>> for sra )
        4'b0111: result = $signed(operand_a) < $signed(operand_b) ? 32'b1 : 32'b0; //slt set less than signed
        4'b1000: result = (operand_a < operand_b) ? 32'b1 : 32'b0; //sltu set less than unsigned
        default: result = 32'b0; //default case
    endcase
    zero = (result == 32'b0) ? 1'b1 :1'b0; //zero flag
end
endmodule
