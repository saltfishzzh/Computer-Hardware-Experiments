`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/05 14:10:01
// Design Name: 
// Module Name: ps2_keyboard
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


module ps2_keyboard(input clk,              //50MHz  
                    input clrn,
                    input ps2_clk,
                    input ps2_data,
                    input rdn,              //read, active low
                    output [7:0]data,       //8-bit code
                    output ready,
                    output reg overflow
    );
    reg [9:0] buffer;
    reg [7:0] fifo[7:0];
    reg [3:0] count;
    reg [2:0] w_ptr, r_ptr;
    reg [1:0] ps2_clk_sync;
    
    always @ (posedge clk)
        ps2_clk_sync<= {ps2_clk_sync[0], ps2_clk};
    wire sampling = ps2_clk_sync[1] & ~ps2_clk_sync[0];
   
    always @(posedge clk)begin
        if(!clrn)begin
            count <= 0;
            w_ptr <= 0;
            r_ptr <= 0;
            overflow <= 0;
        end else if(sampling) begin
            if(count == 4'd10) begin
                if((buffer[0] == 0) && (ps2_data) && (^buffer[9:1]))begin
                    if((w_ptr + 3'b1) != r_ptr) begin
                        fifo[w_ptr] <= buffer[8:1];
                        w_ptr <= w_ptr + 3'b1; //w_ptr++
                    end else begin
                        overflow <= 1;
                    end
                end
                count <= 0;                 //for next frame
            end else begin
                buffer[count] <= ps2_data;  //store ps2_data
                count <= count + 4'b1;      //count++
            end
            if(!rdn && ready)begin          //on cpu read
                r_ptr <= r_ptr + 3'b1;      //r_ptr++
                overflow <= 0;              //clear overflow
            end
       end
   end   
       assign ready = (w_ptr != r_ptr);     //fifo is not empty
       assign data = fifo[r_ptr];           //code type          
endmodule
