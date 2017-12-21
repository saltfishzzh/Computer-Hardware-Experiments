/*
	wishbone总线设备适配器，将一个wishbone从设备接口分做多个小的设备接口
*/
module wb_dev_adapter (
	// wishbone从设备总接口
	input wire wbs_cyc_i,	//wishbone主设备发来的总线操作指示，置1表示发起总线操作
	input wire wbs_stb_i,	//wishbone主设备发来的数据传输指示，置1表示发起数据传输请求
	input wire [TOTAL_ADDR_BITS-1:2] wbs_addr_i,	//wishbone主设备发来的输出地址线
	input wire [3:0] wbs_sel_i,	//wishbone主设备发来的字节选择
	input wire wbs_we_i,	//wishbone主设备发来的写使能
	input wire [31:0] wbs_data_i,	//wishbone主设备发来的输入数据
	output reg [31:0] wbs_data_o,	//wishbone从设备输出数据
	output reg wbs_ack_o,	//wishbone数据确认信号
	output reg wbs_err_o,	//wishbone数据错误信号
	// 0号从设备接口
	output reg d0_cs_o,	//0号从设备片选使能
	output reg [SINGLE_ADDR_BITS-1:2] d0_addr_o,	//0号从设备的输出地址
	output reg [3:0] d0_sel_o,	//0号从设备的字节选择
	output reg d0_we_o,	//0号从设备写使能
	output reg [31:0] d0_data_o,	//0号从设备的输入数据
	input wire [31:0] d0_data_i,	//0号从设备的输入数据
	input wire d0_ack_i,	//0号从设备的数据确认信号
	// 1号从设备接口
	output reg d1_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d1_addr_o,
	output reg [3:0] d1_sel_o,
	output reg d1_we_o,
	output reg [31:0] d1_data_o,
	input wire [31:0] d1_data_i,
	input wire d1_ack_i,
	// 2号从设备接口
	output reg d2_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d2_addr_o,
	output reg [3:0] d2_sel_o,
	output reg d2_we_o,
	output reg [31:0] d2_data_o,
	input wire [31:0] d2_data_i,
	input wire d2_ack_i,
	// 3号从设备接口
	output reg d3_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d3_addr_o,
	output reg [3:0] d3_sel_o,
	output reg d3_we_o,
	output reg [31:0] d3_data_o,
	input wire [31:0] d3_data_i,
	input wire d3_ack_i,
	// 4号从设备接口
	output reg d4_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d4_addr_o,
	output reg [3:0] d4_sel_o,
	output reg d4_we_o,
	output reg [31:0] d4_data_o,
	input wire [31:0] d4_data_i,
	input wire d4_ack_i,
	// 5号从设备接口
	output reg d5_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d5_addr_o,
	output reg [3:0] d5_sel_o,
	output reg d5_we_o,
	output reg [31:0] d5_data_o,
	input wire [31:0] d5_data_i,
	input wire d5_ack_i,
	// 6号从设备接口
	output reg d6_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d6_addr_o,
	output reg [3:0] d6_sel_o,
	output reg d6_we_o,
	output reg [31:0] d6_data_o,
	input wire [31:0] d6_data_i,
	input wire d6_ack_i,
	// 7号从设备接口
	output reg d7_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d7_addr_o,
	output reg [3:0] d7_sel_o,
	output reg d7_we_o,
	output reg [31:0] d7_data_o,
	input wire [31:0] d7_data_i,
	input wire d7_ack_i,
	// 8号从设备接口
	output reg d8_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d8_addr_o,
	output reg [3:0] d8_sel_o,
	output reg d8_we_o,
	output reg [31:0] d8_data_o,
	input wire [31:0] d8_data_i,
	input wire d8_ack_i,
	// 9号从设备接口
	output reg d9_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d9_addr_o,
	output reg [3:0] d9_sel_o,
	output reg d9_we_o,
	output reg [31:0] d9_data_o,
	input wire [31:0] d9_data_i,
	input wire d9_ack_i,
	// 1x号从设备接口
	output reg d1x_cs_o,
	output reg [TOTAL_ADDR_BITS-1:2] d1x_addr_o,
	output reg [3:0] d1x_sel_o,
	output reg d1x_we_o,
	output reg [31:0] d1x_data_o,
	input wire [31:0] d1x_data_i,
	input wire d1x_ack_i
);
	
	parameter
		TOTAL_ADDR_BITS = 16,  // 整个IO外设空间地址长度
		SINGLE_ADDR_BITS = 8;  // 单个IO外设空间地址长度

endmodule
