/*
	蓝色Sword_Basic_io显示板驱动模块，其中
	文本模式下的显示与扩展显示
	extend = 0			extend = 1
	0					G
	1					h
	2					H
	3					L
	4					n
	5					o
	6					P
	7					q
	8					r
	9					t
	A					U
	b					y
	C					-
	d					=
	E					S
	F					J
*/
module basic_io(
	input wire clk,	//时钟
	input wire [15:0] digit_text,	//文本显示输入数据
	input wire [31:0] digit_graph,	//图形显示输入数据
	input wire [3:0] dot,	//小数点
	input wire mode,	//显示模式，0为文本模式，1为图形模式
	input wire extend,	//扩展位显示
	input wire [7:0] a_led_in,	//8个LED灯显示输入数据
	output reg [7:0] a_led,	//LED灯输出
	input wire buzzer_in,	//蜂鸣器输入数据
	output reg buzzer,	//蜂鸣器输出
	output reg [3:0] an, //4个数码管的位选输出
	output reg [7:0] segment	//单个数码管显示控制
);

endmodule

