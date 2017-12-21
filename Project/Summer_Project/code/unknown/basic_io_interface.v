/*
	��ɫSword_Basic_io��ʾ������ģ�飬����
	�ı�ģʽ�µ���ʾ����չ��ʾ
	extend = 0			extend = 1
	0					G
	1					h
	2					H
	3					L
	4					n
	5					o
	6					P
	7					q
	8					r
	9					t
	A					U
	b					y
	C					-
	d					=
	E					S
	F					J
*/
module basic_io(
	input wire clk,	//ʱ��
	input wire [15:0] digit_text,	//�ı���ʾ��������
	input wire [31:0] digit_graph,	//ͼ����ʾ��������
	input wire [3:0] dot,	//С����
	input wire mode,	//��ʾģʽ��0Ϊ�ı�ģʽ��1Ϊͼ��ģʽ
	input wire extend,	//��չλ��ʾ
	input wire [7:0] a_led_in,	//8��LED����ʾ��������
	output reg [7:0] a_led,	//LED�����
	input wire buzzer_in,	//��������������
	output reg buzzer,	//���������
	output reg [3:0] an, //4������ܵ�λѡ���
	output reg [7:0] segment	//�����������ʾ����
);

endmodule

