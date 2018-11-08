module Devider(input clk,start,reset,input [9:0]Dividend,input [4:0]Divisor,output [4:0]Quotient);
	wire [2:0]countresult;
	wire cnt_complete,ld_x,sel_x,shift_x,ld_q,shift_q,add_or_sub,count_up_x,count_up_q,ld_d,op_sel,sign,cntup,rstcnt;
	controller Controller(clk,start,cnt_complete,sign,ld_x,sel_x,shift_x,ld_q,shift_q,add_or_sub,count_up_x,count_up_q,ld_d,op_sel,cntup,rstcnt,ld_e);
	DataPath data(ld_e,ld_x,sel_x,shift_x,ld_q,shift_q,add_or_sub,count_up_x,count_up_q,ld_d,op_sel,clk,Dividend,Divisor,Quotient,sign);
	Counter cnt(clk,rstcnt,cntup,countresult,cnt_complete);
endmodule