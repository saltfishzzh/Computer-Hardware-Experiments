/*
	MIPS 带有5级流水线的CPU核心，包括数据通路，控制模块与协处理器
*/
module mips_core (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	// 调试模式
	input wire debug_en,  // 调试使能
	input wire debug_step,  // 调试步时钟
	input wire [6:0] debug_addr,  // 调试地址
	output wire [31:0] debug_data,  // 调试数据
	// MMU接口
	output wire user_mode,  // 判断是否为用户模式标志
	output wire mmu_en,  // MMU使能
	output wire mmu_inv,  // 无效MMU信号
	output wire [31:PAGE_ADDR_BITS] pdb_addr,  // 页目录表基址
	// 指令接口
	output wire inst_ren,  // 读指令使能
	input wire inst_stall,  // 当IMMU/ICACHE在取数据时候的stall信号
	output wire [31:0] inst_addr,  // 指令地址
	input wire [31:0] inst_data,  // 指令数据
	input wire inst_unalign,  // 指令未对齐异常
	input wire inst_bus_err,  // 指令总线读异常
	input wire inst_page_fault,  // 指令页异常
	input wire inst_unauth_user,  // 用户模式下未授权指令异常
	input wire inst_unauth_exec,  // 未授权指令执行异常
	output wire ic_lock,  // 指令缓存锁信号，防止两次访问同样数据
	output wire ic_inv,  // 无效指令缓存信号
	// 内存接口
	output wire mem_ren,  // 内存读使能
	output wire mem_wen,  // 内存写使能
	input wire mem_stall,  // 当DMMU/DCACHE取数据时候的stall信号
	output wire [1:0] mem_type,  // 内存访问类型（字，半字，字节）
	output wire mem_ext,  // 是否为符号扩展
	output wire [31:0] mem_addr,  // 内存地址
	output wire [31:0] mem_dout,  // 写入内存数据
	input wire [31:0] mem_din,  // 内存读出数据
	input wire mem_unalign,  // 内存未对齐异常
	input wire mem_bus_err,  // 内存总线读异常
	input wire mem_page_fault,  // 内存页异常
	input wire mem_unauth_user,  // 用户模式下未授权内存异常
	input wire mem_unauth_write,  // 未授权指令写异常
	output wire dc_lock,  // 数据缓存锁，防止两次访问同样数据
	output wire dc_inv,  // 无效数据缓存信号
	// 中断接口
	input wire [30:1] ir_map,  // 设备中断信号
	output wire wd_rst,  // 看门口复位信号，独立于全局复位信号
	output wire exception  // 中断发生信号
);
	
	parameter
		PAGE_ADDR_BITS = 12;  // 一个内存页长度
		
endmodule
