/*
 * SD������ģ�飬����SD MODEģʽ����wishbine��������
*/
module wb_sd (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	// SD���ӿ�
	input sd_cmd_dat_i,	//sd����������
	output sd_cmd_out_o,	//sd���������
	input [3:0] sd_dat_dat_i,	//sd��д������
	output [3:0] sd_dat_out_o,	//sd����������
	input sd_cd,	//sd�����λ
	output sd_clk,	//sd��ʱ��
	output sd_rst,	//sd����λ�ź�
	//SD �����ź�
	output sd_dat_oe,	//sd���������ʹ��
	output sd_cmd_oe,	//sd���������ʹ��
	//wishbone���豸�ӿ��ź�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cs_i,	//wishbone���豸Ƭѡ�ź���
	input wire [15:2] wbs_addr_i,		//wishbone���豸��ַ�ź���
	input wire [3:0] wbs_sel_i,			//wishbone���豸ѡ���ź���
	input wire [31:0] wbs_data_i,		//wishbone���豸��������
	input wire wbs_we_i,				//wishbine���豸дʹ��
	output wire [31:0] wbs_data_o,		//wishbone���豸�������
	output wire wbs_ack_o,				//wishbine���豸Ӧ��
	//�ж�
	output reg interrupt				//sd���ж�
);

endmodule
