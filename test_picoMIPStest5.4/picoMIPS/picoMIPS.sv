module picoMIPS (input logic clk,  // 10Hz clock 
				//input logic reset, // master reset (active low push button)
				input logic[9:0] SW, // connected to switches
				//input logic Switch,
				output logic[7:0] LED);// this will be the ALU output    

	parameter Psize = 5; // 5-bit program counter - up to 32 instructions
	parameter Isize = 15; 

	logic PCup;
	logic [Psize-1:0] BranchAddress;
	logic [Psize-1 : 0] PCout;
	logic [Isize-1:0] I;
	logic func;
	logic writeSelect;
	logic imm;
	logic [7:0]Wdata;
	logic w;
	logic [7:0] result;
	//logic [7:0] alua; // multiplexer output - alu port A
	logic [7:0] alub; // multiplexer output - alu port B
	logic [7:0] Rd;
	logic [7:0] Rs;

	pc #(.Psize(Psize)) pc (.clk(clk), 
									.reset(SW[9]), 
									.PCup(PCup), 	
									.BranchAddress(BranchAddress),
									.PCout(PCout));  // create pc 

	prog1 #(.Psize(Psize),.Isize(Isize)) progMemory (.address(PCout),.I(I));
	//prog1 #(.Psize(Psize),.Isize(Isize)) progMemory (.address(PCout),.I(I));
	//rom rom (.address(PCout),.clock(clk),.q(I));

	decoder dec (.opcode(I[Isize-1:Isize-3]), // Instruction opcode
					 .PCup(PCup),
					 //.PCabsbranch(PCabsbranch), // PC control
					 .Switch8(SW[8]),//Switch signal
					 .HOLDen(I[7]),// proset swtich singal
					 .func(func), // ALU function
					 .writeSelect(writeSelect), // Regmux switch value
					 .imm(imm), // immediate operand select
					 .w(w)); // Write to registers

	regs #(.n(8)) gpr (.clk(clk),.w(w),
							 //.reset(SW[9]),
							 .Wdata(Wdata), // write Regmux selection to Rd
							 .Rdno(I[Isize-4:Isize-5]),  // reg %d address
							 .Rsno(I[Isize-6:Isize-7]), // reg %s address
							 .Rd(Rd),.Rs(Rs)); // selected register data
			
	alu #(.n(8)) al (.a(Rs),.b(alub), // ALU input operands
						  .func(func), // ALU function
						  .result(result)); // ALU result		
	   
	always_comb
		begin
			Wdata = (writeSelect ? SW[7:0] : result); // Regmux: select input SW[7:0] or ALU
			alub = (imm ? I[7:0] : Rd); // select input from instruction(Coefficient) or ALU
			
			BranchAddress = I[Psize-1:0];// the address should stay when the state is HOLD
			
			if (I[Isize-1:Isize-3] == 3'b010 )//ADDI display
				LED [7:0] = result;//display the result
		end 

endmodule //end of pstest
