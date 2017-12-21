/**
 * Parallel-Serial Converter.
 * Author: Zhao, Hongyu  <power_zhy@foxmail.com>
 * Editor: Frank Shaw    <xiaoqingzhe@gmail.com>
 */
module parallel2serial (
	input wire clk,  // main clock
	input wire rst,  // synchronous reset
	input wire [DATA_BITS-1:0] data,  // parallel input data
	input wire start,  // start command
	output reg busy,  // busy flag
	output reg finish,  // finish acknowledgement
	output reg s_clk = 0,  // serial clock
	output reg s_clr = 0,  // serial clear
	output wire s_dat  // serial output data
	);

parameter
		P_CLK_FREQ = 100,  // main clock frequency in MHz
		S_CLK_FREQ = 20,  // serial clock frequency in MHz
		DATA_BITS = 32,  // data length
		READ_DIRECTION = 1;  // 0 for read from lowest significant digit and 1 for read from most significant digit

endmodule
