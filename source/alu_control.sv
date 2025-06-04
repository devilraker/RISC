module alu_control(
    input logic [6:0] func7,
    input logic [2:0] func3,
    input logic [6:0] opcode,
    output logic [3:0] alu_control,
    output logic [1:0] alu_op
);

always_comb begin
    case (opcode)
        //r type instructions  R-TYPE
        7'b0110011: begin
            alu_op = 2'b10; // ALU operation for (R)-type instructions
            case (func3)
                3'b000:  alu_control =  (func7 == 7'b0000000) ? 4'b0010 : 4'b0110; //for add/sub
                3'b100:  alu_control =  4'b1000; //for xor
                3'b110:  alu_control =  4'b0001; //for or;
                3'b111:  alu_control =  4'b0000; // for and
                3'b001:  alu_control =  4'b1001; //for sll logical left shift
                3'b101:  alu_control =  (func7 == 7'b0000000) ? 4'b1010 : 4'b1011; //for srl logical right shift and sra arithmetic right shift
                3'b010:  alu_control =  4'b0111; //for slt set less than
                3'b011:  alu_control =  4'b1100; //for sltu set less than unsigned
                default: alu_control =  4'bxxxx; //undefined;
            endcase
        end
        //Immediate instructions  I_TYPE
        7'b0010011: begin
            alu_op = 2'b11; //alu operation for Immediate  (I)- type instructionss
            case (func3)
                3'b000:  alu_control =  (func7 == 7'b0000000) ?4'b0010 : 4'b0110; //for addi
                3'b100:  alu_control =  4'b1000; //for xori
                3'b110:  alu_control =  4'b0001; //for ori
                3'b111:  alu_control =  4'b0000; //for andi
                3'b001:  alu_control =  4'b1001; //for slli logical left shift immediate
                3'b101:  alu_control =  (func7 == 7'b0000000) ? 4'b1010 : 4'b1011; //for srli logical right shift immediate and srai arithmetic right shift immediate
                3'b010:  alu_control =  4'b0111; //for slti set less than immediate
                3'b011:  alu_control =  4'b1100; //for sltiu set less than unsigned immediate
                default: alu_control =  4'bxxxx;  //undefined;
            endcase
        end

        //Load instructions  L_TYPE
        7'b0000011: begin
            alu_op = 2'b00;
            alu_control = 4'b0010;              // load using and operation
            case (func3)
                3'b000:  alu_control = 4'b0010;  // same stuff but whatever
                3'b001:  alu_control = 4'b0010; 
                3'b010:  alu_control = 4'b0010; 
                3'b100:  alu_control = 4'b0010; 
                3'b101:  alu_control = 4'b0010; 
                default: alu_control = 4'bxxxx;
            endcase
        end

        //Store instructions  S_TYPE
        7'b0100011: begin
            alu_op = 2'b01;
            alu_control = 4'b0010;              //store only using add operation
        end

        //Branch instructions  B_TYPE
        7'b1100011: begin
            alu_op = 2'b01;
            case (func3)
                3'b000:  alu_control = 4'b0110;  // BEQ (Branch if Equal)
                3'b001:  alu_control = 4'b0110;  // BNE (Branch if Not Equal)
                3'b100:  alu_control = 4'b0111;  // BLT (Branch if Less Than)
                3'b101:  alu_control = 4'b1001;  // BGE (Branch if Greater Than or Equal)
                3'b110:  alu_control = 4'b1100;  // BLTU (Branch if Less Than Unsigned)
                3'b111:  alu_control = 4'b1010;  // BGEU (Branch if Greater Than or Equal Unsigned)
                default: alu_control = 4'bxxxx; // Undefined 
            endcase
        end

        //JAL , JALR , AUIPC instructions

        7'b1101111: begin                       // JAL
            alu_op = 2'b10;                     // ALU operation for JAL
            alu_control = 4'b0010;              // Use ADD for JAL
        end

        7'b1100111: begin                       // JALR
            alu_op = 2'b10;                     // ALU operation for JALR
            alu_control = 4'b0010;              // Use ADD for JALR
        end
        
        7'b0010111: begin                       // AUIPC
            alu_op = 2'b10;                     // ALU operation for AUIPC
            alu_control = 4'b0010;              // Use ADD for AUIPC
        end 

        default: begin
            alu_op =2'bxx;
            alu_control = 4'bxxxx;
        end


    endcase
end
endmodule

// adding stuff to git chck
// now checking out a branch



















        