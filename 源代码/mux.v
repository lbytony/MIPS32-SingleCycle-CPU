module ALUSrc_MUX(RD2, ext32, ALUSrc, B);//choose whether or not to extend
  input ALUSrc;
  input [31:0] RD2, ext32;
  output reg [31:0] B;
  always @(RD2 or ext32 or ALUSrc)
  begin
    if (ALUSrc)
      B = ext32;
    else
      B = RD2;
  end
endmodule

module Mem2Reg_MUX(ALUout, DMout, pc_out32, Mem2Reg, WD);
  input [31:0] ALUout, DMout, pc_out32;
  input [1:0] Mem2Reg;
  output reg [31:0] WD;
  
  always @(ALUout or DMout or pc_out32 or Mem2Reg)
  begin
    case (Mem2Reg)
      2'b00: WD = ALUout;//choose from data
      2'b01: WD = DMout;//choose data from DataMemory,sw
      2'b10: WD = pc_out32; //jal
    endcase
  end
endmodule
