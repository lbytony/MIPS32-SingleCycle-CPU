module mips(
  input clk, 
  input rst, 
  output [5:0] opcode,
  output [5:0] funct,
  output wire [15:0] imm16,
  output wire [25:0] j_imm26,
  output [4:0] rs,
  output [4:0] rt,
  output [4:0] rd
);

  //PC
  wire [29:0] curPC, nPC;
  wire [31:0] PC32;
  //Controller
  wire overflow, ALUSrc, RegWr, MemWr, nPC_sel, j, jr;
  wire [1:0] RegDst, Mem2Reg, ExtOp;
  wire [2:0] ALUOp;
  //IFU
  wire [31:0] Instr;
  //ALU
  wire zero;
  wire [31:0] ALUout;
  //GPR
  wire [31:0] RD1, RD2, WD;
  //DM
  wire [31:0] DMout;
  wire [9:0] addr2;
  //IM
  wire [9:0] addr1;
  //EXT
  wire [31:0] ext32;
  
  assign opcode = Instr[31:26];
  assign funct = Instr[5:0];
  assign imm16 = Instr[15:0];
  assign j_imm26 = Instr[25:0];
  assign rs = Instr[25:21];
  assign rt = Instr[20:16];
  assign rd = Instr[15:11];

  assign addr1 = curPC[9:0];
  assign addr2 = ALUout[11:2];
  
  PC pc(clk, rst, nPC, curPC);
  NPC npc(curPC, nPC_sel, zero, j, jr, j_imm26, imm16, RD1, nPC, PC32);
  IM im(addr1, Instr);
  GPR gpr(rs, rt, rd, WD, RegWr, clk, rst, RegDst, RD1, RD2);
  ALU alu(RD1, RD2, ext32, ALUSrc, ALUOp, zero, overflow, ALUout);
  EXT ext(imm16, ExtOp, ext32);
  DM dm(addr2, RD2, MemWr, clk, DMout);
  Mem2Reg_MUX mem2regmux(ALUout, DMout, PC32, Mem2Reg, WD);
  CONTROL ctrl(Instr,nPC_sel,ALUOp,ALUSrc,MemWr,RegWr, RegDst,Mem2Reg,ExtOp,overflow);
  //ControlUnit ctrl(opcode, funct, overflow, RegDst, ALUSrc, Mem2Reg, RegWr, MemWr, nPC_sel, ExtOp, ALUOp, j, jr);
endmodule