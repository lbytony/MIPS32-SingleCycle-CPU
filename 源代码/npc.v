module NPC(
    input [29:0] curPC,
    input nPC_sel,
    input zero,
    input j,
    input jr,
    input [25:0] j_imm26, 
    input [15:0] imm16,
    input [31:0] Data,
    output reg [29:0] nPC,
    output reg [31:0] PC32
);

reg [29:0] imm30;
reg [30:0] ext;

always @(nPC_sel or zero or j or jr or j_imm26 or Data or imm16 or curPC) 
begin
    if (nPC_sel && zero)
    begin
        if (imm16[15] == 0)     //Extender
            nPC = {{14{1'b0}}, imm16[15:0]};
        else
            nPC = {{14{1'b0}}, imm16[15:0]};
        nPC = nPC + curPC + 1;
        PC32 = {nPC, 2'b00};
    end
    else if (j)                 //j & jal
    begin
        nPC = {curPC[29:26], j_imm26};
        PC32 = {curPC + 1, 2'b00};
    end
    else if (jr)                //jr
    begin
        nPC = Data[31:2];
    end
    else
    begin
        nPC = curPC + 1;
    end
end
endmodule