module ControlUnit(
    input [5:0] opcode,
    input [5:0] funct,
    input overflow, 
    output reg [1:0] RegDst,
    output reg ALUSrc,
    output reg [1:0] Mem2Reg,
    output reg RegWr,
    output reg MemWr,
    output reg nPC_sel,
    output reg [1:0]   ExtOp,
    output reg [2:0]   ALUOp,
    output reg j,
    output reg jr
);

    parameter RType = 6'b000000, ADDI = 6'b001000, ADDIU = 6'b001001, 
            ORI = 6'b001101, SW = 6'b101011, LW = 6'b100011, 
            BEQ = 6'b110000, LUI = 6'b001111, J = 6'b000010,
            JAL = 6'b000011;

    parameter ADD = 6'b100000, ADDU = 6'b100001, SUB = 6'b100010,
            SUBU = 6'b100011, SLT = 6'b101010, JR = 6'b001000;
            
    always @(*)
    begin
        case (opcode)
            RType:
                case (funct) 
                    ADD:
                      begin
                        RegDst = 1;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = (overflow)? 0: 1;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 0;
                        j = 0;
                        jr = 0;
                      end
                    ADDU:
                      begin
                        RegDst = 1;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = (overflow)? 0: 1;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 0;
                        j = 0;
                        jr = 0;
                      end
                    SUB:
                      begin
                        RegDst = 1;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = (overflow)? 0: 1;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 1;
                        j = 0;
                        jr = 0;
                      end
                    SUBU:
                      begin
                        RegDst = 1;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = (overflow)? 0: 1;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 1;
                        j = 0;
                        jr = 0;
                      end
                    SLT:
                      begin
                        RegDst = 0;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = (overflow)? 0: 1;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 3'b011;
                        j = 0;
                        jr = 0;
                      end
                    JR:
                      begin
                        RegDst = 0;
                        ALUSrc = 0;
                        Mem2Reg = 0;
                        RegWr = 0;
                        MemWr = 0;
                        nPC_sel = 0;
                        ExtOp = 0;
                        ALUOp = 0;
                        j = 0;
                        jr = 1;
                      end
                endcase
            ADDI:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 0;
                RegWr = (overflow)? 0: 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 0;
                ALUOp = 3'b100;
                j = 0;
                jr = 0;
              end
            ADDIU:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 0;
                RegWr = (overflow)? 0: 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 0;
                ALUOp = 0;
                j = 0;
                jr = 0;
              end
            ORI:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 0;
                RegWr = (overflow)? 0: 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 0;
                ALUOp = 2'b10;
                j = 0;
                jr = 0;
              end
            LW:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 1;
                RegWr = (overflow)? 0: 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 1;
                ALUOp = 0;
                j = 0;
                jr = 0;
              end
            SW:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 0;
                RegWr = 0;
                MemWr = 1;
                nPC_sel = 0;
                ExtOp = 1;
                ALUOp = 0;
                j = 0;
                jr = 0;
              end
            LUI:
              begin
                RegDst = 0;
                ALUSrc = 1;
                Mem2Reg = 0;
                RegWr = 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 2'b10;
                ALUOp = 2'b10;
                j = 0;
                jr = 0;
              end
            BEQ:
              begin
                RegDst = 0;
                ALUSrc = 0;
                Mem2Reg = 0;
                RegWr = 0;
                MemWr = 0;
                nPC_sel = 1;
                ExtOp = 0;
                ALUOp = 1;
                j = 0;
                jr = 0;
              end
            J:
              begin
                RegDst = 0;
                ALUSrc = 0;
                Mem2Reg = 0;
                RegWr = 0;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 0;
                ALUOp = 0;
                j = 1;
                jr = 0;
              end
            JAL:
              begin
                RegDst = 10;
                ALUSrc = 0;
                Mem2Reg = 2'b10;
                RegWr = (overflow)? 0: 1;
                MemWr = 0;
                nPC_sel = 0;
                ExtOp = 0;
                ALUOp = 0;
                j = 1;
                jr = 0;
              end
        endcase
    end
endmodule