/*
	三色呼吸灯模块，给定一个时钟，将输出蓝绿两个灯的呼吸模式
*/
module tri_led (
	input wire clk,
	output wire tri_led0_r_n,	//第一个三色灯的红色分量
	output wire tri_led0_g_n,	//第一个三色灯的绿色分量
	output wire tri_led0_b_n,	//第一个三色灯的蓝色分量
	output wire tri_led1_r_n,	//第二个三色灯的红色分量
	output wire tri_led1_g_n,	//第二个三色灯的绿色分量
	output wire tri_led1_b_n	//第二个三色灯的蓝色分量
);

endmodule
