/*
	VGAͬ���źŲ�����
*/
module vga_core_sword (
	input wire clk,  // ��ʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire clk_base,  // VGAʱ���źţ����ݷֱ���ȷ��Ƶ�ʣ�Ĭ��25Mhz
	output wire vga_clk,  // VGAʱ���źţ���clk_base��ͬ
	output reg vga_valid,  // ͬ���ź���Ч��־
	output reg [10:0] h_count,  // ˮƽͬ��������
	output reg [10:0] v_count,  // ��ֱͬ��������
	output reg [20:0] p_count,  // ���ؼ�����
	output reg [10:0] h_disp_max,  // ��ʾˮƽ���ֵ
	output reg [10:0] v_disp_max,  // ��ʾ��ֱ���ֵ
	output reg [20:0] p_disp_max,  // ��ʾ�������ֵ
	output reg h_sync,  // ˮƽͬ���ź�
	output reg v_sync,  // ��ֱͬ���ź�
	output reg h_en,  // ˮƽͬ���źŷ�Χ��
	output reg v_en  // ��ֱͬ���źŷ�Χ��
);

endmodule
