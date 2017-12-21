/*
	UART�豸��wishbine���ӽӿڣ����ж�д������
*/
module wb_uart (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	// UART�ӿ��ź�
	input wire rx,	//	����rx�ź�
	output wire tx,	//	���tx�ź�
	//wishbone���豸�ӿ�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cs_i,	//wishbone���豸Ƭѡ�ź���
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone���豸��ַ�ź���
	input wire [3:0] wbs_sel_i,		//wishbone���豸ѡ���ź���
	input wire [31:0] wbs_data_i,	//wishbone���豸��������
	input wire wbs_we_i,	//wishbine���豸дʹ��
	output reg [31:0] wbs_data_o,	//wishbone���豸�������
	output reg wbs_ack_o,	//wishbine���豸Ӧ��
	//�ж�
	output reg interrupt	//uart�ж�
);
	parameter
		DEV_ADDR_BITS = 8;
		
endmodule
