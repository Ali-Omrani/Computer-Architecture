`timescale 1ps/1ps
module Controller(input[5:0] Opcode, input [5:0] Func, input Zero, output reg [1:0] Regdst, Regdatawrtsrc,  output reg [2:0] ALUOp,output reg Regwrt, ALUSrc, Memwrt, Memread, MemtoReg, output reg [1:0]PcSrc, output reg Branch, SelSh);
	always@(Opcode, Zero) begin
		 //Regdst = 1'b00; Regdatawrtsrc = 1'b00;  ALUOp=1'b10;Regwrt = 1'b0; ALUSrc =1'b0; Memwrt = 1'b0; Memread = 1'b0; MemtoReg =1'b0; PcSrc= 2'b00; Branch=1'b0; SelSh = 1'b0;
		PcSrc =1'b00;
		case(Opcode)
		6'b000000: begin:R_type 
			Regdst = 2'b01; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b0; Memwrt = 1'b0; PcSrc=2'b00; Memread = 1'b0; MemtoReg = 1'b0; ALUOp = 3'b010; Branch = 1'b0;
			if(Func == 6'b001000) begin:JR
				Regwrt = 1'b0; Memwrt = 1'b0; Memread = 1'b0; PcSrc = 1'b11; Branch = 1'b1;
			end
			if(Func == 6'b010000) begin:MFHI
				Regwrt = 1'b1; Memwrt = 1'b0; Memread = 1'b0; ALUOp=3'b010; PcSrc = 1'b00; Branch = 1'b0;Regdst = 2'b01; Regdatawrtsrc = 2'b00;
			end
			if(Func == 6'b010000) begin:MFLO
				Regwrt = 1'b1; Memwrt = 1'b0; Memread = 1'b0; ALUOp=3'b010; PcSrc = 1'b00; Branch = 1'b0;Regdst = 2'b01; Regdatawrtsrc = 2'b00;
			end
		end 
		6'b001000: begin:R_type_immidiate_add
			Regdst = 2'b00; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b1;  PcSrc=2'b00; Memwrt = 1'b0; Memread = 1'b0; MemtoReg = 1'b0; ALUOp = 3'b000; Branch = 1'b0;
		end
		6'b001100: begin:R_type_immidiate_and
			Regdst = 2'b00; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b1;  PcSrc=2'b00; Memwrt = 1'b0; Memread = 1'b0; MemtoReg = 1'b0; ALUOp = 3'b100; Branch = 1'b0;
		end
		6'b001101: begin:R_type_immidiate_or
			Regdst = 2'b00; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b1;  PcSrc=2'b00; Memwrt = 1'b0; Memread = 1'b0; MemtoReg = 1'b0; ALUOp = 3'b110; Branch = 1'b0;
		end
		6'b001110: begin:R_type_immidiate_xor
			Regdst = 2'b00; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b1;  PcSrc=2'b00; Memwrt = 1'b0; Memread = 1'b0; MemtoReg = 1'b0; ALUOp = 3'b111; Branch = 1'b0;
		end
		6'b100011: begin:LW
			Regdst = 2'b00; Regdatawrtsrc = 2'b00; Regwrt = 1'b1; ALUSrc = 1'b1; Memwrt = 1'b0; Memread = 1'b1; MemtoReg = 1'b1; ALUOp = 3'b000; Branch = 1'b0; PcSrc=2'b00; 
		end
		6'b101011: begin:SW
			 Regwrt = 1'b0; ALUSrc = 1'b1; Memwrt = 1'b1; Memread = 1'b0; MemtoReg = 1'b1; ALUOp = 3'b000; Branch = 1'b0; PcSrc=2'b00; 
		end
		6'b001111: begin: LUI
			Regdst = 2'b00; Regdatawrtsrc = 2'b10; Regwrt = 1'b1; Memwrt = 1'b0; Memread = 1'b0; Branch = 1'b0; PcSrc=2'b00; 
		end
		6'b000010: begin: J
			Regwrt = 1'b0; Memwrt = 1'b0; Memread = 1'b0; PcSrc = 2'b10;  Branch = 1'b1; SelSh = 1;
		end
		6'b000100: begin: BEQ
			Regwrt = 1'b0; ALUSrc = 1'b0; Memwrt = 1'b0; Memread = 1'b0; PcSrc = (Zero) ? 2'b01 : 2'b00; ALUOp = 3'b001; Branch = 1'b1; SelSh = 1'b0;
		end
		6'b000101: begin: BNQ
			Regwrt = 1'b0; ALUSrc = 1'b0; Memwrt = 1'b0; Memread = 1'b0; PcSrc = (~Zero) ? 2'b01 : 2'b00; ALUOp = 3'b001; Branch = 1'b1; SelSh = 1'b0;
		end
		
	endcase
  end
endmodule
