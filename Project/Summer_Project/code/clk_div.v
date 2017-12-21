`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:24:38 02/28/2017 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(input clk,
					input rst,
					input SW2,
					output clk_100mhz,
					output reg [31:0] clkdiv,
					output Clk_CPU
    );
	reg [1:0]clk_change;
	always@(posedge clk)begin
		clk_change <= clk_change+1;
	end
	
	assign clk_100mhz = clk_change[0];
	always@(posedge clk_100mhz or posedge rst)begin
		if(rst)clkdiv<=32'h0;
		else clkdiv<=clkdiv+1;
	end
	assign Clk_CPU=(SW2)?clkdiv[23]:clkdiv[2];
endmodule
