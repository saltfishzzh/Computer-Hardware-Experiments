/*
	ȥ����ģ��
*/
module anti_jitter (
	input wire clk,  // ��ʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire sig_i,  // ���������������ź�
	output reg sig_o = INIT_VALUE  // ����������ź�
);

	parameter
		INIT_VALUE = 0;  // ��ʼ���ֵ
endmodule
