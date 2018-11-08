`timescale 1ps/1ps
module Mux_32bit_1to2(input [31:0]a,b,input sel,output [31:0]w);
	assign w=(~sel)?a:b;
endmodule