module PC(
  input clk,
  input rst,
  input [29:0] nPC, 
  output [29:0] curPC);
  
  reg [29:0] pc;
  assign curPC = pc;
  always @ (posedge clk or negedge rst) 
  begin
    if (!rst)
      pc <= 7'h0000_300;
    else
      pc <= nPC;
  end
endmodule