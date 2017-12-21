/*
	PS2���̿�������wishbone��������ģ�飬��ϵͳ�ۺϵ�ʱ�������user���ۺ�ѡ��
*/
module wb_ps2 (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	// PS2�ӿ�
	input wire ps2_clk,	//ps2ʱ���ź���
	input wire ps2_dat,	//ps2�����ź���

	// wishbone���豸�ӿ��ź�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cs_i,	//wishbone���豸Ƭѡ�ź���
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone���豸��ַ�ź���
	input wire [3:0] wbs_sel_i,		//wishbone���豸ѡ���ź���
	input wire [31:0] wbs_data_i,	//wishbone���豸��������
	input wire wbs_we_i,	//wishbine���豸дʹ��
	output reg [31:0] wbs_data_o,	//wishbone���豸�������
	output reg wbs_ack_o,	//wishbine���豸Ӧ��
	// �ж�
	output reg interrupt,	//�����ж�
	output reg intererr		//���̲��������ж�
);

	parameter
		DEV_ADDR_BITS = 8;

endmodule
