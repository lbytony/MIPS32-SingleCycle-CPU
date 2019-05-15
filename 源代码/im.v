module IM(addr1, IMout);
  input [9:0] addr1;
  output reg [31:0] IMout;
  reg [31:0] im [1023:0];
  initial
  begin
    $readmemh("C:/Users/lbyto/Desktop/Project2/code.txt", im);
    IMout = 0;
  end
  always @(addr1)
  begin
    IMout = im[addr1];
  end
endmodule