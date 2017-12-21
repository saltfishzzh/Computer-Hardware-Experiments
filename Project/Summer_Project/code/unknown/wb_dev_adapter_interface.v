/*
	wishbone�����豸����������һ��wishbone���豸�ӿڷ������С���豸�ӿ�
*/
module wb_dev_adapter (
	// wishbone���豸�ܽӿ�
	input wire wbs_cyc_i,	//wishbone���豸���������߲���ָʾ����1��ʾ�������߲���
	input wire wbs_stb_i,	//wishbone���豸���������ݴ���ָʾ����1��ʾ�������ݴ�������
	input wire [TOTAL_ADDR_BITS-1:2] wbs_addr_i,	//wishbone���豸�����������ַ��
	input wire [3:0] wbs_sel_i,	//wishbone���豸�������ֽ�ѡ��
	input wire wbs_we_i,	//wishbone���豸������дʹ��
	input wire [31:0] wbs_data_i,	//wishbone���豸��������������
	output reg [31:0] wbs_data_o,	//wishbone���豸�������
	output reg wbs_ack_o,	//wishbone����ȷ���ź�
	output reg wbs_err_o,	//wishbone���ݴ����ź�
	// 0�Ŵ��豸�ӿ�
	output reg d0_cs_o,	//0�Ŵ��豸Ƭѡʹ��
	output reg [SINGLE_ADDR_BITS-1:2] d0_addr_o,	//0�Ŵ��豸�������ַ
	output reg [3:0] d0_sel_o,	//0�Ŵ��豸���ֽ�ѡ��
	output reg d0_we_o,	//0�Ŵ��豸дʹ��
	output reg [31:0] d0_data_o,	//0�Ŵ��豸����������
	input wire [31:0] d0_data_i,	//0�Ŵ��豸����������
	input wire d0_ack_i,	//0�Ŵ��豸������ȷ���ź�
	// 1�Ŵ��豸�ӿ�
	output reg d1_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d1_addr_o,
	output reg [3:0] d1_sel_o,
	output reg d1_we_o,
	output reg [31:0] d1_data_o,
	input wire [31:0] d1_data_i,
	input wire d1_ack_i,
	// 2�Ŵ��豸�ӿ�
	output reg d2_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d2_addr_o,
	output reg [3:0] d2_sel_o,
	output reg d2_we_o,
	output reg [31:0] d2_data_o,
	input wire [31:0] d2_data_i,
	input wire d2_ack_i,
	// 3�Ŵ��豸�ӿ�
	output reg d3_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d3_addr_o,
	output reg [3:0] d3_sel_o,
	output reg d3_we_o,
	output reg [31:0] d3_data_o,
	input wire [31:0] d3_data_i,
	input wire d3_ack_i,
	// 4�Ŵ��豸�ӿ�
	output reg d4_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d4_addr_o,
	output reg [3:0] d4_sel_o,
	output reg d4_we_o,
	output reg [31:0] d4_data_o,
	input wire [31:0] d4_data_i,
	input wire d4_ack_i,
	// 5�Ŵ��豸�ӿ�
	output reg d5_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d5_addr_o,
	output reg [3:0] d5_sel_o,
	output reg d5_we_o,
	output reg [31:0] d5_data_o,
	input wire [31:0] d5_data_i,
	input wire d5_ack_i,
	// 6�Ŵ��豸�ӿ�
	output reg d6_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d6_addr_o,
	output reg [3:0] d6_sel_o,
	output reg d6_we_o,
	output reg [31:0] d6_data_o,
	input wire [31:0] d6_data_i,
	input wire d6_ack_i,
	// 7�Ŵ��豸�ӿ�
	output reg d7_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d7_addr_o,
	output reg [3:0] d7_sel_o,
	output reg d7_we_o,
	output reg [31:0] d7_data_o,
	input wire [31:0] d7_data_i,
	input wire d7_ack_i,
	// 8�Ŵ��豸�ӿ�
	output reg d8_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d8_addr_o,
	output reg [3:0] d8_sel_o,
	output reg d8_we_o,
	output reg [31:0] d8_data_o,
	input wire [31:0] d8_data_i,
	input wire d8_ack_i,
	// 9�Ŵ��豸�ӿ�
	output reg d9_cs_o,
	output reg [SINGLE_ADDR_BITS-1:2] d9_addr_o,
	output reg [3:0] d9_sel_o,
	output reg d9_we_o,
	output reg [31:0] d9_data_o,
	input wire [31:0] d9_data_i,
	input wire d9_ack_i,
	// 1x�Ŵ��豸�ӿ�
	output reg d1x_cs_o,
	output reg [TOTAL_ADDR_BITS-1:2] d1x_addr_o,
	output reg [3:0] d1x_sel_o,
	output reg d1x_we_o,
	output reg [31:0] d1x_data_o,
	input wire [31:0] d1x_data_i,
	input wire d1x_ack_i
);
	
	parameter
		TOTAL_ADDR_BITS = 16,  // ����IO����ռ��ַ����
		SINGLE_ADDR_BITS = 8;  // ����IO����ռ��ַ����

endmodule
