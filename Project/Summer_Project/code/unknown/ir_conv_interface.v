/*
	�ж��ź�ת����ͨ����ʱ���������ж��ź�
*/
module ir_conv (
	input wire clk,  // ����ʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire [INTERRUPT_NUMBER-1:0] ir_i,  // �ж��ź�����
	output wire [INTERRUPT_NUMBER-1:0] ir_o  // ��⵽���ж��ź����
);

	parameter
		INTERRUPT_NUMBER = 30;  // �ж��ź�����

endmodule
