/*
 * SD卡驱动模块，采用SD MODE模式，与wishbine总线连接
*/
module wb_sd (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	// SD卡接口
	input sd_cmd_dat_i,	//sd卡命令输入
	output sd_cmd_out_o,	//sd卡命令输出
	input [3:0] sd_dat_dat_i,	//sd卡写入数据
	output [3:0] sd_dat_out_o,	//sd卡读出数据
	input sd_cd,	//sd卡检测位
	output sd_clk,	//sd卡时钟
	output sd_rst,	//sd卡复位信号
	//SD 总线信号
	output sd_dat_oe,	//sd卡数据输出使能
	output sd_cmd_oe,	//sd卡命令输出使能
	//wishbone从设备接口信号
	input wire wbs_clk_i,	//wishbone从设备时钟线
	input wire wbs_cs_i,	//wishbone从设备片选信号线
	input wire [15:2] wbs_addr_i,		//wishbone从设备地址信号线
	input wire [3:0] wbs_sel_i,			//wishbone从设备选择信号线
	input wire [31:0] wbs_data_i,		//wishbone从设备数据输入
	input wire wbs_we_i,				//wishbine从设备写使能
	output wire [31:0] wbs_data_o,		//wishbone从设备数据输出
	output wire wbs_ack_o,				//wishbine从设备应答
	//中断
	output reg interrupt				//sd卡中断
);

endmodule
