/*
	VGA图形化与wishbone总线接口，内置buffer
*/
module wb_vga_graphic (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	input wire vga_clk,  // VGA时钟，由VGA核心模块产生
	input wire [10:0] h_count_core,  // 水平同步计数器，由VGA核心模块产生
	input wire [20:0] p_disp_max,  // 像素最大显示范围
	input wire h_sync_core,  // 水平同步信号，由VGA核心模块产生
	input wire v_sync_core,  // 垂直同步信号，由VGA核心模块产生
	input wire h_en_core,  // 水平同步信号范围内，由VGA核心模块产生
	input wire v_en_core,  // 垂直同步信号范围内，由VGA核心模块产生
	input wire [31:20] vram_base,  // VRAM基址
	// VGA接口
	output reg h_sync,	//VGA水平同步信号
	output reg v_sync,	//VGA垂直同步信号
	output reg [2:0] r,	//红色显示分量
	output reg [2:0] g,	//绿色显示分量
	output reg [1:0] b,	//蓝色显示分量
	// wishbone主设备总线接口
	input wire wbm_clk_i,	//wishbone主设备时钟线
	output reg wbm_cyc_o,	//wishbone主设备总线操作指示，置1表示发起总线操作
	output reg wbm_stb_o,	//wishbone主设备数据传输指示，置1表示发起数据传输请求
	output reg [31:2] wbm_addr_o,	//wishbone主设备输出地址线
	output reg [2:0] wbm_cti_o,	//wishbone主设备数据传输方式选择
	output reg [1:0] wbm_bte_o,	//wishbone主设备地址递增Burst下的地址递增方式选择
	output reg [3:0] wbm_sel_o,	//wishbone主设备字节选择
	output reg wbm_we_o,	//wishbone主设备写使能
	input wire [31:0] wbm_data_i,	//wishbone主设备输入数据
	output reg [31:0] wbm_data_o,	//wishbone主设备输出数据
	input wire wbm_ack_i	//wishbone数据确认信号
);

endmodule
