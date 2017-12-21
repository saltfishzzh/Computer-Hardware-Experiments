/*
	缓存管理单元
*/
module wb_cmu (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	input wire suspend,  // 强制挂起当前进程
	input wire en_cache,  // 是否使用cache访问内存
	input wire [31:0] addr_rw,  // 读写数据地址
	input wire [1:0] addr_type,  // 内存访问类型（字，半字，字节）
	input wire sign_ext,  // 对于半字或字节读取时是否使用符号扩展
	input wire en_r,  // 读使能
	output reg [31:0] data_r,  // 数据读出
	input wire en_w,  // 写使能
	input wire [31:0] data_w,  // 数据写入
	input wire en_f,  // flush使能
	input wire lock,  // 当前数据锁，防止数据被重复访问
	output reg stall,  // 当CMU忙时stall其他组件
	output reg align_err,  // 地址未对齐错误
	output reg bus_err,  // 总线错误
	// wishbone总线接口
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
	input wire wbm_err_i	//wishbone错误信号
);


endmodule
