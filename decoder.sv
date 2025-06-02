`timescale 1ns / 1ps
module decoder(
    input logic [31:0] instr,
    output logic [6:0] opcode,
    output logic [4:0] rd,
    output logic [2:0] func3,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [6:0] func7,
    output logic [31:0] imm
    );
    localparam R_FORMAT = 3'd1 , I_FORMAT = 3'd2 , S_FORMAT = 3'd3 , B_FORMAT = 3'd4 , U_FORMAT =3'd5 , J_FORMAT = 3'd6;
    logic [2:0] format_type;
    
    
 always_comb begin
    opcode = instr[6:0];
    
    case (opcode)
        7'b0010011,7'b0000011,7'b000111,7'b1110011,7'b1100111: format_type = I_FORMAT;
        
        7'b0110011: format_type = R_FORMAT;
        
        7'b0100011: format_type = S_FORMAT;
        
        7'b1100011: format_type = B_FORMAT;
        
        7'b0110111: format_type = U_FORMAT;
        
        7'b1101111: format_type = J_FORMAT;
        
        default:    format_type = I_FORMAT;  
    endcase
    rd    =  5'b0;
    func3 =  3'b0;
    rs1   =  5'b0;
    rs2   =  5'b0;
    func7 =  7'b0;
    imm   =  32'b0;
 
    if (format_type == R_FORMAT ) begin
         rd     = instr[11:7];
         func3  = instr[14:12];
         rs1    = instr[19:15];
         rs2    = instr[24:20];
         func7  = instr[31:25];
    end
    
    else if (format_type == I_FORMAT ) begin
         rd     = instr[11:7];
         func3  = instr[14:12];
         rs1    = instr[19:15];
         imm    = $signed(instr[31:20]);
    end
    
    else if (format_type == S_FORMAT) begin
         func3  = instr[14:12];
         rs1    = instr[19:15];
         rs2    = instr[24:20];
         imm    = $signed({instr[31:25],instr[11:7]});
    end
    
    else if (format_type == U_FORMAT) begin
         rd  = instr[11:7];
         imm    = {instr[31:12],12'b0};
    end
    
    else if (format_type == B_FORMAT) begin
        func3  = instr[14:12];
        rs1    = instr[19:15];
        rs2    = instr[24:20];
        imm = $signed({instr[31], instr[7], instr[30:25], instr[11:8], 1'b0});
       end

    
    else if (format_type == J_FORMAT) begin
         rd  = instr[11:7];
         imm = {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
    end
end   
endmodule
