/*
	VGA�ı���ʾ��wishbone���߽ӿڣ�����buffer
*/
module wb_vga_text (
	input wire clk,  // ��ʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire vga_clk,  // VGAʱ�ӣ���VGA����ģ�����
	input wire [10:0] h_count_core,  // ˮƽͬ������������VGA����ģ�����
	input wire [10:0] h_disp_max,  // ˮƽ�����ʾ��Χ
	input wire [10:0] v_count_core,  // ��ֱͬ������������VGA����ģ�����
	input wire [10:0] v_disp_max,  // ��ֱ�����ʾ��Χ
	input wire h_sync_core,  // ˮƽͬ���źţ���VGA����ģ�����
	input wire v_sync_core,  // ��ֱͬ���źţ���VGA����ģ�����
	input wire h_en_core,  // ˮƽͬ���źŷ�Χ�ڣ���VGA����ģ�����
	input wire v_en_core,  // ��ֱͬ���źŷ�Χ�ڣ���VGA����ģ�����
	input wire [7:0] cursor_h_pos,  // �α�ˮƽλ��
	input wire [5:0] cursor_v_pos,  // �α괹ֱλ��
	input wire cursor_en,  // �α���ʾʹ��
	input wire cursor_refresh,  // �α�λ�ø���
	input wire [15:0] cursor_timer,  // �α���˸ʱ�ӣ����뵥λ
	input wire [31:16] vram_base,  // VRAM��ַ
	// VGA�ӿ�
	output reg h_sync,	//VGAˮƽͬ���ź�
	output reg v_sync,	//VGA��ֱͬ���ź�
	output reg r, g, b,	//��ɫ����
	// wishbone���豸���߽ӿ�
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
	input wire wbm_ack_i	//wishbone����ȷ���ź�
);

endmodule
