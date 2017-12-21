`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:00 05/23/2017 
// Design Name: 
// Module Name:    VGA 
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
module vgac (
	input clk, //25mhz
	input rst,
	input [11:0] d_in, // rrrr_gggg_bbbb,
	//output [9:0] row,// pixel ram row address, 480 (512) lines
	//output [9:0] col,// pixel ram col address, 640 (1024) pixels
	output reg rdn,
	output reg [3:0] r,
	output reg [3:0] g,
	output reg [3:0] b,
	output reg hs,
	output reg vs,
	output [12:0] addr, //”Îœ‘¥ÊΩªª•
	output [5:0] font_addr
	); // vgac
	wire [9:0] row, col;
	// h_count: VGA horizontal counter (0-799)
	reg [9:0] h_count; // VGA horizontal counter (0-799): pixels
	always @ (posedge clk) begin
		if (rst) begin
			h_count <= 10'h0;
		end else if (h_count == 10'd799) begin
			h_count <= 10'h0;
		end else begin 
			h_count <= h_count + 10'h1;
		end
	end
	// v_count: VGA vertical counter (0-524)
	reg [9:0] v_count; // VGA vertical   counter (0-524): lines
	always @ (posedge clk or posedge rst) begin
		if (rst) begin
			v_count <= 10'h0;
		end else if (h_count == 10'd799) begin
			if (v_count == 10'd524) begin
				v_count <= 10'h0;
			end else begin
				v_count <= v_count + 10'h1;
			end
		end
	end
    // signals, will be latched for outputs
    assign      row    =  v_count - 10'd35;     // pixel ram row addr 
    assign      col    =  h_count - 10'd143;    // pixel ram col addr 
    wire        h_sync = (h_count > 10'd95);    //  96 -> 799
    wire        v_sync = (v_count > 10'd1);     //   2 -> 524
    wire        read   = (h_count > 10'd142) && // 143 -> 782
                         (h_count < 10'd783) && //        640 pixels
                         (v_count > 10'd34)  && //  35 -> 514
                         (v_count < 10'd515);   //        480 lines
    // vga signals
    always @ (posedge clk) begin
        //row_addr <=  row[8:0]; // pixel ram row address
        //col_addr <=  col;      // pixel ram col address
        rdn      <= ~read;     // read pixel (active low)
        hs       <=  h_sync;   // horizontal synchronization
        vs       <=  v_sync;   // vertical   synchronization
        r        <=  rdn ? 4'h0 : d_in[11:8]; // 3-bit red
        g        <=  rdn ? 4'h0 : d_in[7:4]; // 3-bit green
        b        <=  rdn ? 4'h0 : d_in[3:0]; // 3-bit blue
    end
	assign addr = rdn ? 13'h0 : (/*13'd1024 + */{row[9:3], 6'h0} + {2'h0, row[9:3], 4'h0} + {6'h0, col[9:3]});
    assign font_addr = {row[2:0], col[2:0]};
endmodule
