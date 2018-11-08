module Counter(input clk,reset,cntup,output reg[2:0]w,output countcomplete);

always @(posedge clk,posedge reset)begin:alw
	
if(reset) w=3'b000;
	
else if(cntup) w <=w+1;
	end

assign countcomplete=(w==3'b100)?1:0;

endmodule
