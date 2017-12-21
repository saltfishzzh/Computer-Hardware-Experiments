`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:22:22 05/23/2017 
// Design Name: 
// Module Name:    MIO_BUS 
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
module MIO_BUS( input clk,
			    input rst,
			    input[3:0]BTN,
			    input[15:0]SW,
			    input mem_w,
				input mem_r,
			    input[31:0]Cpu_data2bus,				//data from CPU
			    input[31:0]addr_bus,
			    input[31:0]ram_data_out,
			    input[31:0]vram_out,
			    input[15:0]led_out,
			    input[31:0]counter_out,
			    input counter0_out,
			    input counter1_out,
			    input counter2_out,
			    input vga_rdn,
				input ps2_ready,
				input [7:0]key,
				input [10:0]num,
			    output reg ps2_rdn,
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
			    output reg[31:0]Peripheral_in,
			    
			    output reg[31:0] debug,
			    
			    input[31:0]cmd_data_out,
			    output reg[31:0]cmd_data_in,
			    output reg[9:0]cmd_addr,
			    output reg cmd_we
			    
			    );

	wire counter_over;
	reg [10:0]rand;

	//RAM & IO decode signals:	
	always @* begin
		data_ram_we = 0;
		counter_we = 0;
		GPIOf0000000_we = 0;
		GPIOe0000000_we = 0;
		ram_addr = 10'h0;
		ram_data_in = 32'h0;
		Peripheral_in=32'h0;
		Cpu_data4bus = 32'h0;
		ps2_rdn = 1;
		vram_write = 0;
		cmd_we = 0;
		
		casex(addr_bus[31:8])
			24'h0000xx: begin 				// data_ram (00000000 - 0000ffff(00000ffc), actually lower 4KB RAM)
				data_ram_we = mem_w;
				ram_addr=addr_bus[12:2];
				ram_data_in=Cpu_data2bus;
				Cpu_data4bus=ram_data_out;
				if (addr_bus >= 900) debug = Cpu_data2bus;			
			end
			24'h000cxx: begin 				// Vram (000c0000 - 000cffff, actually lower 4K?ив11bit VRAM)
				vram_write = mem_w ;
				cpu_vram_addr=addr_bus[12:0];
				vram_data_in=Cpu_data2bus[6:0];
				Cpu_data4bus=vga_rdn? {25'h0, vram_out[6:0]} :  32'hx ;			
			end		
			
			24'h000dxx: begin					//PS2 (ffffd000~ ffffdfff)
				ps2_rdn = ~mem_r;
				Peripheral_in = Cpu_data2bus;							//write NU 
				Cpu_data4bus = {24'h0, key};				//read from PS2;
			end
			
			24'h000exx: begin
			    cmd_we = mem_w;
			    cmd_addr = addr_bus[12:2];
			    cmd_data_in = Cpu_data2bus;
			    Cpu_data4bus = cmd_data_out;
			end
			
			24'h000fxx: begin
			    if (key == 8'h1c || key == 8'h23) rand = (num + 32) % 59;
                Cpu_data4bus = {22'h000000,rand};
            end

			24'hexxxxx: begin  					// 7 Segement LEDs (e0000000 - efffffff, 4 7-seg display)
				GPIOe0000000_we = mem_w;
				Peripheral_in = Cpu_data2bus;
				Cpu_data4bus =counter_out;					//read from Counter
			end
					
			24'hf00000: begin 				  // LED   (f0000000-f00000ff,8 LEDs & counter, ffffff04-fffffff4)
				if(addr_bus[2]) begin		  //f0000004  for addr of counter
					counter_we = mem_w;
					Peripheral_in = Cpu_data2bus;			//write Counter Value 
					Cpu_data4bus = counter_out;			//read from Counter;
				end 
				else begin							//f0000000
					GPIOf0000000_we = mem_w;
					Peripheral_in = Cpu_data2bus;	//write Counter set & Initialization and Button
					Cpu_data4bus = {counter0_out,counter1_out,counter2_out,17'b0,BTN[3:0],SW[7:0]};
					//Cpu_data4bus = {counter0_out,counter1_out,counter2_out,led_out[12:0], SW};
				end 
			end
		endcase
	end			// always end

endmodule
