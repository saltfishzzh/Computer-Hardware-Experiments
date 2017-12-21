/*
 * VGA显示模块与wishbone总线连接模块
*/
module wb_vga_sword (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	input wire clk_base,  // VGA时钟信号，根据分辨率确定频率，默认25Mhz
	// VGA接口信号
	output reg h_sync,	// VGA水平同步信号
	output reg v_sync,	// VGA垂直同步信号
	output reg [3:0] r_color,	// VGA红色显示分量
	output reg [3:0] g_color,	// VGA绿色显示分量
	output reg [3:0] b_color,	// VGA蓝色显示分量
	// VRAM的wishbone主设备接口信号
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
	input wire wbm_ack_i,	//wishbone数据确认信号
	// wishbone从设备接口信号
	input wire wbs_clk_i,	//wishbone从设备时钟线
	input wire wbs_cs_i,	//wishbone从设备片选信号线
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone从设备地址信号线
	input wire [3:0] wbs_sel_i,		//wishbone从设备选择信号线
	input wire [31:0] wbs_data_i,	//wishbone从设备数据输入
	input wire wbs_we_i,	//wishbine从设备写使能
	output reg [31:0] wbs_data_o,	//wishbone从设备数据输出
	output reg wbs_ack_o	//wishbine从设备应答
);
	parameter
		DEV_ADDR_BITS = 8;
endmodule
	