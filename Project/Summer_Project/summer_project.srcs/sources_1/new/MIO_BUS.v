`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/04 19:29:12
// Design Name: 
// Module Name: MIO_BUS
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


module MIO_BUS(input clk,
				input rst,
				input[3:0]BTN,
				input[15:0]SW,
				input mem_w,
				input[31:0]Cpu_data2bus,				//data from CPU
				input[31:0]addr_bus,
				input[31:0]ram_data_out,
				input[6:0]vram_out,
				input[15:0]led_out,
				input[31:0]counter_out,
				input ps2_ready,
				input [7:0]key,
				input counter0_out,
				input counter1_out,
				input counter2_out,
				input vga_rdn,
				
				output reg ps2_rd,
				output reg[31:0]Cpu_data4bus,				//write to CPU
				output reg[31:0]ram_data_in,				//from CPU write to Memory
				output reg[6:0]vram_data_in,                                
				output reg[9:0]ram_addr,						//Memory Address signals
				output reg[12:0]cpu_vram_addr,
                output reg vram_write,
				output reg data_ram_we,
				output reg GPIOf0000000_we,
				output reg GPIOe0000000_we,
				output reg counter_we,
				output reg[31:0]Peripheral_in
		
				);
	always @ * begin
	   data_ram_we = 0;
	   counter_we = 0;
	   Cpu_data4bus = 32'b0;
	   GPIOf0000000_we = 0;
	   GPIOe0000000_we = 0;
	   Peripheral_in = 32'b0;
	   ram_data_in = 32'b0;
	   ram_addr = 10'b0;
	   ps2_rd = 1'b1;
	   
	   casex(addr_bus[31:0])
	       32'h0xxxxxxx:begin
	           data_ram_we = mem_w;
	           ram_addr = addr_bus[12:2];
	           ram_data_in = Cpu_data2bus;
	           Cpu_data4bus = ram_data_out;
	       end
	       32'hcxxxxxxx:begin
	           vram_write = mem_w;
	           cpu_vram_addr = addr_bus[12:0];
	           vram_data_in = Cpu_data2bus[6:0];
	           Cpu_data4bus = ~vga_rdn?{25'h0, vram_out[6:0]} : 32'hx;
	       end
	       32'haxxxxxxx:begin
	           ps2_rd = 1'b0;
	           Cpu_data4bus = {23'h0, ps2_ready, key};
	       end
	       32'hexxxxxxx:begin
	           GPIOe0000000_we = mem_w;
	           Peripheral_in = Cpu_data2bus;
	           Cpu_data4bus = counter_out;
	       end
	       32'hfxxxxxxx:begin                 // LED   (ffffff00-ffffffff0,8 LEDs & counter, ffffff04-fffffff4)
	           if(addr_bus[2]) begin		 
                    counter_we = mem_w;
                    Peripheral_in = Cpu_data2bus;            //write Counter Value 
                    Cpu_data4bus = counter_out;            //read from Counter;
               end 
               else begin                            //f0000000
                    GPIOf0000000_we = mem_w;
                    Peripheral_in = Cpu_data2bus;    //write Counter set & Initialization and Button
                     //Cpu_data4bus = {counter0_out,counter1_out,counter2_out,17'b0,BTN[3:0],SW[7:0]};
                    Cpu_data4bus = {counter0_out,counter1_out,counter2_out,led_out[12:0], SW};
                    //Cpu_data4bus = {counter0_out,counter1_out,counter2_out,11'h0,led_out[15:0], SW};
               end 
		   end
		endcase
    end
endmodule
