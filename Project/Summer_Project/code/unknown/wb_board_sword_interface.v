/*
	�弶��ʾģ����wishb���߽ӿ�
*/
module wb_board_sword (
	input wire clk,  // ��Ƶʱ�ӣ�Ƶ��Ҫ���ڻ����wishbineʱ��
	input wire rst,  // ͬ����λ�ź�
	// �弶�ӿ�
	input wire [15:0] switch,	//16���Ŀ��ؿ���
	output reg [4:0] btn_x,		//���м��̵�x����
	input wire [4:0] btn_y,		//���м��̵�y����
	output wire led_clk,		//led��ʱ��
	output wire led_en,			//led��ʹ���ź�
	output wire led_clr_n,		//led�Ƹ�λ�ź�
	output wire led_do,			//led�ƴ����ź�
	output wire seg_clk,		//seg�߶���ʱ��
	output wire seg_en,			//seg�߶���ʹ���ź�
	output wire seg_clr_n,		//seg�߶��븴λ�ź�
	output wire seg_do,			//seg�߶��봮������
	// wishbone���豸�ӿ�
	input wire wbs_clk_i,	//wishbone���豸ʱ����
	input wire wbs_cs_i,	//wishbone���豸Ƭѡ�ź���
	input wire [DEV_ADDR_BITS-1:2] wbs_addr_i,	//wishbone���豸��ַ�ź���
	input wire [3:0] wbs_sel_i,		//wishbone���豸ѡ���ź���
	input wire [31:0] wbs_data_i,	//wishbone���豸��������
	input wire wbs_we_i,	//wishbine���豸дʹ��
	output reg [31:0] wbs_data_o,	//wishbone���豸�������
	output reg wbs_ack_o,	//wishbine���豸Ӧ��
	// ����ģʽ��ʾ�ӿ�
	input wire debug_en,	//����ģʽʹ��
	input wire [15:0] debug_led,	//����ģʽled��ʾ����
	input wire [31:0] debug_data,	//����ģʽ�߶�����ʾ����
	input wire [15:0] debug_dot,	//����ģʽ�߶���С����
	// �ж�
	output reg interrupt	//�弶��ʾ�ж�
);

	parameter
		DEV_ADDR_BITS = 8;  // IO�ռ��豸��ַ����

endmodule
