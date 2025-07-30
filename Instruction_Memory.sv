module Instruction_Memory (
    input  logic        clk,
    input  logic        reset,
    input  logic        HSEL1,
    input  logic        rd_en_rom,
    input  logic [31:0] address_rom,
    output logic [31:0] instruction
);

    // Define ROM with 5 entries
    logic [31:0] rom [0:4];
    logic [2:0]  rom_index;

    // Derive 4-byte aligned word address (byte offset/4)
    assign rom_index = address_rom[4:2]; // Use [4:2] for correct word-aligned indexing

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            rom[0] <= 32'h002081b3;  // add x3, x1, x2
            rom[1] <= 32'h40218233;  // sub x4, x3, x2
            rom[2] <= 32'h0020c2b3;  // add x5, x1, x2
            rom[3] <= 32'h0020e333;  // add x6, x1, x2 (optional)
            rom[4] <= 32'h0020f3b3;  // add x7, x1, x2 (optional)
            instruction <= 32'b0;
        end else if (rd_en_rom && HSEL1 && rom_index <= 3'd4) begin
            instruction <= rom[rom_index];
        end else begin
            instruction <= 32'b0;
        end
    end

endmodule
