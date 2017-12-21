/*
 * VGA��ʾģ����wishbone��������ģ��
*/
module wb_vga_sword (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire clk_base,  // VGAʱ���źţ����ݷֱ���ȷ��Ƶ�ʣ�Ĭ��25Mhz
	// VGA�ӿ��ź�
	output reg h_sync,	// VGAˮƽͬ���ź�
	output reg v_sync,	// VGA��ֱͬ���ź�
	output reg [3:0] r_color,	// VGA��ɫ��ʾ����
	output reg [3:0] g_color,	// VGA��ɫ��ʾ����
	output reg [3:0] b_color,	// VGA��ɫ��ʾ����
	// VRAM��wishbone���豸�ӿ��ź�
	input wire wbm_clk_i,	//wishbone���豸ʱ����
	output reg wbm_cyc_o,	//wishbone���豸���߲���ָʾ����1��ʾ�������߲���
	output reg wbm_stb_o,	//wishbone���豸���ݴ���ָʾ����1��ʾ�������ݴ�������
	output reg [31:2] wbm_addr_o,	//wishbone���豸�����ַ��
	output reg [2:0] wbm_cti_o,	//wishbone���豸���ݴ��䷽ʽѡ��
	output reg [1:0] wbm_bte_o,	//wishbone���豸��ַ����Burst�µĵ�ַ������ʽѡ��
	output reg [3:0] wbm_sel_o,	//wishbone���豸�ֽ�ѡ��
	output reg wbm_we_o,	//wishbone���豸дʹ��
	input wire [31:0] wbm_data_i,	//wishbone���豸��������
	output reg [31:0] wbm_data_o,	//wishbone���豸�������
	input wire wbm_ack_i,	//wishbone����ȷ���ź�
	// wishbone���豸�ӿ��ź�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cs_i,	//wishbone���豸Ƭѡ�ź���
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone���豸��ַ�ź���
	input wire [3:0] wbs_sel_i,		//wishbone���豸ѡ���ź���
	input wire [31:0] wbs_data_i,	//wishbone���豸��������
	input wire wbs_we_i,	//wishbine���豸дʹ��
	output reg [31:0] wbs_data_o,	//wishbone���豸�������
	output reg wbs_ack_o	//wishbine���豸Ӧ��
);
	parameter
		DEV_ADDR_BITS = 8;
endmodule
	