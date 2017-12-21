`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/06 09:31:49
// Design Name: 
// Module Name: dot2pixel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dot2pixel(input dot,
                 output [11:0]pixel
    );
    
    assign pixel = (dot == 0)?12'hff0:12'h000;
endmodule
