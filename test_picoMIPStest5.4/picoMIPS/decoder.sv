
//Decoder

`include "alucodes.sv"
`include "opcodes.sv"
//---------------------------------------------------------
module decoder (input logic [2:0] opcode, // top 2 bits of instruction
				input logic Switch8, HOLDen,
				//output signals
				//PC control
				output logic PCup,
				//ALU control
				output logic func, // ALU function code 
				//input port mux control
				output logic writeSelect,
				// immediate operand mux control
				output logic imm,
				//   register file control
				output logic w);
   
//------------- code starts here ---------
// instruction decoder
always_comb 
	begin
	   // set default output signal values for NOP instruction
		PCup = 1'b1; // PC increments by default
		func = `RADD; // alu programmed for addition
		writeSelect = 1'b0; //Regmux defult 0
		imm = 1'b0; // alub mux defult 0
		w=1'b0; // 
		case(opcode)
		    `INPUT://input the SW[7:0] to register
				   begin
                       w = 1'b1;
					   writeSelect= 1'b1;// set Regmux from SW[7:0]
				   end
			`ADD: // register-register add
				begin
					w    = 1'b1; // write result to dest register
					func = `RADD;
				end
			
			`ADDI: // register-immediate add
				begin
					w    = 1'b1; // write result to dest register 
					imm  = 1'b1; // select immediate operand
					func = `RADD;
				end	  	

			`MULI:
				begin
					w    = 1'b1; // write result to dest register
					imm  = 1'b1; 
					func = `RMUL;
				end

			`HOLD:
				begin
					if(HOLDen == Switch8) 
						PCup = 1'b0;
				end

			default: ;
			 //  $error("unimplemented opcode");
		endcase // opcode
	end // always_comb

endmodule //module decoder --------------------------------