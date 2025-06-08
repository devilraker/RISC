module memory(
    input logic clk,
    input logic memory_write,
    input logic memory_read,
    input logic [31:0] addr,
    input logic [31:0] write_data,
    input logic [2:0] func3,
    output logic [31:0] read_data
    );
    logic [31:0] memory_array [0:255]; // 256 words of memory
    // Each word is 32 bits, so we can address 256 * 4 = 1024 bytes of memory
    initial begin
        integer i; 
        for (i = 0; i < 256; i = i + 1) begin
            memory_array[i] = 32'h00000000; // Initialize all memory to zero
        end
    end

    always_comb begin
        read_data = 32'h00000000; // Default value for read_data
        if (memory_read) begin
            read_data = memory_array[addr[11:2]]; // Read from memory
            case(func3) begin
                3'b000: read_data = $signed(memory_array[addr[11:2]]);  //load byte)
                3'b001: read_data = $signed(emory_array[addr[7:2]]); // load it into signed halfword
                3'b010: read_data = memory_array[addr] // 32 bit load word
                3'b100: read_data = $unsigned(memory_array[addr[11:2]]); // load byte unsigned
                3'b101: read_data = $unsigned(memory_array[addr[7:2]]); // load halfword unsigned
            end
            endcase
        end
    end

    always_ff(posedge clk) begin
        if memory_write begin
            case(func3) begin
                3'b000: memory_array[addr[11:2]] <= {memory_array[addr[11:2]][31:8], write_data[7:0]}; // Store byte
                3'b001: memory_array[addr[11:2]] <= {memory_array[addr[11:2]][31:16], write_data[15:0], memory_array[addr[11:2]][7:0]}; // Store halfword
                3'b010: memory_array[addr[11:2]] <= write_data; // Store word
                3'b100: memory_array[addr[11:2]] <= {memory_array[addr[11:2]][31:8], write_data[7:0]}; // Store byte unsigned
                3'b101: memory_array[addr[11:2]] <= {memory_array[addr[11:2]][31:16], write_data[15:0], memory_array[addr[11:2]][7:0]}; // Store halfword unsigned
            end
            endcase
        end
    end
endmodule



