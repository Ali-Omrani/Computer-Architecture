module Mips(input clk,rst);
  wire [11:0] inst;
  wire direct, alu_zero, acc_zero, acc_neg, cy_zero,jump_sel ;
  wire [1:0] mem_adr_mux_sel, mem_data_mux_sel ;
  wire pc_mux_sel, pc_write, mem_read, mem_write, mar_write, mdr_write, ir_write, acc_write, cy_write,
	clc_out, cmc_out, rar_out, ral_out, rot_out, cla_out, cma_out, iac_out,
	alu_src_a, alu_src_b, alu_op, alu_res_write ;
  DataPath DP(clk,jump_sel,rst,mem_adr_mux_sel, mem_data_mux_sel, pc_write, mem_write, mem_read,
   mar_write, ir_write, mdr_write, alu_src_a, alu_src_b, acc_write, cy_write,
   cla_out, clc_out, cma_out, cmc_out, rar_out, ral_out, rot_out, iac_out,
   alu_op, alu_res_write, pc_mux_sel,
   alu_zero, direct, inst, acc_neg, cy_zero, acc_zero);  
  
  controller Controller(clk,rst, inst,direct, alu_zero, acc_zero, acc_neg, cy_zero, mem_adr_mux_sel, mem_data_mux_sel, 
  pc_mux_sel, pc_write, 
	mem_read, mem_write, 
	mar_write, mdr_write, ir_write,
	acc_write, cy_write,
	clc_out, cmc_out, rar_out, ral_out, rot_out, cla_out, cma_out, iac_out,
	alu_src_a, alu_src_b, alu_op, alu_res_write,jump_sel);
  
endmodule