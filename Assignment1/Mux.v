module Mux(input [4:0]a,b,input sel,output [4:0]w);
	assign w=(sel)?a:b;
endmodule