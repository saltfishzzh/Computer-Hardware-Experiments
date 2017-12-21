/*
	板级显示模块与wishb总线接口
*/
module wb_board_sword (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	// 板级接口
	input wire [15:0] switch,	//16个的开关控制
	output reg [4:0] btn_x,		//阵列键盘的x坐标
	input wire [4:0] btn_y,		//阵列键盘的y坐标
	output wire led_clk,		//led灯时钟
	output wire led_en,			//led灯使能信号
	output wire led_clr_n,		//led灯复位信号
	output wire led_do,			//led灯串行信号
	output wire seg_clk,		//seg七段码时钟
	output wire seg_en,			//seg七段码使能信号
	output wire seg_clr_n,		//seg七段码复位信号
	output wire seg_do,			//seg七段码串行数据
	// wishbone从设备接口
	input wire wbs_clk_i,	//wishbone从设备时钟线
	input wire wbs_cs_i,	//wishbone从设备片选信号线
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone从设备地址信号线
	input wire [3:0] wbs_sel_i,		//wishbone从设备选择信号线
	input wire [31:0] wbs_data_i,	//wishbone从设备数据输入
	input wire wbs_we_i,	//wishbine从设备写使能
	output reg [31:0] wbs_data_o,	//wishbone从设备数据输出
	output reg wbs_ack_o,	//wishbine从设备应答
	// 调试模式显示接口
	input wire debug_en,	//调试模式使能
	input wire [15:0] debug_led,	//调试模式led显示数据
	input wire [31:0] debug_data,	//调试模式七段码显示数据
	input wire [15:0] debug_dot,	//调试模式七段码小数点
	// 中断
	output reg interrupt	//板级显示中断
);

	parameter
		DEV_ADDR_BITS = 8;  // IO空间设备地址长度

endmodule
