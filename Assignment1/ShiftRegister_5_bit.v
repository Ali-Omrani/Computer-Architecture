module ShiftRegister_5_bit(input sin,ld, shift, cntup, clk, input[4:0] in, output reg [4:0]out);
	always@(posedge clk)begin:loop
		if(ld) out = in;
		if (cntup) out = out+1;  
		if (shift) out = (out << 1)+sin;
		
	end	 
endmodule