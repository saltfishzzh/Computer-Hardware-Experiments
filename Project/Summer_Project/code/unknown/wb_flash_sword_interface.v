/*
	Flash设备模块驱动与wishbone总线接口，包括输入输出异步缓冲
*/
module wb_flash_sword (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	output wire flash_busy,  // flash忙信号
	// Flash模块接口
	output wire [1:0] flash_ce_n,	//flash片选使能
	output wire flash_rst_n,	//flash复位信号
	output wire flash_oe_n,		//flash输出使能
	output wire flash_we_n,		//flash写使能
	output wire flash_wp_n,		//flash写保护
	input wire [1:0] flash_ready,	//flash准备信号
	output wire [ADDR_BITS-1:2] flash_addr,	//flash地址线
	input wire [31:0] flash_din,	//flash写入数据线
	output wire [31:0] flash_dout,	//flash读出数据线
	// wishbone从设备接口信号
	input wire wbs_clk_i,	//wishbone从设备时钟线
	input wire wbs_cyc_i,	//wishbone从设备总线操作指示，置1表示发起总线操作
	input wire wbs_stb_i,	//wishbone从设备数据传输指示，置1表示发起数据传输请求
	input wire [31:2] wbs_addr_i,	//wishbone从设备输出地址线
	input wire [2:0] wbs_cti_i,	//wishbone从设备数据传输方式选择
	input wire [1:0] wbs_bte_i,	//wishbone从设备地址递增Burst下的地址递增方式选择
	input wire [3:0] wbs_sel_i,	//wishbone从设备字节选择
	input wire wbs_we_i,	//wishbone从设备写使能
	input wire [31:0] wbs_data_i,	//wishbone从设备输入数据
	output wire [31:0] wbs_data_o,	//wishbone从设备输出数据
	output wire wbs_ack_o	//wishbone数据确认信号
);

	parameter
		ADDR_BITS = 25;  //地址总线长度

endmodule
