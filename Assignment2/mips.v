`timescale 1ps/1ps
module mips(input clk,input start,output [31:0] ALU_out);
  wire [5:0] Opcode;
  wire [5:0] Func;
  wire Zero;
  wire [1:0] PcSrc,Regdst,Regdatawrtsrc;
  wire [2:0] ALUOp;
  wire [5:0] opcode;
  wire [5:0] func;
  wire [2:0] ALUOperation;
  wire Regwrt, ALUSrc, Memwrt, Memread, MemtoReg, Branch, SelSh;
  ALU_controller alu_controller(func,ALUOp,ALUOperation);
  Controller controller(opcode,func,zero,Regdst,Regdatawrtsrc,ALUOp,Regwrt,ALUSrc, Memwrt, Memread, MemtoReg, PcSrc,Branch, SelSh);
  DataPath DP(start,Regdst,Regdatawrtsrc,ALUOperation,Regwrt,ALUSrc, Memwrt, Memread, MemtoReg, PcSrc,Branch, SelSh,clk,opcode,ALU_out,func,zero);
endmodule
