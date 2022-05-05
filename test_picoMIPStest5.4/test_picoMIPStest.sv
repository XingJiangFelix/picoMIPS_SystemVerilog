`include "picoMIPS4test.sv" 
module test_picoMIPStest;

logic fastclk;
logic [9:0] SW;
logic [7:0] LED;

picoMIPS4test picoMIPS4test1 (.fastclk(fastclk), .SW(SW), .LED(LED));

initial 
    begin
        fastclk = 0;
        forever 
            begin
                #1ns fastclk = ~fastclk;
            end
    end

initial 
    begin
        SW = 10'b0000000000;
        #10ns SW = 10'b0000000000;
        #10ns SW = 10'b1000000000;
        
    end

//X1=5 Y1 = -5, expect X2 = 20, Y2 = -27
initial 
    begin
        #10ns SW = 10'b1000101000;//SW8 = 0, X1 = 40
        #10ns SW = 10'b1100101000;//SW8 =1, X1=40
        #10ns SW = 10'b1000101000;//SW8 =0, Y1=40
        #10ns SW = 10'b1100101000;//SW8 =1, Y1=40
        #10ns SW = 10'b1000000000;//SW8 =0
        #10ns SW = 10'b1100000000;//SW8 =1
        #10ns SW = 10'b1000000000;//SW8 =0
        //second time
        #10ns SW = 10'b1000101000;//SW8 = 0, X1 = 40
        #10ns SW = 10'b1100101000;//SW8 =1, X1=40
        #10ns SW = 10'b1000101000;//SW8 =0, Y1=40
        #10ns SW = 10'b1100101000;//SW8 =1, Y1=40
        #10ns SW = 10'b1000000000;//SW8 = 0
        #10ns SW = 10'b1100000000;//SW8 = 1
        #10ns SW = 10'b1000000000;//SW8 = 0
    end
    
endmodule