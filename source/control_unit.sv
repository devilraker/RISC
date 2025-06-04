module control_unit(
    input logic [6:0] opcode,
    output logic reg_write,
    output logic mem_to_reg,
    output logic mem_read,
    output logic mem_write,
    output logic branch,
    output logic alu_src,
    output logic [1:0] alu_op,
    output logic jump);

always_comb begin
    reg_write   = 0;       // No register write
    mem_to_reg  = 0;        // No data to register
    mem_read    = 0;        // No memory read
    mem_write   = 0;        // No memory write
    branch      = 0;        // No branching
    alu_src     = 0;        // ALU source is not immediate
    alu_op      = 2'b00;    // Default ALU operation
    jump        = 0;       // No jump
    case (opcode)
        7'b0110011: begin // R-type
            reg_write   = 1;       // Register write enabled
            mem_to_reg  = 0;        // Data to register comes from ALU
            mem_read    = 0;        // No memory read
            mem_write   = 0;        // No memory write
            branch      = 0;        // No branching
            alu_src     = 0;        // ALU source is not immediate
            alu_op      = 2'b10;    // ALU operation for R-type instructions
            jump        = 0;    // ig no jump
        end

        7'b0000011: begin // Load
            reg_write   = 1;       // Register write enabled
            mem_to_reg  = 1;        // Data to register comes from memory
            mem_read    = 1;        // Memory read enabled
            mem_write   = 0;        // No memory write
            branch      = 0;        // No branching
            alu_src     = 1;        // ALU source is immediate
            alu_op      = 2'b00;    // ALU operation for Load instructions
            jump        = 0;     // No jump
        end

        7'b0100011: begin // Store
            reg_write   = 0;       // No register write
            mem_to_reg  = 0;        // No data to register
            mem_read    = 0;        // No memory read
            mem_write   = 1;        // Memory write enabled
            branch      = 0;        // No branching
            alu_src     = 1;        // ALU source is immediate
            alu_op      = 2'b01;    // ALU operation for Store instructions
            jump        = 0;      // No jump
        end

        7'b1100011: begin // Branch
            reg_write   = 0;       // No register write
            mem_to_reg  = 0;        // No data to register
            mem_read    = 0;        // No memory read
            mem_write   = 0;        // No memory write
            branch      = 1;        // Branching enabled
            alu_src     = 0;        // ALU source is not immediate
            alu_op      = 2'b01;    // ALU operation for Branch instructions
            jump        = 0;     // No jump
        end

        7'b1101111: begin // Jump
            reg_write   = 1;       // Register write enabled
            mem_to_reg  = 0;        // Data to register comes from ALU
            mem_read    = 0;        // No memory read
            mem_write   = 0;        // No memory write
            branch      = 0;        // No branching
            alu_src     = 0;        // ALU source is not immediate
            alu_op      = 2'b00;    // ALU operation for Jump instructions
            jump        = 1;       // Jump enabled
        end

        7'b0110111: begin // LUI
            reg_write   = 1;       // Register write enabled
            mem_to_reg  = 0;        // Data to register comes from ALU
            mem_read    = 0;        // No memory read
            mem_write   = 0;        // No memory write
            branch      = 0;        // No branching
            alu_src     = 1;        // ALU source is immediate
            alu_op      = 2'b11;    // ALU operation for LUI instructions
            jump        = 0;       // No jump
        end

        7'b0010011: begin // I-type
            reg_write   = 1;       // Register write enabled
            mem_to_reg  = 0;        // Data to register comes from ALU
            mem_read    = 0;        // No memory read
            mem_write   = 0;        // No memory write
            branch      = 0;        // No branching
            alu_src     = 1;        // ALU source is immediate
            alu_op      = 2'b11;    // ALU operation for I-type instructions
            jump        = 0;       // No jump
        end

        default: begin 
            
        end

    endcase
end
endmodule

