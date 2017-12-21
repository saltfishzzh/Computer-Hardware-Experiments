/*
	Flash�豸ģ��������wishbone���߽ӿڣ�������������첽����
*/
module wb_flash_sword (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	output wire flash_busy,  // flashæ�ź�
	// Flashģ��ӿ�
	output wire [1:0] flash_ce_n,	//flashƬѡʹ��
	output wire flash_rst_n,	//flash��λ�ź�
	output wire flash_oe_n,		//flash���ʹ��
	output wire flash_we_n,		//flashдʹ��
	output wire flash_wp_n,		//flashд����
	input wire [1:0] flash_ready,	//flash׼���ź�
	output wire [ADDR_BITS-1:2] flash_addr,	//flash��ַ��
	input wire [31:0] flash_din,	//flashд��������
	output wire [31:0] flash_dout,	//flash����������
	// wishbone���豸�ӿ��ź�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cyc_i,	//wishbone���豸���߲���ָʾ����1��ʾ�������߲���
	input wire wbs_stb_i,	//wishbone���豸���ݴ���ָʾ����1��ʾ�������ݴ�������
	input wire [31:2] wbs_addr_i,	//wishbone���豸�����ַ��
	input wire [2:0] wbs_cti_i,	//wishbone���豸���ݴ��䷽ʽѡ��
	input wire [1:0] wbs_bte_i,	//wishbone���豸��ַ����Burst�µĵ�ַ������ʽѡ��
	input wire [3:0] wbs_sel_i,	//wishbone���豸�ֽ�ѡ��
	input wire wbs_we_i,	//wishbone���豸дʹ��
	input wire [31:0] wbs_data_i,	//wishbone���豸��������
	output wire [31:0] wbs_data_o,	//wishbone���豸�������
	output wire wbs_ack_o	//wishbone����ȷ���ź�
);

	parameter
		ADDR_BITS = 25;  //��ַ���߳���

endmodule
