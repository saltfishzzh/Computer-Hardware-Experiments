/*
	Sram�豸ģ��������wishbone���߽ӿڣ�������������첽����
*/
module wb_sram_sword (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	output wire ram_busy,  // sramæ�ź�
	// SRAM�ӿ�
	output wire [2:0] sram_ce_n,	//sramƬѡʹ��
	output wire [2:0] sram_oe_n,	//sram���ʹ��
	output wire [2:0] sram_we_n,	//sramдʹ��
	output wire [2:0] sram_lb_n,	//sram��λ����
	output wire [2:0] sram_ub_n,	//sram��λ����
	output wire [ADDR_BITS-1:2] sram_addr,	//sram��ַ��
	input wire [47:0] sram_din,	//sramд��������
	output wire [47:0] sram_dout,	//sram����������
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
	output wire [31:0] wbs_data_o,	//wishbone���豸��������
	output wire wbs_ack_o,	//wishbone����ȷ���ź�
	output wire wbs_err_o	//wishbone�����ź���
);


	parameter
		ADDR_BITS = 25;  //��ַ���߳���

endmodule
