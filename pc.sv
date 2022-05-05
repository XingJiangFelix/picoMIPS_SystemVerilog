// up to 32 instructions
module pc #(parameter Psize = 5) (input logic clk, reset, PCup,
											 input logic [Psize-1:0] BranchAddress,
											 output logic [Psize-1 : 0]PCout);

//------------- code starts here---------
	always_ff @ ( posedge clk or negedge reset) // async reset
		begin
			if (!reset) // sync reset
				PCout <= {Psize{1'b0}};

			else if (PCup) // increment
				PCout <= PCout + 1'b1; 
				
			else if (!PCup) // absolute branch
				PCout <= BranchAddress;
		end
		
endmodule // module pc