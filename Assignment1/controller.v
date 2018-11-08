module controller(input clk,start,cnt_complete,sign,output reg ld_x,sel_x,shift_x,ld_q,shift_q,add_or_sub,count_up_x,count_up_q,ld_d,op_sel,cntup,rstcnt,ld_e);
localparam[3:0]S0=4'b0000, S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001,S10=4'b1010,S11=4'b1011;
reg[3:0] p_state,n_state;

	always@(p_state,start)begin: transition     n_state=S0;

				case(p_state)
		S0:if(!start)n_state=S0;
			else n_state=S1;
		S1:if(start)n_state=S1;
			else n_state=S2;
		S2:n_state=S8;
		S8:n_state=S9;
		S9:n_state=S11;
		S11:n_state=S3;
		  /*if(sign)n_state=S5;
			else n_state=S4;*/
		S3:if(sign)n_state=S5;
			else n_state=S4;
		S4:n_state=S10;
		S5: n_state=S10;
		S6:n_state=S7;
		S7:n_state=S0;
		S10:if(!cnt_complete)n_state=S3;
		 else if(cnt_complete && sign) n_state=S6;
			 else n_state=S7;
		endcase
	end

	always@(p_state,start)begin:Outputing
		ld_x=0;sel_x=0;shift_x=0;ld_q=0;shift_q=0;count_up_x=0;count_up_q=0;ld_d=0;op_sel=0;cntup=0;rstcnt=0;
		case(p_state)
		S2:begin sel_x = 1; ld_x = 1; ld_q = 1; ld_d = 1;rstcnt = 1;end
		S3:begin  shift_x = 1; ld_e = 1 ;/*shift_q =(sign)?1:0*/ /*count_up_q=(!sign)?1:0;*/ shift_q=1;end
		S4:begin /*count_up_q = 1;*/ ld_x = 1;cntup=1;end
		S5:begin ld_x = 1;cntup=1;op_sel=1; end
		S6:begin ld_x = 1;op_sel =1;end
		S8:begin shift_x = 1; ld_e =1; shift_q = 1 ;op_sel= 0; end
		S9:begin ld_x=1;end
		S10:begin  count_up_q =(!sign)?1:0;op_sel =1; end
		S11:begin count_up_q =(!sign)?1:0; end
		endcase
	end

	always@(posedge clk)begin:sequential
		p_state <= n_state;
	end		
endmodule
