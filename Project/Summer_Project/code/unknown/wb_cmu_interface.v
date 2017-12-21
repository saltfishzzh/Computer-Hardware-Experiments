/*
	�������Ԫ
*/
module wb_cmu (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire suspend,  // ǿ�ƹ���ǰ����
	input wire en_cache,  // �Ƿ�ʹ��cache�����ڴ�
	input wire [31:0] addr_rw,  // ��д���ݵ�ַ
	input wire [1:0] addr_type,  // �ڴ�������ͣ��֣����֣��ֽڣ�
	input wire sign_ext,  // ���ڰ��ֻ��ֽڶ�ȡʱ�Ƿ�ʹ�÷�����չ
	input wire en_r,  // ��ʹ��
	output reg [31:0] data_r,  // ���ݶ���
	input wire en_w,  // дʹ��
	input wire [31:0] data_w,  // ����д��
	input wire en_f,  // flushʹ��
	input wire lock,  // ��ǰ����������ֹ���ݱ��ظ�����
	output reg stall,  // ��CMUæʱstall�������
	output reg align_err,  // ��ַδ�������
	output reg bus_err,  // ���ߴ���
	// wishbone���߽ӿ�
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
	input wire wbm_err_i	//wishbone�����ź�
);


endmodule
