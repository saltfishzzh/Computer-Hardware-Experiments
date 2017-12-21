/*
	MIPS ����5����ˮ�ߵ�CPU���ģ���������ͨ·������ģ����Э������
*/
module mips_core (
	input wire clk,  // ��ʱ��
	input wire rst,  // ͬ����λ�ź�
	// ����ģʽ
	input wire debug_en,  // ����ʹ��
	input wire debug_step,  // ���Բ�ʱ��
	input wire [6:0] debug_addr,  // ���Ե�ַ
	output wire [31:0] debug_data,  // ��������
	// MMU�ӿ�
	output wire user_mode,  // �ж��Ƿ�Ϊ�û�ģʽ��־
	output wire mmu_en,  // MMUʹ��
	output wire mmu_inv,  // ��ЧMMU�ź�
	output wire [31:PAGE_ADDR_BITS] pdb_addr,  // ҳĿ¼���ַ
	// ָ��ӿ�
	output wire inst_ren,  // ��ָ��ʹ��
	input wire inst_stall,  // ��IMMU/ICACHE��ȡ����ʱ���stall�ź�
	output wire [31:0] inst_addr,  // ָ���ַ
	input wire [31:0] inst_data,  // ָ������
	input wire inst_unalign,  // ָ��δ�����쳣
	input wire inst_bus_err,  // ָ�����߶��쳣
	input wire inst_page_fault,  // ָ��ҳ�쳣
	input wire inst_unauth_user,  // �û�ģʽ��δ��Ȩָ���쳣
	input wire inst_unauth_exec,  // δ��Ȩָ��ִ���쳣
	output wire ic_lock,  // ָ������źţ���ֹ���η���ͬ������
	output wire ic_inv,  // ��Чָ����ź�
	// �ڴ�ӿ�
	output wire mem_ren,  // �ڴ��ʹ��
	output wire mem_wen,  // �ڴ�дʹ��
	input wire mem_stall,  // ��DMMU/DCACHEȡ����ʱ���stall�ź�
	output wire [1:0] mem_type,  // �ڴ�������ͣ��֣����֣��ֽڣ�
	output wire mem_ext,  // �Ƿ�Ϊ������չ
	output wire [31:0] mem_addr,  // �ڴ��ַ
	output wire [31:0] mem_dout,  // д���ڴ�����
	input wire [31:0] mem_din,  // �ڴ��������
	input wire mem_unalign,  // �ڴ�δ�����쳣
	input wire mem_bus_err,  // �ڴ����߶��쳣
	input wire mem_page_fault,  // �ڴ�ҳ�쳣
	input wire mem_unauth_user,  // �û�ģʽ��δ��Ȩ�ڴ��쳣
	input wire mem_unauth_write,  // δ��Ȩָ��д�쳣
	output wire dc_lock,  // ���ݻ���������ֹ���η���ͬ������
	output wire dc_inv,  // ��Ч���ݻ����ź�
	// �жϽӿ�
	input wire [30:1] ir_map,  // �豸�ж��ź�
	output wire wd_rst,  // ���ſڸ�λ�źţ�������ȫ�ָ�λ�ź�
	output wire exception  // �жϷ����ź�
);
	
	parameter
		PAGE_ADDR_BITS = 12;  // һ���ڴ�ҳ����
		
endmodule
