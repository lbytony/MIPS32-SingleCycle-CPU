module GPR(
  input [4:0] rs, rt, rd,
  input [31:0] WD,
  input RegWr,
  input clk, rst,
  input [1:0] RegDst,
  output wire [31:0] RD1, RD2
);

  wire [4:0] rDst;
  assign rDst = (RegDst == 2'b00)? rt: (RegDst == 2'b01)? rd: 31;

  reg [31:0] register [31:0];
  integer i;
  initial
  begin
    for (i = 0; i < 32; i=i+1)
      register[i] <= 0;
  end
  assign RD1 = (rs == 0)? 0: register[rs]; 
  assign RD2 = (rt == 0)? 0: register[rt];

  always @(posedge clk or negedge rst)
  begin
    if ((rDst != 0) && RegWr)
      register[rDst] <= WD;
  end
endmodule