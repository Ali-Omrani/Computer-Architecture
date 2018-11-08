`timescale 1ps/1ps
module Mux_5bit_2to4(input [4:0]a,b,c,input [1:0]sel,output [4:0]w);
	assign w=(sel==2'b00)? a :(sel==2'b01) ? b:(sel==2'b10)? c: 5'b0;
endmodule