// counter for slow clock
module counter #(parameter n = 24) //clock divides by 2^n, adjust n if necessary
  (input logic fastclk, output logic clk);
  
//logic [n-1:0] count;
logic count;

/*always_ff @(posedge fastclk)
    begin
      

    count <= count + 1'b1;

//assign clk = count[n-1]; // slow clock
       clk <= count;
    end*/
always_comb begin
  clk = fastclk;
end
endmodule