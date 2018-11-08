module Memory(input clk,input [11:0]Address,input [11:0] WriteData,input MemWrite,MemRead,output reg[11:0] ReadData);
  reg [11:0] mem[4095:0];
  initial begin
    mem[100] = 12'd99;
    mem[110] = 12'd109;
    mem[109] = 12'd8;
    mem[99] = 12'd70;
    mem[70] = 12'd17;
    mem[65] = 12'b111010000000; //CLA
    mem[66] = 12'b000101101110; // ACC <-ACC + ((110))
    mem[67] = 12'b111000000001; // increment ACC
    mem[68] = 12'b100111000000; // jump (64)

    mem[119]= 12'b111000000100; // Rot left
    mem[120]= 12'b100000000101; // jump 5
    mem[121]= 12'b100000010010; // jump 18

    mem[0] = 12'b000111100100 ;//{CY, Acc} <- Acc + (100)
    mem[1] = 12'b000011100100 ;//Acc  <- Acc + (100)
    mem[2] = 12'b010101100011 ;// ((99)) <- ((99)) + 1  != zero
    mem[3] = 12'b010001000110 ;// (70) <- (70) +1 == zero
    //mem[3] = 12'b011111100011 ;// ((99)) <- Acc, Acc <- 0
    mem[4] = 12'b100001110111 ;// Jump to 120th word of page 0 (which is jmp to 5)
    mem[5] = 12'b111010000000 ;// clear Acc
    mem[6] = 12'b111001000000 ;// clear CY
    mem[7] = 12'b111000100000 ;//Complement Acc
    mem[8] = 12'b111000001000 ;// Rotate Acc and CY right
    mem[9] = 12'b111000010000 ;// Complement CY
    mem[10]= 12'b111000000100 ;// Rotate left
    mem[11]= 12'b111000000001 ;// Increment Acc
    mem[12]= 12'b111110000000 ;// Skip on minus Acc (will be taken)
    mem[13]= 12'b111010000000 ;// clear Acc
    mem[14]= 12'b111101000000 ;// Skip on zero Acc (won't be taken)
    mem[15]= 12'b111100100000 ;// Skip on nonzero CY (won't be taken)
    mem[16]= 12'b111000100000 ;// Complement ACC
    mem[17]= 12'b101001111000 ;//jms to 120
    mem[18]= 12'b111000000100 ;//rotate left
    mem[19]= 12'b011001100100 ;// (100) <- ACC  Acc <- 0
    mem[20]= 12'b101001000000 ;//jms 64
    mem[21]= 12'b111101000000 ;//skip on zero Acc (not taken)
    mem[22]= 12'b111010000000 ;//CLA
    mem[23]= 12'b111101000000 ;// skip on zero ACC
    mem[24]= 12'b111000100000 ;// CMA
    mem[25]= 12'b111000100000 ;// CMA
    mem[26]= 12'b111110000000 ;// skip on minus
    mem[27]= 12'b100001111111 ;// fake jump
    mem[28]= 12'b111010000000 ;// CLA*/


  end
  always@(*)
      ReadData=(MemRead)? mem[Address]:'x;
  always@(posedge clk)
  if(MemWrite)
    mem[Address]<=WriteData;
endmodule
