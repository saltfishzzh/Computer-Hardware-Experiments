`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:28 02/28/2017 
// Design Name: 
// Module Name:    MUX4T1_5 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUX4T1_5(input [4:0] I0,
					 input[4:0] I1, 
					 input[4:0] I2,
					 input[4:0] I3,
					 input[1:0] s, 
					 output reg[4:0] o
);
	always@* begin
		case(s)
			2'b00:o=I0;
			2'b01:o=I1;
			2'b10:o=I2;
			2'b11:o=I3;
		endcase
	end
endmodule
   