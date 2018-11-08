module controller
(
	//inputs
	input clk, rst,
	input [11:0] inst, 
	input dir, alu_zero, acc_zero, acc_neg, cy_zero,
	//outputs
	output reg [1:0] mem_adr_mux_sel, mem_data_mux_sel,
	output reg pc_mux_sel, pc_write, 
	mem_read, mem_write, 
	mar_write, mdr_write, ir_write,
	acc_write, cy_write,
	clc_out, cmc_out, rar_out, ral_out, rot_out, cla_out, cma_out, iac_out,
	alu_src_a, alu_src_b, alu_op, alu_res_write,jump_sel
);
	
	
	// present state, next state
	reg [4:0] ps, ns;
	
	
	// states
	localparam [4:0] s0 = 5'd0, s1 = 5'd1, s2 = 5'd2, s3 = 5'd3,
	s4 = 5'd4, s5 = 5'd5, s6 = 5'd6, s7 = 5'd7, s8 = 5'd8,
	s9 = 5'd9, s10 = 5'd10, s11 = 5'd11, s12 = 5'd12, s13 = 5'd13,
	s14 = 5'd14, s15 = 5'd15, s16= 5'd16;
	
	//wires
	wire [2:0] opcode;
	assign opcode = inst[11:9];
	wire gp2;
	assign gp2 = inst[8];
	wire clc, cmc, rar, ral, rot, cla, cma, iac;
	assign cla = inst[7];
	assign clc = inst[6];
	assign cma = inst[5];
	assign cmc = inst[4];
	assign rar = inst[3];
	assign ral = inst[2];
	assign rot = inst[1];
	assign iac = inst[0];
	wire sma, sza, snc;
	assign sma = inst[7];
	assign sza = inst[6];
	assign snc = inst[5];

	always @( ps , inst , alu_zero , acc_zero , acc_neg , cy_zero) begin
		mem_adr_mux_sel = 2'd0; mem_data_mux_sel = 2'd0;
		pc_mux_sel = 1'd0; pc_write = 1'd0; mem_read = 1'd0; mem_write = 1'd0; 
	    mar_write = 1'd0; mdr_write = 1'd0; ir_write = 1'd0;
		acc_write = 1'd0; cy_write = 1'd0; jump_sel=1'd0;
		alu_src_a = 1'd0; alu_src_b = 1'd0; alu_op = 1'd0; alu_res_write = 1'd0;
		clc_out = 1'd0; cmc_out = 1'd0; rar_out = 1'd0; ral_out = 1'd0; rot_out = 1'd0; cla_out = 1'd0; cma_out = 1'd0; iac_out = 1'd0;
		
		case(ps)
			s0: begin  pc_mux_sel = 1'd0; pc_write =1'd1; mem_adr_mux_sel = 2'd0; mem_read = 1'd1; ir_write = 1'd1; alu_src_a = 1'd1; alu_src_b = 1'd1; alu_op = 1'd0;end 
			// s1 is empty
			s2: begin clc_out = clc; cmc_out = cmc; rar_out = rar;  ral_out = ral; rot_out = rot; cla_out = cla; cma_out = cma; iac_out = iac; end
			s3: begin pc_mux_sel = 1'd0; alu_src_a = 1'd1; alu_src_b = 1'd1; 
				if (sma == 1 && acc_neg == 1)
					pc_write = 1'd1;
				else if(sza == 1 || acc_zero == 1)
					pc_write = 1'd1;
				else if(snc == 1 || cy_zero == 1)
					pc_write = 1'd1;
				end
			s4: begin mem_adr_mux_sel = 2'd1; mem_read = 1'd1; mar_write = 1'd1; mdr_write = 1'd1; end
			s5: begin mem_adr_mux_sel = 2'd2; mem_read = 1'd1; mdr_write = 1'd1; end
			s6: begin alu_src_a = 1'd0; alu_src_b = 1'd0; alu_res_write = 1'd1;
				if(opcode == 3'b000)
					alu_op = 1'd0;
				else if(opcode == 3'b001)
					alu_op = 1'd1;	
				end
			s7: begin acc_write = 1'd1;
				if(opcode == 3'b000)
					cy_write = 1'b1;
				else 
					cy_write = 1'b0;
				end
			s8: begin alu_src_a = 1'd0; alu_src_b = 1'd1; alu_op = 1'd0; alu_res_write = 1'd1; mem_data_mux_sel = 2'd0; mem_write = 1'd1;
				if(dir == 1)
					mem_adr_mux_sel = 2'd1;
				else 
					mem_adr_mux_sel = 2'd2; end
			s9: begin alu_src_a = 1'd1; alu_src_b = 1'd1; alu_op = 1'd0; alu_res_write = 1'd1; pc_mux_sel = 1'd0; pc_write = 1'd1;
				end
			s10: begin pc_mux_sel = 1'd0; pc_write = 1'd1; end
			s11: begin mem_data_mux_sel = 2'd1; mem_write = 1'd1;
				if(dir == 1)
					mem_adr_mux_sel = 2'd1;
				else 
					mem_adr_mux_sel = 2'd2;
				end
			s12: begin cla_out = 1'd1; end
			s13: begin pc_mux_sel = 1'd1; pc_write = 1'd1; 
			  if(dir == 0)
			     jump_sel=1'd1;
			end
			s14: begin mem_data_mux_sel = 2'd2; mem_write = 1'd1;
				if(dir == 1)
					mem_adr_mux_sel = 2'd1;
				else 
					mem_adr_mux_sel = 2'd2;
				end
			s15: begin pc_mux_sel = 1'd1; pc_write = 1'd1;
			  if(dir == 0)
			     jump_sel=1'd1;
			 end
			s16: begin alu_src_a = 1'd1; alu_src_b = 1'd1; alu_op = 1'd0; pc_mux_sel = 1'd0; pc_write = 1'd1;
			end
		endcase
	end
	
	
	always @( ps , inst , alu_zero , acc_zero , acc_neg , cy_zero) begin
		ns = s0;
		case(ps)
			s0: begin ns = s1; end
			s1: begin 
				if(opcode == 3'b111 && inst[8] == 1'b0)
					ns = s2;
				else if(opcode == 3'b111 && inst[8] == 1'b1)
					ns = s3;
				else if(dir == 1'b1 && opcode == 3'b100)
					ns = s13;
				else if(opcode == 3'b101 && dir == 1'b1)
					ns = s14;
				else 
					ns = s4;
				end
			s2: begin ns = s0; end
			s3: begin ns = s0; end
			s4: begin
				if(dir == 1'b0 && opcode != 3'b100 && opcode != 3'b101)
					ns = s5;
				else if(opcode == 3'b100)
					ns = s13;
				else if(opcode == 3'b101)
					ns = s14;
				else if(opcode == 3'b000 || opcode == 3'b001)
					ns = s6;
				else if(opcode == 3'b010)
					ns = s8;
				else if(opcode == 3'b011)
					ns = s11;
				end
			s5: begin 
				if(opcode == 3'b000 || opcode == 3'b001)
					ns = s6;
				else if(opcode == 3'b010)
					ns = s8;
				else if(opcode == 3'b011)
					ns = s11;
				end
			s6: begin ns = s7; end
			s7: begin ns = s0; end
			s8: begin 
			 if(alu_zero == 1)
					ns = s9;
				else 
					ns = s0;
			end
			s9: begin ns = s0; end
			s10: begin ns = s0; end
			s11: begin ns = s12; end
			s12: begin ns = s0; end
			s13: begin ns = s0; end
			s14: begin ns = s15; end
			s15: begin ns = s16; end
			s16: begin ns = s0; end
		endcase	
	end
	
	always@(posedge clk, posedge rst) begin
		if(rst)
			ps <= s0;
		else 
			ps <= ns;
	end
	
	
endmodule
