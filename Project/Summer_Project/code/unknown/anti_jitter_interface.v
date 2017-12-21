/*
	去抖动模块
*/
module anti_jitter (
	input wire clk,  // 主时钟
	input wire rst,  // 同步复位信号
	input wire sig_i,  // 带有噪音的输入信号
	output reg sig_o = INIT_VALUE  // 输出无噪音信号
);

	parameter
		INIT_VALUE = 0;  // 初始输出值
endmodule
