/*
	VGA同步信号产生器
*/
module vga_core_sword (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	input wire clk_base,  // VGA时钟信号，根据分辨率确定频率，默认25Mhz
	output wire vga_clk,  // VGA时钟信号，与clk_base相同
	output reg vga_valid,  // 同步信号有效标志
	output reg [10:0] h_count,  // 水平同步计数器
	output reg [10:0] v_count,  // 垂直同步计数器
	output reg [20:0] p_count,  // 像素计数器
	output reg [10:0] h_disp_max,  // 显示水平最大值
	output reg [10:0] v_disp_max,  // 显示垂直最大值
	output reg [20:0] p_disp_max,  // 显示像素最大值
	output reg h_sync,  // 水平同步信号
	output reg v_sync,  // 垂直同步信号
	output reg h_en,  // 水平同步信号范围内
	output reg v_en  // 垂直同步信号范围内
);

endmodule
