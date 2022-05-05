//-----------------------------------------------------
// File Name : prog.sv
// Function : Program memory Psize x Isize - reads from file prog.hex
// Author: tjk, 
// Last rev. 24 Oct 2012
//-----------------------------------------------------
module prog1 #(parameter Psize = 5, Isize = 15) // psize - address width, Isize - instruction width
(input logic [Psize-1:0] address,
output logic [Isize-1:0] I); // I - instruction code

// program memory declaration, note: 1<<n is same as 2^n
logic [Isize:0] progMem[ (1<<Psize)-1:0];
  


always_comb
	begin
		case(address) //still need to be modified
			0: I = 15'b011000000000000; //MULI %0,%0,0; %0 = %0 * 0// clear %0
			1: I = 15'b100000000000001; //HOLD 0 PC = 1
			2: I = 15'b000000000000000; //INPUT %0; Store x1 to %0 register 
			3: I = 15'b100000010000011; //HOLD 1 PC = 3
			4: I = 15'b100000000000100; //HOLD 0 PC = 4
			5: I = 15'b000010000000000; //INPUT %1; Store y1 to %1 register
			6: I = 15'b100000010000110; //HOLD 1 PC = 6
		  7: I = 15'b011100001100000; //MULI %2,%0,0.75; %2 = %0 * 0.75// 0.75x1
			8: I = 15'b011110101000000; //MULI %3,%1,0.5; %3 = %1 * 0.5// 0.5y1
			9: I = 15'b001101100000000; //ADD  %2,%3; %2 = %2 + %3// 0.75x1 +0.5y1
			10: I = 15'b010101000010100; //ADDI %2,%2,20; %2 = %2 + 20// 0.75x1 +0.5y1 + 20 = x2 display
			11: I = 15'b100000000001011; //HOLD 0 PC = 11
			12: I = 15'b011100011000000; //MULI %2,%0,-0.5; %2 = %0 * -0.5// -0.5x1
		  13: I = 15'b011110101100000; //MULI %3,%1,0.75; %3 = %1 * 0.75// 0.75y1
		  14: I = 15'b001101100000000; //ADD  %2,%3; %2 = %2 + %3// -0.5x1 +0.75y1
		  15: I = 15'b010101011101100; //ADDI %2,%2,-20; %2 = %2 - 20// -0.5x1 +0.75y1 - 20 = y2 display
		  16: I = 15'b100000010010000; //HOLD 1 PC = 16
		  17: I = 15'b100000000000000; //HOLD 0 PC = 0

		    default: I = 15'b100_00_00_00000000;//HOLD 0 PC = 0
		endcase
	end
endmodule // end of module prog
