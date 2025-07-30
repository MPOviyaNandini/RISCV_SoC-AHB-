module Instruction_Memory (
    input  logic        clk,
    input  logic        reset,
    input  logic        HSEL1,
    input  logic        rd_en_rom,
    input  logic [31:0] address_rom,  // word address
    output logic [31:0] instruction
);

    logic [31:0] mem [0:255];  // 256 words = 1KB

    // Initialize ROM contents
    initial begin
        mem[0]  = 32'hfc010113;
        mem[1]  = 32'h02112e23;
        mem[2]  = 32'h02812c23;
        mem[3]  = 32'h04010413;
        mem[4]  = 32'hfc042223;
        mem[5]  = 32'h00100793;
        mem[6]  = 32'hfcf42423;
        mem[7]  = 32'h00200793;
        mem[8]  = 32'hfef42623;
        mem[9]  = 32'h0580006f;
        mem[10] = 32'hfec42783;
        mem[11] = 32'hfff78713;
        mem[12] = 32'hfc440793;
        mem[13] = 32'h00271713;
        mem[14] = 32'h00f707b3;
        mem[15] = 32'h0007a703;
        mem[16] = 32'hfec42783;
        mem[17] = 32'hffe78693;
        mem[18] = 32'hfc440793;
        mem[19] = 32'h00269693;
        mem[20] = 32'h00f687b3;
        mem[21] = 32'h0007a783;
        mem[22] = 32'h00f70733;
        mem[23] = 32'hfec42683;
        mem[24] = 32'hfc440793;
        mem[25] = 32'h00269693;
        mem[26] = 32'h00f687b3;
        mem[27] = 32'h00e7a023;
        mem[28] = 32'hfec42783;
        mem[29] = 32'h00178793;
        mem[30] = 32'hfef42623;
        mem[31] = 32'hfec42703;
        mem[32] = 32'h00900793;
        mem[33] = 32'hfae7d2e3;
        mem[34] = 32'h0000006f;
    end

    always_ff @(posedge clk) begin
        if (!reset && HSEL1 && rd_en_rom) begin
           instruction = mem[address_rom[9:2]]; 
        end
        else begin
            instruction <= 32'b0;
        end
    end

endmodule
