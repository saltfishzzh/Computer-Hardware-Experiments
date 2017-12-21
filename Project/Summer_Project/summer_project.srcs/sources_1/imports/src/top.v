`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:45:03 05/11/2017 
// Design Name: 
// Module Name:    top 
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
module top(clk200P,
		   clk200N,
           K_COL, 
           RSTN, 
           SW,
		   keyboard_dat,
		   keyboard_clk,
           AN, 
           Buzzer, 
           K_ROW, 
           LED, 
           LEDCLK, 
           LEDDT, 
           LEDEN,  
           SEGCLK, 
           SEGDT, 
           SEGEN,
		   Blue,
		   Green,
		   Red,
		   HSYNC,
		   VSYNC,
           SEGMENT
		   );
	
	input clk200P;
    input clk200N;
    input [3:0]K_COL; 
    input RSTN; 
    input [15:0]SW;
    input keyboard_dat;
    input keyboard_clk;
    output [3:0]AN; 
    output Buzzer; 
    output [4:0]K_ROW; 
    output [7:0]LED; 
    output LEDCLK; 
    output LEDDT; 
    output LEDEN;  
    output SEGCLK; 
    output SEGDT; 
    output SEGEN;
    output [3:0] Blue;
    output [3:0] Green;
    output [3:0] Red;
    output HSYNC;
    output VSYNC;
    output [7:0]SEGMENT;
		   
	wire [31:0] Addr_out, Ai, Bi, Counter_out, CPU2IO, GPU2IO, Data_in, Data_out, Disp_num, Div, inst, PC, dina, douta, vram_out, debug, cmd_data_in, cmd_data_out;
	wire [15:0] LED_out, SW_OK;
	wire [6:0] vram_data_in;
	wire [12:0] vram_write_addr, vram_read_addr, font_table_addr;
	wire [9:0] addra, cmd_addr;
	wire [7:0] blink, LE_out, point_out, key;
	wire [31:0] ascii;
	wire [5:0] font_addr;
	wire [4:0] State, Key_out;
	wire [3:0] BTN_OK, Pulse;
	wire [2:0] w_ptr, r_ptr;
	wire [1:0] counter_set;
	wire [11:0] vga_pixel;
	wire [10:0] num;
	wire CR, LEDCLR, RDY, mem_r, dot, readn, SEGCLR, clk_200mhz, clk_100mhz, Clk_CPU, GPIOF0, IO_clk, rst, counter0_OUT, wea, GPIOE0, mem_w, CPU_MIO, rdn, vram_write, ps2_ready, ps2_overflow, ps2_rdn, cmd_we;
	assign Buzzer = 1'b1;
	assign IO_clk = ~Clk_CPU;
	
	assign vga_pixel = dot? 12'hfff : 24'h000;
	
	clk_diff U0(.clk200P(clk200P), .clk200N(clk200N), .clk200MHz(clk_200mhz));
	
	MCPU U1(.clk(Clk_CPU), 
			.reset(rst), 
			.inst_out(inst[31:0]), 
	        .INT(counter0_OUT), 
	        .PC_out(PC[31:0]), 
	        .mem_w(mem_w), 
	        .mem_r(mem_r),
	        .Addr_out(Addr_out[31:0]), 
	        .Data_in(Data_in[31:0]), 
	        .Data_out(Data_out[31:0]), 
			.state(State[4:0]), 
			.CPU_MIO(CPU_MIO), 
			.MIO_ready(1'b1));
			 
	RAM_B U2(.addra(addra[9:0]), 
			 .wea(wea), 
			 .dina(dina[31:0]), 
			 .clka(clk_100mhz), 
			 .douta(douta[31:0]));
	
	char_ram U3 (.addra(vram_write_addr[12:0]), 
				 .wea(vram_write), 
				 .dina({25'h0,vram_data_in[6:0]}), 
				 .clka(clk_100mhz),
                 .addrb(vram_read_addr[12:0]), 
                 .clkb(clk_100mhz), 
                 .doutb(ascii[31:0]));
	
	MIO_BUS U4 (.clk(clk_100mhz), 
				.rst(rst), 
				.BTN(BTN_OK[3:0]), 
	            .SW(SW_OK[15:0]), 
	            .mem_w(mem_w), 
	            .mem_r(mem_r), 
	            .addr_bus(Addr_out[31:0]), 
			    .Cpu_data4bus(Data_in[31:0]), 
			    .Cpu_data2bus(Data_out[31:0]), 
			    .ram_data_in(dina[31:0]),
			    .data_ram_we(wea), 
			    .ram_addr(addra[9:0]), 
			    .ram_data_out(douta[31:0]),
			    .ps2_ready(ps2_ready), 
			    .key(key[7:0]), 
			    .ps2_rdn(ps2_rdn),
			    .Peripheral_in(GPU2IO[31:0]), 
			    .GPIOe0000000_we(GPIOE0), 
			    .GPIOf0000000_we(GPIOF0),
			    .led_out(LED_out[15:0]), 
			    .counter_out(Counter_out[31:0]), 
			    .counter2_out(counter2_out),
			    .counter1_out(counter1_out), 
			    .counter0_out(counter0_OUT), 
			    .counter_we(counter_we),
			    .vga_rdn(rdn), 
			    .vram_out(ascii[31:0]), 
			    .vram_data_in(vram_data_in[6:0]), 
			    .cpu_vram_addr(vram_write_addr[12:0]), 
			    .vram_write(vram_write), 
			    .debug(debug[31:0]),
			    .cmd_addr(cmd_addr), 
			    .cmd_we(cmd_we), 
			    .cmd_data_in(cmd_data_in), 
			    .cmd_data_out(cmd_data_out), 
			    .num(num));
			   
	Multi_8CH32 U5 (.clk(IO_clk), 
					.rst(rst), 
					.EN(GPIOE0),
	                .Test(SW_OK[7:5]), 
	                .point_in({Div[31:0],Div[31:13],State[4:0],8'b0}), 
	                .LES({64'b0}),
				    .Data0(GPU2IO[31:0]),
				    .data1(debug), 
				    .data2(CPU2IO[31:0]),
				    .data3({24'b0,key}), 
				    .data4(Addr_out[31:0]), 
				    .data5(douta[31:0]),
				    .data6(Data_in[31:0]), 
				    .data7(PC[31:0]), 
				    .Disp_num(Disp_num[31:0]),
				    .point_out(point_out[7:0]), 
				    .LE_out(LE_out[7:0]));
				   
	Display U6 (.clk(clk_100mhz), 
				.rst(rst), 
				.Start(Div[20]),
	            .Text(SW_OK[0]), 
	            .flash(Div[25]), 
	            .Hexs(Disp_num[31:0]),
			    .point(point_out[7:0]), 
			    .LES(LE_out[7:0]), 
			    .segclk(SEGCLK),
			    .segsout(SEGDT), 
			    .SEGEN(SEGEN), 
			    .segclrn(SEGCLR));
			   
	Seg7_Dev U61 (.Scan({SW_OK[1],Div[19:18]}), 
				  .SW0(SW_OK[0]), 
				  .flash(Div[25]),
	              .Hexs(Disp_num[31:0]), 
	              .point(point_out[7:0]), 
	              .LES(LE_out[7:0]),
				  .SEGMENT(SEGMENT[7:0]), 
				  .AN(AN[3:0]));
				 
	GPIO U7 (.clk(IO_clk), 
			 .rst(rst), 
			 .EN(GPIOF0),
	         .Start(Div[20]), 
	         .P_Data(GPU2IO[31:0]), 
	         .counter_set(counter_set[1:0]),
			 .LED_out(LED_out[15:0]), 
			 .GPIOf0(), 
			 .ledclk(LEDCLK),
			 .ledsout(LEDDT), 
			 .LEDEN(LEDEN), 
			 .ledclrn(LEDCLR));
			
	PIO U71(.clk(IO_clk), 
			.rst(rst), 
			.EN(GPIOF0),
	        .PData_in(CPU2IO[31:0]), 
	        .counter_set(), 
	        .LED_out(LED[7:0]), 
	        .GPIOf0());
			
	clk_div U8  (.clk(clk_200mhz), 
				 .rst(rst), 
				 .SW2(SW_OK[2]),
	             .clkdiv(Div[31:0]), 
	             .Clk_CPU(Clk_CPU), 
	             .clk_100mhz(clk_100mhz),
	             .num(num));
			   
	SAnti_jitter U9 (.RSTN(RSTN), 
					 .clk(clk_100mhz), 
					 .Key_y(K_COL[3:0]),
	                 .Key_x(K_ROW[4:0]), 
	                 .SW(SW[15:0]), 
	                 .readn(readn),
					 .CR(CR), 
					 .Key_out(Key_out[4:0]), 
					 .Key_ready(RDY),
					 .pulse_out(Pulse[3:0]), 
					 .BTN_OK(BTN_OK[3:0]), 
					 .SW_OK(SW_OK[15:0]), 
					 .rst(rst));
					
	Counter U10 (.clk(IO_clk), 
				 .rst(rst), 
				 .clk0(Div[8]),
	             .counter_we(counter_we), 
	             .counter_val(GPU2IO[31:0]), 
				 .counter0_OUT(counter0_OUT),
				 .counter_out(Counter_out[31:0]));
	
	vgac U11 (.clk(Div[1]), 
			  .rst(rst), 
			  .d_in(vga_pixel[11:0]), 
			  .rdn(rdn), 
			  .r(Red[3:0]), 
			  .g(Green[3:0]), 
			  .b(Blue[3:0]),
			  .hs(HSYNC), 
			  .vs(VSYNC), 
			  .addr(vram_read_addr[12:0]), 
			  .font_addr(font_addr[5:0]));
	
    PS2 U12 (.clk25(Div[1]), 
    		 .clr(rst), 
    		 .PS2C(keyboard_clk), 
    		 .PS2D(keyboard_dat),
		     .data(key), 
		     .ready(kb_ready));
            
	font_table U13 (.font_table_addr({ascii[6:0], font_addr[5:0]}), .dot(dot));
	 
	cmd_ram U14 (.addra(cmd_addr[9:0]), 
				 .wea(cmd_we), 
				 .dina(cmd_data_in[31:0]), 
				 .clka(clk_100mhz), 
				 .douta(cmd_data_out[31:0]));          
	   
	SEnter_2_32 M4(.BTN(BTN_OK[2:0]), 
				   .clk(clk_100mhz), 
				   .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
                   .Din(Key_out[4:0]), 
                   .D_ready(RDY), 
                   .Ai(Ai[31:0]), 
                   .Bi(Bi[31:0]), 
                   .blink(blink[7:0]), 
                   .readn(readn));
         
endmodule
