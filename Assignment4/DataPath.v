module DataPath(input clk,indir_jump_sel,input pc_rst,input [1:0] mem_addr_src,mem_data_src ,input pc_write,mem_write,mem_read,MAR_write,IR_write,MDR_write,alu_src_1,alu_src_2,acc_ld,cy_ld,CLA,CLC,CMA,CMC,RAR,RAL,ROT,IAC,alu_op,ALU_res_write,pc_src,output alu_zero,direct,output [11:0] inst, output acc_sign,output cy_zero,acc_zero);
  wire [11:0] indir_jump_mux_out,alu_result,alu_src_1_mux_out,alu_src_2_mux_out,pc_in,pc_out,mar_out,ir_out,mdr_out,addr_gen_out,address,acc_out,mem_data,memory_out;
  wire [12:0] alu_res_out;
  wire cy_out,alu_carry_out;
  assign inst=ir_out;
  assign acc_sign=acc_out[11];
  assign acc=acc_out;
  assign cy_zero=~(cy_out);
  register #(12) PC(clk,pc_write,pc_rst,pc_in,pc_out);
  Mux_12bit_4to2 mem_adr_mux(pc_out,addr_gen_out,mar_out,12'd0,mem_addr_src,address);
  Mux_12bit_4to2 mem_data_mux(alu_result,acc_out,pc_out,12'd0,mem_data_src,mem_data);
  Memory memory(clk,address,mem_data,mem_write,mem_read,memory_out);
  register #(12) MAR(clk,MAR_write,1'b0,memory_out,mar_out);
  register #(12) IR(clk,IR_write,1'b0,memory_out,ir_out);
  register #(12) MDR(clk,MDR_write,1'b0,memory_out,mdr_out);
  acc accumulator(clk,pc_rst,alu_res_out[11:0],alu_res_out[12],acc_ld,cy_ld,CLA,CLC,CMA,CMC,RAR,RAL,ROT,IAC,acc_out,cy_out,acc_zero);
  Mux_12bit_2to1 alu_src_1_mux(mdr_out,pc_out,alu_src_1,alu_src_1_mux_out);
  Mux_12bit_2to1 alu_src_2_mux(acc_out,12'd1,alu_src_2,alu_src_2_mux_out);
  ALU alu(alu_src_1_mux_out,alu_src_2_mux_out,alu_op,alu_result,alu_carry_out,alu_zero);
  register #(13) ALU_result(clk,ALU_res_write,1'b0,{alu_carry_out,alu_result},alu_res_out);
  Mux_12bit_2to1 pc_mux(alu_result,indir_jump_mux_out,pc_src,pc_in);
  Mux_12bit_2to1 indirect_jump(addr_gen_out,mar_out,indir_jump_sel,indir_jump_mux_out);
  AddressGen address_generator(pc_out[11:7],ir_out[6:0],ir_out[8:7],addr_gen_out,direct);
endmodule

