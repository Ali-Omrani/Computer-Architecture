`timescale 1ps/1ps
module Mux_32bit_2to4(input [31:0]a,b,c,d,input [1:0]sel,output [31:0]w);
	assign w=(sel==2'b00)? a :(sel==2'b01) ? b:(sel==2'b10)? c: d;
endmodule