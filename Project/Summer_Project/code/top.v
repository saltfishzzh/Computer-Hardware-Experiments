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
module top(input clk200P,
		   input clk200N,
           input [3:0]K_COL, 
           input RSTN, 
           input [15:0]SW, 
           input PS2A_CLK_OUT,
           input PS2A_DATA_OUT,
           output [3:0]AN, 
           output Buzzer, 
           //output CR, 
           output [4:0]K_ROW, 
           output [7:0]LED, 
           output LEDCLK, 
           //output LEDCLR, 
           output LEDDT, 
           output LEDEN, 
           //output RDY, 
           //output readn, 
           output SEGCLK, 
           //output SEGCLR, 
           output SEGDT, 
           output SEGEN, 
           output [7:0]SEGMENT,
           output vga_h_sync,
           output vga_v_sync,
           output [3:0]vga_blue,
           output [3:0]vga_green,
           output [3:0]vga_red);
		   
	wire [31:0] Addr_out,Ai,Bi,Counter_out,CPU2IO,Data_in,Data_out,Disp_num,Div,inst,PC,dina,douta;
	wire [15:0] LED_out,SW_OK;
	wire [9:0] addra;
	wire [7:0] blink,LE_out,point_out;
	wire [4:0] State,Key_out;
	wire [3:0] BTN_OK,Pulse;
	wire [1:0] counter_set;
	wire Clk_CPU,GPIOF0,IO_clk,rst,counter0_OUT,wea,GPIOE0,mem_w,CPU_MIO;
	wire clk_200mhz, clk_100mhz;
	wire [7:0]ps2_key;
	wire [23:0]vga_data;
	wire [6:0]vram_data_in;
	wire [6:0]vram_data_out;
	wire [12:0]vram_addr;
	wire [11:0]font_pixel;
	wire [8:0]vga_row_addr;
	wire [9:0]vga_col_addr;
	wire ps2_rdn, ps2_ready,vram_w, font_dot, vga_rdn;
	assign Buzzer = 1'b1;
	assign IO_clk = ~Clk_CPU;
	MCPU U1(.clk(Clk_CPU), .reset(rst), .inst_out(inst[31:0]), 
	        .INT(counter0_OUT), .PC_out(PC[31:0]), .mem_w(mem_w),
	        .Addr_out(Addr_out[31:0]), .Data_in(Data_in[31:0]), .Data_out(Data_out[31:0]), 
			.state(State[4:0]), .CPU_MIO(CPU_MIO), .MIO_ready(1'b1));
			
	clk_diff U2(.clk200P(clk200P),.clk200N(clk200N),.clk200MHz(clk_200mhz));
			
			
			
	RAM U3(.addra(addra[9:0]), .wea(wea), .dina(dina[31:0]), .clka(clk_100mhz), .douta(douta[31:0]));
	
	MIO_BUS U4(.clk(clk_100mhz), .rst(rst), .BTN(BTN_OK[3:0]), 
	           .SW(SW_OK[15:0]), .mem_w(mem_w), .addr_bus(Addr_out[31:0]), 
			   .Cpu_data4bus(Data_in[31:0]), .Cpu_data2bus(Data_out[31:0]), .ram_data_in(dina[31:0]),
			   .data_ram_we(wea), .ram_addr(addra[9:0]), .ram_data_out(douta[31:0]),
			   .Peripheral_in(CPU2IO[31:0]), .GPIOe0000000_we(GPIOE0), .GPIOf0000000_we(GPIOF0),
			   .led_out(LED_out[15:0]), .counter_out(Counter_out[31:0]), .counter2_out(counter2_out),
			   .counter1_out(counter1_out), .counter0_out(counter0_OUT), .counter_we(counter_we),
			   .vram_out(vram_data_out[6:0]),.vga_rdn(vga_rdn),.vram_data_in(vram_data_in[6:0]),.cpu_vram_addr(vram_addr),.vram_write(vram_w),.ps2_rd(ps2_rdn),
			   .ps2_ready(ps2_ready),.key(ps2_key));
			   
	/*Multi_8CH32 U5(.clk(IO_clk), .rst(rst), .EN(GPIOE0),
	               .Test(SW_OK[7:5]), .point_in({Div[31:0],Div[31:0]}), .LES({64'b0}),
				   .Data0(CPU2IO[31:0]), .data1({{2'b00},PC[31:2]}), .data2(inst[31:0]),
				   .data3(Counter_out[31:0]), .data4(Addr_out[31:0]), .data5(Data_out[31:0]),
				   .data6(Data_in[31:0]), .data7(PC[31:0]), .Disp_num(Disp_num[31:0]),
				   .point_out(point_out[7:0]), .LE_out(LE_out[7:0]));*/
	Multi_8CH32 U5(.clk(IO_clk), .rst(rst), .EN(GPIOE0),
                   .Test(SW_OK[7:5]), .point_in({Div[31:0],Div[31:0]}), .LES({64'b0}),
                   .Data0(inst[31:0]), .data1({24'h000000,1'b0,vram_data_out[6:0]}), .data2(vram_w),
                   .data3({25'h0,vram_data_in[6:0]}), .data4(Addr_out[31:0]), .data5(Data_out[31:0]),
                   .data6(Data_in[31:0]), .data7(PC[31:0]), .Disp_num(Disp_num[31:0]),
                    .point_out(point_out[7:0]), .LE_out(LE_out[7:0]));			   
				   
	Display U6(.clk(clk_100mhz), .rst(rst), .Start(Div[20]),
	           .Text(SW_OK[0]), .flash(Div[25]), .Hexs(Disp_num[31:0]),
			   .point(point_out[7:0]), .LES(LE_out[7:0]), .segclk(SEGCLK),
			   .segsout(SEGDT), .SEGEN(SEGEN), .segclrn(SEGCLR));
			   
	Seg7_Dev U61(.Scan({SW_OK[1],Div[19:18]}), .SW0(SW_OK[0]), .flash(Div[25]),
	             .Hexs(Disp_num[31:0]), .point(point_out[7:0]), .LES(LE_out[7:0]),
				 .SEGMENT(SEGMENT[7:0]), .AN(AN[3:0]));
				 
	GPIO U7(.clk(IO_clk), .rst(rst), .EN(GPIOF0),
	        .Start(Div[20]), .P_Data(CPU2IO[31:0]), .counter_set(counter_set[1:0]),
			.LED_out(LED_out[15:0]), .GPIOf0(), .ledclk(LEDCLK),
			.ledsout(LEDDT), .LEDEN(LEDEN), .ledclrn(LEDCLR));
			
	PIO U71(.clk(IO_clk), .rst(rst), .EN(GPIOF0),
	        .PData_in(CPU2IO[31:0]), .counter_set(), .LED_out(LED[7:0]), .GPIOf0());
			
	clk_div U8(.clk(clk_200mhz), .rst(rst), .SW2(SW_OK[2]),
	           .clkdiv(Div[31:0]), .Clk_CPU(Clk_CPU),.clk_100mhz(clk_100mhz));
			   
	SAnti_jitter U9(.RSTN(RSTN), .clk(clk_100mhz), .Key_y(K_COL[3:0]),
	                .Key_x(K_ROW[4:0]), .SW(SW[15:0]), .readn(readn),
					.CR(CR), .Key_out(Key_out[4:0]), .Key_ready(RDY),
					.pulse_out(Pulse[3:0]), .BTN_OK(BTN_OK[3:0]), .SW_OK(SW_OK[15:0]), .rst(rst));
					
	Counter U10(.clk(IO_clk), .rst(rst), .clk0(Div[6]),
	            .clk1(Div[9]), .clk2(Div[11]), .counter_we(counter_we),
				.counter_val(CPU2IO[31:0]), .counter_ch(counter_set[1:0]), .counter0_OUT(counter0_OUT),
				.counter1_OUT(counter1_out), .counter2_OUT(counter2_out), .counter_out(Counter_out[31:0]));
				
	SEnter_2_32 M4(.BTN(BTN_OK[2:0]), .clk(clk_100mhz), .Ctrl({SW_OK[7:5], SW_OK[15], SW_OK[0]}), 
                   .Din(Key_out[4:0]), .D_ready(RDY), .Ai(Ai[31:0]), 
                   .Bi(Bi[31:0]), .blink(blink[7:0]), .readn(readn));
	
	
	ps2_keyboard U11(.clk(Div[1]),.clrn(rst),.ps2_clk(PS2A_CLK_OUT),.ps2_data(PS2A_DATA_OUT),.rdn(ps2_rdn),.data(ps2_key),.ready(ps2_ready),.overflow());
   
   
    vgac U12(.d_in(font_pixel[11:0]),.clk(Div[1]),.rst(rst),.row_addr(vga_row_addr[8:0]),
             .col_addr(vga_col_addr[9:0]),.r(vga_red[3:0]),.g(vga_green[3:0]),.b(vga_blue[3:0]),
             .rdn(vga_rdn),.hs(vga_h_sync),.vs(vga_v_sync));
   wire [12:0]vram_addr_read;
   assign vram_addr_read = vga_row_addr[8:3]*(7'd80) + vga_col_addr[9:3]; 
    vram U13(.clka(clk_100mhz),.wea(vram_w),.addra(vram_addr[12:0]),.dina(vram_data_in[6:0]),
             .clkb(clk_100mhz),.doutb(vram_data_out[6:0]),.addrb(vram_addr_read[12:0]));
   wire [12:0]font_table_addr;
    assign font_table_addr = {vram_data_out[6:0], vga_row_addr[2:0], vga_col_addr[2:0]};
    font_table U14(.a(font_table_addr[12:0]),.d(font_dot));
    dot2pixel U15(.dot(font_dot),.pixel(font_pixel[11:0]));
endmodule
