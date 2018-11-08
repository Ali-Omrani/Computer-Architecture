module Mux_12bit_2to1(input [11:0]a,b,input sel,output [11:0]w);
	assign w=(sel)?b:a;
endmodule