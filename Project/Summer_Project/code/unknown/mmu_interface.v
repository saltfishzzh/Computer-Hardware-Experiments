/*
	�ڴ����ԪMMU
*/
module mmu (
	input wire clk,  // ��ʱ��
	input wire rst,  // ͬ����λ�ź�
	input wire suspend,  // ǿ�ƹ���ǰ����
	// ��ַת���ӿ�
	input wire en_mmu,  // MMUʹ��
	output reg stall,  // ��MMUæʱstall�������
	input wire [31:12] pdb_addr,  // ҳĿ¼�����ַ
	input wire [31:12] logical,  // �߼���ַ
	output reg [31:12] physical,  // �����ַ
	output reg page_fault,  // ҳ�����
	output reg auth_user,  // �û���÷���Ȩ�ޱ�־
	output reg auth_exec,  // �û����ִ��Ȩ�ޱ�־
	output reg auth_write,  // �û����дȨ�ޱ�־
	output reg en_cache,  // ��ǰҳcacheʹ��
	// ҳ��Ϣץȡ�ӿ�
	output reg ren,  // ��ʹ��
	output reg [31:0] addr,  // ���ݵ�ַ
	input wire ack,  // ȷ���ź�
	input wire [31:0] data  // ����
);

endmodule
