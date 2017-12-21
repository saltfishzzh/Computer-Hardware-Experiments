/*
	内存管理单元MMU
*/
module mmu (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	input wire suspend,  // 强制挂起当前进程
	// 地址转换接口
	input wire en_mmu,  // MMU使能
	output reg stall,  // 当MMU忙时stall其他组件
	input wire [31:12] pdb_addr,  // 页目录表基地址
	input wire [31:12] logical,  // 逻辑地址
	output reg [31:12] physical,  // 物理地址
	output reg page_fault,  // 页表错误
	output reg auth_user,  // 用户获得访问权限标志
	output reg auth_exec,  // 用户获得执行权限标志
	output reg auth_write,  // 用户获得写权限标志
	output reg en_cache,  // 当前页cache使能
	// 页信息抓取接口
	output reg ren,  // 读使能
	output reg [31:0] addr,  // 数据地址
	input wire ack,  // 确认信号
	input wire [31:0] data  // 数据
);

endmodule
