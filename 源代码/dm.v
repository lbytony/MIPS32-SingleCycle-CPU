module DM(addr2, din, MemWr, clk, dout);
  input   [11:2]  addr2;  // address bus
  input   [31:0]  din;   // 32-bit input data
  input           MemWr;    // memory write enable
  input           clk;   // clock
  output wire [31:0]  dout;  // 32-bit memory output

  reg     [31:0]  dm[1023:0];
  integer i;
  initial
  begin
    for (i = 0; i < 1024; i = i + 1)
      dm[i] = 0;
  end
  assign dout = dm[addr2];
  always @(posedge clk)
  begin
    if (MemWr) 
      dm[addr2] <= din;
  end
endmodule