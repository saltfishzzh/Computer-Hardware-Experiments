/*
	MIPS�弶��ˮ����wishbone���߽ӿ�
*/
module wb_mips (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	// CPU����ģʽ
	input wire debug_en,  // ����ʹ��
	input wire debug_step,  // ���Բ���ʱ��
	input wire [6:0] debug_addr,  // ������ʾ��ַ
	output wire [31:0] debug_data,  // ������ʾ����
	//ICMU��wishbone���豸�ӿ�
	input wire icmu_clk_i,	//wishbone icmuʱ����
	output wire icmu_cyc_o,	//wishbone icmu���߲���ָʾ����1��ʾ�������߲���
	output wire icmu_stb_o,	//wishbone icmu���ݴ���ָʾ����1��ʾ�������ݴ�������
	output wire [31:2] icmu_addr_o,		//wishbone icmu�����ַ��
	output wire [2:0] icmu_cti_o,		//wishbone icmu���ݴ��䷽ʽѡ��
	output wire [1:0] icmu_bte_o,		//wishbone icmu��ַ����Burst�µĵ�ַ������ʽѡ��
	output wire [3:0] icmu_sel_o,		//wishbone icmu�ֽ�ѡ��
	output wire icmu_we_o,				//wishbone icmuдʹ��
	input wire [31:0] icmu_data_i,		//wishbone icmu��������
	output wire [31:0] icmu_data_o,		//wishbone icmu�������
	input wire icmu_ack_i,				//wishbone����ȷ���ź�
	input wire icmu_err_i,		//wishbone�����ź�
	//DCMU��wishbone���豸�ӿ�
	input wire dcmu_clk_i,	//wishbone dcmuʱ����
	output wire dcmu_cyc_o,	//wishbone dcmu���߲���ָʾ����1��ʾ�������߲���
	output wire dcmu_stb_o,	//wishbone dcmu���ݴ���ָʾ����1��ʾ�������ݴ�������
	output wire [31:2] dcmu_addr_o,		//wishbone dcmu�����ַ��
	output wire [2:0] dcmu_cti_o,		//wishbone dcmu���ݴ��䷽ʽѡ��
	output wire [1:0] dcmu_bte_o,		//wishbone dcmu��ַ����Burst�µĵ�ַ������ʽѡ��
	output wire [3:0] dcmu_sel_o,		//wishbone dcmu�ֽ�ѡ��
	output wire dcmu_we_o,				//wishbone dcmuдʹ��
	input wire [31:0] dcmu_data_i,		//wishbone dcmu��������
	output wire [31:0] dcmu_data_o,		//wishbone dcmu�������
	input wire dcmu_ack_i,				//wishbone����ȷ���ź�
	input wire dcmu_err_i,		//wishbone�����ź�
	//�ж�
	input wire [30:1] ir_map,  //�豸�ж��ź�
	output wire wd_rst  //���ſڸ�λ�жϣ����ܱ�ȫ�ָ�λ�ź���Ӱ��
);

endmodule
