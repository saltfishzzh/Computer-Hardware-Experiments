/*
	VGA文本显示与wishbone总线接口，内置buffer
*/
module wb_vga_text (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	input wire vga_clk,  // VGA时钟，由VGA核心模块产生
	input wire [10:0] h_count_core,  // 水平同步计数器，由VGA核心模块产生
	input wire [10:0] h_disp_max,  // 水平最大显示范围
	input wire [10:0] v_count_core,  // 垂直同步计数器，由VGA核心模块产生
	input wire [10:0] v_disp_max,  // 垂直最大显示范围
	input wire h_sync_core,  // 水平同步信号，由VGA核心模块产生
	input wire v_sync_core,  // 垂直同步信号，由VGA核心模块产生
	input wire h_en_core,  // 水平同步信号范围内，由VGA核心模块产生
	input wire v_en_core,  // 垂直同步信号范围内，由VGA核心模块产生
	input wire [7:0] cursor_h_pos,  // 游标水平位置
	input wire [5:0] cursor_v_pos,  // 游标垂直位置
	input wire cursor_en,  // 游标显示使能
	input wire cursor_refresh,  // 游标位置更新
	input wire [15:0] cursor_timer,  // 游标闪烁时钟，毫秒单位
	input wire [31:16] vram_base,  // VRAM基址
	// VGA接口
	output reg h_sync,	//VGA水平同步信号
	output reg v_sync,	//VGA垂直同步信号
	output reg r, g, b,	//颜色分量
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
