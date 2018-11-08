module Add_Sub(input [4:0]a,b,input op_sel,output [4:0]w);
	assign w = (op_sel) ? a+b : a-b;
endmodule
