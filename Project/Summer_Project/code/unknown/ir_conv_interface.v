/*
	中断信号转换，通过快时钟来采样中断信号
*/
module ir_conv (
	input wire clk,  // 采样时钟
	input wire rst,  // 同步复位信号
	input wire [INTERRUPT_NUMBER-1:0] ir_i,  // 中断信号输入
	output wire [INTERRUPT_NUMBER-1:0] ir_o  // 检测到的中断信号输出
);

	parameter
		INTERRUPT_NUMBER = 30;  // 中断信号数量

endmodule
