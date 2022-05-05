//alu
`include "alucodes.sv"  
module alu #(parameter n =8) (input logic signed [n-1:0] a, b, // ALU operands
							  input logic func, // ALU function code
							  output logic signed [n-1:0] result);// ALU result

//------------- code starts here ---------
logic signed [n-1:0] addResult; // add result
logic signed [15:0] mulResult; //mul result

always_comb
	begin
		if(func == `RMUL)
			mulResult = a * b;
		else
			mulResult = 0;
		
		if(func == `RADD)
			addResult = a+b;
		else
			addResult = 0;// n-bit adder
	end // always_comb

// create the ALU 
always_comb
	begin
		result = a; // default
		case(func)
			`RADD: 
				begin
					result = addResult;
				end
				
			`RMUL: 
				begin
					result = mulResult[14:7];
				end
		endcase
	end //always_comb
endmodule //end of module ALU
