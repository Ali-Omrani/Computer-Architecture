module DataPath(input ld_e,ld_x,sel_x,shift_x,ld_q,shift_q,add_or_sub,count_up_x,count_up_q,ld_d,op_sel,clk,input [9:0]Dividend,input [4:0]Divisor,output [4:0]Quotient,output sign);
 wire[4:0]D;
 wire[4:0]X;
 wire[4:0]W;
 wire[4:0]M;
 wire e_out;
 assign sign = X[4];
 Register_5_bit d(ld_d,clk,Divisor,D);
 Ereg e(X[4],ld_e,clk,e_out);
 ShiftRegister_5_bit x(Quotient[4],ld_x,shift_x,count_up_x,clk,M,X);
 ShiftRegister_5_bit q(0,ld_q,shift_q,count_up_q,clk,Dividend,Quotient);
 Add_Sub Adder_sub(X,D,op_sel,W);
 Mux m(Dividend[9:5],W,sel_x,M);
endmodule
