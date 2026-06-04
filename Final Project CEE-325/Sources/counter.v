`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: counter
// Target Devices: Basys 3 
// Description: 
//      This module counts to a constant value,
//      and then resets. This constant value is 
//      the value to have the PWM
//      signal refresh for every 20ms. 
//////////////////////////////////////////////////////////////////////////////////

module counter (
    input             clr,
    input             clk,
    output reg [19:0] count
);
    always @ (posedge clk)
    begin
        if (clr == 1'b1 || count == 20'd2000000)
            count <= 20'b0;
        else
            count <= count + 1'b1;
    end
endmodule