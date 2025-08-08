
module Data_Memory (
    input  logic        clk,
    input  logic        mem_write,
    input  logic        mem_read,
    input  logic [31:0] address_ram,
    input  logic        HSEL2,
    input  logic [31:0] write_data,   // Value from t1
    input  logic        reset,
    output logic [31:0] read_data     // Value loaded to register
);

    // Byte-addressable memory: 1KB
    logic [7:0] mem_ram [0:1023];  // 1KB

    // Synchronous Write and Reset
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 1024; i++)
                mem_ram[i] <= 8'b0;
        end else if (mem_write && HSEL2) begin
            // Store word in little-endian format
            mem_ram[address_ram]     <= write_data[7:0];    // Least significant byte
            mem_ram[address_ram + 1] <= write_data[15:8];
            mem_ram[address_ram + 2] <= write_data[23:16];
            mem_ram[address_ram + 3] <= write_data[31:24];  // Most significant byte
        end
    end

    // Combinational Read
    always_comb begin
        if (mem_read && HSEL2) begin
            read_data = {mem_ram[address_ram + 3], mem_ram[address_ram + 2], mem_ram[address_ram + 1], mem_ram[address_ram]};
        end else begin
            read_data = 32'd0;
        end
    end

endmodule
