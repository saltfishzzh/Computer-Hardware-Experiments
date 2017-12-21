/*
	PS2键盘控制器与wishbone总线连接模块，在系统综合的时候，请采用user的综合选项
*/
module wb_ps2 (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	// PS2接口
	input wire ps2_clk,	//ps2时钟信号线
	input wire ps2_dat,	//ps2数据信号线

	// wishbone从设备接口信号
	input wire wbs_clk_i,	//wishbone从设备时钟线
	input wire wbs_cs_i,	//wishbone从设备片选信号线
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone从设备地址信号线
	input wire [3:0] wbs_sel_i,		//wishbone从设备选择信号线
	input wire [31:0] wbs_data_i,	//wishbone从设备数据输入
	input wire wbs_we_i,	//wishbine从设备写使能
	output reg [31:0] wbs_data_o,	//wishbone从设备数据输出
	output reg wbs_ack_o,	//wishbine从设备应答
	// 中断
	output reg interrupt,	//键盘中断
	output reg intererr		//键盘产生错误中断
);

	parameter
		DEV_ADDR_BITS = 8;

endmodule
