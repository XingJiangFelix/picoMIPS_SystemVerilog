// n - data bus width
module regs #(parameter n = 8) (input logic clk, w, //reset,// clk and write control
										  input logic [n-1:0] Wdata,
										  input logic [1:0] Rdno, Rsno, // 2-bit register number
										  output logic [n-1:0] Rd, Rs);
// Declare 4 n-bit registers 
logic [n-1:0] gpr [3:0];

	// write to dest reg Rd, if w==1
always_ff @ (posedge clk)//or negedge reset)
	begin
		if (w)
			gpr[Rdno] <= Wdata;
	end
	
always_comb
	begin
		// dual output bus: Rd and Rs
		Rd = gpr[Rdno];
		Rs = gpr[Rsno];
	end
	
endmodule // module regs