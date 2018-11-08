module Mux_12bit_4to2(input [11:0]a,b,c,d,input [1:0]sel,output [11:0]w);
	assign w=(sel==2'b00)? a :(sel==2'b01) ? b:(sel==2'b10)? c: d;
endmodule