module EXT(
  input [15:0] imm16, 
  input [1:0] ExtOp, 
  output reg [31:0] imm32);

always @(*) 
begin
  case (ExtOp)
    2'b00:  //Zero extend
      imm32 <= {{16{1'b0}}, imm16[15:0]};
    2'b01:  //Sign extend
      imm32 <= {{16{imm16[15]}}, imm16[15:0]};
    2'b10:  //lui
      imm32 <= {imm16[15:0], {16{1'b0}}};
  endcase
end
endmodule