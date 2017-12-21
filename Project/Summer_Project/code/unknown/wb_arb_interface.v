/*
	wishbone�豸�ٲ����������豸�����ȼ�Ϊ m0 > m1 > m2 > ...
*/
module wb_arb (
	input wire wb_clk,  // wishboneʱ��
	input wire wb_rst,  // ͬ����λ�ź�
	// 0�����豸VRAM
	input wire m0_cyc_i, m0_stb_i,	//wishbone���߲���ָʾ�����ݴ���ָʾ
	input wire [31:2] m0_addr_i,	//wishbone��ַ
	input wire [2:0] m0_cti_i,		//wishbone���ݴ��䷽ʽѡ��
	input wire [1:0] m0_bte_i,	//wishbone��ַ����Burst�µĵ�ַ������ʽѡ��
	input wire [3:0] m0_sel_i,	//wishbone�ֽ�ѡ��
	input wire m0_we_i,	//wishboneдʹ��
	output reg [31:0] m0_data_o,	//wishbone�������
	input wire [31:0] m0_data_i,	//wishbone��������
	output reg m0_ack_o,	//wishbone����ȷ���ź�
	output reg m0_err_o,	//wishbone���ݴ����ź�
	// 1�����豸ICMU
	input wire m1_cyc_i, m1_stb_i,
	input wire [31:2] m1_addr_i,
	input wire [2:0] m1_cti_i,
	input wire [1:0] m1_bte_i,
	input wire [3:0] m1_sel_i,
	input wire m1_we_i,
	output reg [31:0] m1_data_o,
	input wire [31:0] m1_data_i,
	output reg m1_ack_o,
	output reg m1_err_o,
	// 2�����豸DCMU
	input wire m2_cyc_i, m2_stb_i,
	input wire [31:2] m2_addr_i,
	input wire [2:0] m2_cti_i,
	input wire [1:0] m2_bte_i,
	input wire [3:0] m2_sel_i,
	input wire m2_we_i,
	output reg [31:0] m2_data_o,
	input wire [31:0] m2_data_i,
	output reg m2_ack_o,
	output reg m2_err_o,
	// 3�����豸DMA
	input wire m3_cyc_i, m3_stb_i,
	input wire [31:2] m3_addr_i,
	input wire [2:0] m3_cti_i,
	input wire [1:0] m3_bte_i,
	input wire [3:0] m3_sel_i,
	input wire m3_we_i,
	output reg [31:0] m3_data_o,
	input wire [31:0] m3_data_i,
	output reg m3_ack_o,
	output reg m3_err_o,
	// 0�Ŵ��豸RAM
	output reg  s0_cyc_o, s0_stb_o,
	output reg [31:2] s0_addr_o,
	output reg [2:0] s0_cti_o,
	output reg [1:0] s0_bte_o,
	output reg [3:0] s0_sel_o,
	output reg s0_we_o,
	input wire [31:0] s0_data_i,
	output reg [31:0] s0_data_o,
	input wire s0_ack_i,
	input wire s0_err_i,
	// 1�Ŵ��豸ROM
	output reg  s1_cyc_o, s1_stb_o,
	output reg [31:2] s1_addr_o,
	output reg [2:0] s1_cti_o,
	output reg [1:0] s1_bte_o,
	output reg [3:0] s1_sel_o,
	output reg s1_we_o,
	input wire [31:0] s1_data_i,
	output reg [31:0] s1_data_o,
	input wire s1_ack_i,
	input wire s1_err_i,
	// 2�Ŵ��豸IO����
	output reg  s2_cyc_o, s2_stb_o,
	output reg [31:2] s2_addr_o,
	output reg [2:0] s2_cti_o,
	output reg [1:0] s2_bte_o,
	output reg [3:0] s2_sel_o,
	output reg s2_we_o,
	input wire [31:0] s2_data_i,
	output reg [31:0] s2_data_o,
	input wire s2_ack_i,
	input wire s2_err_i
);

endmodule

