/*
	MIPS五级流水线与wishbone总线接口
*/
module wb_mips (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	// CPU调试模式
	input wire debug_en,  // 调试使能
	input wire debug_step,  // 调试步长时钟
	input wire [6:0] debug_addr,  // 调试显示地址
	output wire [31:0] debug_data,  // 调试显示数据
	//ICMU的wishbone主设备接口
	input wire icmu_clk_i,	//wishbone icmu时钟线
	output wire icmu_cyc_o,	//wishbone icmu总线操作指示，置1表示发起总线操作
	output wire icmu_stb_o,	//wishbone icmu数据传输指示，置1表示发起数据传输请求
	output wire [31:2] icmu_addr_o,		//wishbone icmu输出地址线
	output wire [2:0] icmu_cti_o,		//wishbone icmu数据传输方式选择
	output wire [1:0] icmu_bte_o,		//wishbone icmu地址递增Burst下的地址递增方式选择
	output wire [3:0] icmu_sel_o,		//wishbone icmu字节选择
	output wire icmu_we_o,				//wishbone icmu写使能
	input wire [31:0] icmu_data_i,		//wishbone icmu输入数据
	output wire [31:0] icmu_data_o,		//wishbone icmu输出数据
	input wire icmu_ack_i,				//wishbone数据确认信号
	input wire icmu_err_i,		//wishbone错误信号
	//DCMU的wishbone主设备接口
	input wire dcmu_clk_i,	//wishbone dcmu时钟线
	output wire dcmu_cyc_o,	//wishbone dcmu总线操作指示，置1表示发起总线操作
	output wire dcmu_stb_o,	//wishbone dcmu数据传输指示，置1表示发起数据传输请求
	output wire [31:2] dcmu_addr_o,		//wishbone dcmu输出地址线
	output wire [2:0] dcmu_cti_o,		//wishbone dcmu数据传输方式选择
	output wire [1:0] dcmu_bte_o,		//wishbone dcmu地址递增Burst下的地址递增方式选择
	output wire [3:0] dcmu_sel_o,		//wishbone dcmu字节选择
	output wire dcmu_we_o,				//wishbone dcmu写使能
	input wire [31:0] dcmu_data_i,		//wishbone dcmu输入数据
	output wire [31:0] dcmu_data_o,		//wishbone dcmu输出数据
	input wire dcmu_ack_i,				//wishbone数据确认信号
	input wire dcmu_err_i,		//wishbone错误信号
	//中断
	input wire [30:1] ir_map,  //设备中断信号
	output wire wd_rst  //看门口复位中断，不能被全局复位信号所影响
);

endmodule
