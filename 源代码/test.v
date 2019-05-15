module test;
  reg clk,rst;
  wire [4:0] rd, rs, rt;
  wire [5:0] opcode, funct;
  wire [15:0] imm16;
  wire [25:0] jPC;
  mips mi(clk, rst, opcode, funct, imm16, jPC, rs, rt, rd);
  initial
  begin
    clk = 1'b0;
    rst = 1'b1;
    #5 rst = 1'b0;
    #5 rst = 1'b1;
  end
  always
    begin
      #100 clk = ~clk;
    end
endmodule
