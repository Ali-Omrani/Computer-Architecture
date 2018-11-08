`timescale 1ps/1ps
module DataPath(input start,input [1:0]Regdst,Regdatawrtsrc,input[2:0] ALUOp,input Regwrt,ALUSrc,Memwrt,Memread,Memtoreg,input [1:0]Pcsrc,input Branch,SelSh,clk,output [5:0]opcode,output[31:0] alu_out,output [5:0] func,output zero);
  wire [31:0] address;
  wire [31:0] instruction;
  wire [31:0] pcinput;
  wire [31:0] pcoutput;
  wire [4:0]  wr_reg_mux_output;
  wire [31:0] mem_to_reg_mux_out;
  wire [31:0] pc_adder_output;
  wire [31:0] wr_data_mux_output;
  wire [31:0] ReadData1;
  wire [31:0] ReadData2;
  wire [31:0] im_signext_output;
  wire [31:0] alu_src_mux_output;
  wire [31:0] mem_out;
  wire [31:0] j_sign_ext_out;
  wire [31:0] shift_in_mux_out;
  wire [31:0] shift_out;
  wire [31:0] jump_adder_out;
  assign opcode=instruction[31:26];
  assign func=instruction[5:0];
  Register PC(1'b1,clk,start,pcinput,pcoutput);
  InstructionMemory Instructions(pcoutput,instruction);
  Mux_5bit_2to4 wr_reg_mux(instruction[20:16],instruction[15:11],5'b11111,Regdst,wr_reg_mux_output);
  Adder pc_adder(pcoutput,32'd4,pc_adder_output);
  Mux_32bit_2to4 wr_data_mux(mem_to_reg_mux_out,pc_adder_output,{instruction[15:0],ReadData1[15:0]},32'b0,Regdatawrtsrc,wr_data_mux_output);
  RegisterFile registers(clk,instruction[25:21],instruction[20:16],wr_reg_mux_output,wr_data_mux_output,Regwrt,ReadData1,ReadData2);
  SignExt sign_extention(instruction[15:0],im_signext_output);
  Mux_32bit_1to2 alu_src_mux(ReadData2,im_signext_output,ALUSrc,alu_src_mux_output);
  ALU alu(ReadData1,alu_src_mux_output,ALUOp,alu_out,zero);
  DataMemory memory(clk,alu_out,ReadData2,Memwrt,Memread,mem_out);
  Mux_32bit_1to2 mem_to_reg_mux(alu_out,mem_out,Memtoreg,mem_to_reg_mux_out);
  SignExt_26to32 jump_sign_ext(instruction[25:0],j_sign_ext_out);
  Mux_32bit_1to2 shift_in_mux(im_signext_output,j_sign_ext_out,SelSh,shift_in_mux_out);
  Shifter shifter(shift_in_mux_out,shift_out);
  Adder jump_adder(shift_out,pc_adder_output,jump_adder_out);
  Mux_32bit_2to4 pc_mux(pc_adder_output,jump_adder_out,{pcoutput[31:28],shift_out[27:0]},ReadData1,Pcsrc,pcinput);
  
endmodule

