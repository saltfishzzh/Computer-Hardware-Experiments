/*
	VGA��ʾģ����wishbone���߽ӿ�
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
		DEV_ADDR_BITS = 8;  // IO�ռ��ַ����

	// �����źżĴ���
	reg [31:0] reg_mode = 0, reg_vram_base = 0, reg_cursor_pos = 0, reg_cursor_flash = 0;

	// VGA��������ź���
	wire vga_clk, vga_valid;
	wire [10:0] h_count_core;
	wire [10:0] v_count_core;
	wire [20:0] p_count_core;
	wire [10:0] h_disp_max;
	wire [10:0] v_disp_max;
	wire [20:0] p_disp_max;
	wire h_sync_core;
	wire v_sync_core;
	wire h_en_core;
	wire v_en_core;

	vga_core_sword VGA_CORE (
		.clk(clk),
		.rst(rst),
		.clk_base(clk_base),
		.vga_clk(vga_clk),
		.vga_valid(vga_valid),
		.h_count(h_count_core),
		.v_count(v_count_core),
		.p_count(p_count_core),
		.h_disp_max(h_disp_max),
		.v_disp_max(v_disp_max),
		.p_disp_max(p_disp_max),
		.h_sync(h_sync_core),
		.v_sync(v_sync_core),
		.h_en(h_en_core),
		.v_en(v_en_core)
		);

	wire text_en, graphic_en;

	// �ı�ģʽ�ź���
	wire h_sync_text;
	wire v_sync_text;
	wire r_text, g_text, b_text;
	wire wbm_cyc_text, wbm_stb_text;
	wire [31:2] wbm_addr_text;
	wire [2:0] wbm_cti_text;
	wire [1:0] wbm_bte_text;
	wire [3:0] wbm_sel_text;
	wire wbm_we_text;
	wire [31:0] wbm_data_text;

	assign
		text_en = (reg_mode[3:0] != 0) & (~reg_mode[31]) & vga_valid;

	wb_vga_text VGA_TEXT (
		.clk(clk),
		.rst(rst | ~text_en),
		.vga_clk(vga_clk),
		.h_count_core(h_count_core),
		.h_disp_max(h_disp_max),
		.v_count_core(v_count_core),
		.v_disp_max(v_disp_max),
		.h_sync_core(h_sync_core),
		.v_sync_core(v_sync_core),
		.h_en_core(h_en_core),
		.v_en_core(v_en_core),
		.cursor_h_pos(reg_cursor_pos[8-1:0]),
		.cursor_v_pos(reg_cursor_pos[21:16]),
		.cursor_en(reg_mode[30]),
		.cursor_refresh(reg_cursor_flash[31]),
		.cursor_timer(reg_cursor_flash[15:0]),
		.vram_base(reg_vram_base[31:16]),
		.h_sync(h_sync_text),
		.v_sync(v_sync_text),
		.r(r_text),
		.g(g_text),
		.b(b_text),
		.wbm_clk_i(wbm_clk_i),
		.wbm_cyc_o(wbm_cyc_text),
		.wbm_stb_o(wbm_stb_text),
		.wbm_addr_o(wbm_addr_text),
		.wbm_cti_o(wbm_cti_text),
		.wbm_bte_o(wbm_bte_text),
		.wbm_sel_o(wbm_sel_text),
		.wbm_we_o(wbm_we_text),
		.wbm_data_i(wbm_data_i),
		.wbm_data_o(wbm_data_text),
		.wbm_ack_i(wbm_ack_i)
		);

	// ͼ��ģʽ

	wire h_sync_graphic;
	wire v_sync_graphic;
	wire [2:0] r_graphic;
	wire [2:0] g_graphic;
	wire [1:0] b_graphic;
	wire wbm_cyc_graphic, wbm_stb_graphic;
	wire [31:2] wbm_addr_graphic;
	wire [2:0] wbm_cti_graphic;
	wire [1:0] wbm_bte_graphic;
	wire [3:0] wbm_sel_graphic;
	wire wbm_we_graphic;
	wire [31:0] wbm_data_graphic;

	assign
		graphic_en = (reg_mode[3:0] != 0) & reg_mode[31] & vga_valid;

	wb_vga_graphic WB_VGA_GRAPHIC (
		.clk(clk),
		.rst(rst | ~graphic_en),
		.vga_clk(vga_clk),
		.h_count_core(h_count_core),
		.p_disp_max(p_disp_max),
		.h_sync_core(h_sync_core),
		.v_sync_core(v_sync_core),
		.h_en_core(h_en_core),
		.v_en_core(v_en_core),
		.vram_base(reg_vram_base[31:20]),
		.h_sync(h_sync_graphic),
		.v_sync(v_sync_graphic),
		.r(r_graphic),
		.g(g_graphic),
		.b(b_graphic),
		.wbm_clk_i(wbm_clk_i),
		.wbm_cyc_o(wbm_cyc_graphic),
		.wbm_stb_o(wbm_stb_graphic),
		.wbm_addr_o(wbm_addr_graphic),
		.wbm_cti_o(wbm_cti_graphic),
		.wbm_bte_o(wbm_bte_graphic),
		.wbm_sel_o(wbm_sel_graphic),
		.wbm_we_o(wbm_we_graphic),
		.wbm_data_i(wbm_data_i),
		.wbm_data_o(wbm_data_graphic),
		.wbm_ack_i(wbm_ack_i)
		);


	// wishbone����ģ��
	always @(posedge wbs_clk_i) begin
		wbs_data_o <= 0;
		wbs_ack_o <= 0;
		if (rst) begin
			reg_mode <= 0;
			reg_vram_base <= 0;
			reg_cursor_pos <= 0;
			reg_cursor_flash <= 0;
			wbs_data_o <= 0;
			wbs_ack_o <= 0;
		end
		else if (wbs_cs_i & ~wbs_ack_o) begin
			case (wbs_addr_i)
				0: begin
					wbs_data_o <= reg_mode;
					if (wbs_we_i) begin
						if (wbs_sel_i[3])
							reg_mode[31:24] <= wbs_data_i[31:24];
						if (wbs_sel_i[2])
							reg_mode[23:16] <= wbs_data_i[23:16];
						if (wbs_sel_i[1])
							reg_mode[15:8] <= wbs_data_i[15:8];
						if (wbs_sel_i[0])
							reg_mode[7:0] <= wbs_data_i[7:0];
					end
				end
				1: begin
					wbs_data_o <= reg_vram_base;
					if (wbs_we_i) begin
						if (wbs_sel_i[3])
							reg_vram_base[31:24] <= wbs_data_i[31:24];
						if (wbs_sel_i[2])
							reg_vram_base[23:16] <= wbs_data_i[23:16];
						if (wbs_sel_i[1])
							reg_vram_base[15:8] <= wbs_data_i[15:8];
						if (wbs_sel_i[0])
							reg_vram_base[7:0] <= wbs_data_i[7:0];
					end
				end
				2: begin
					wbs_data_o <= reg_cursor_pos;
					if (wbs_we_i) begin
						if (wbs_sel_i[3])
							reg_cursor_pos[31:24] <= wbs_data_i[31:24];
						if (wbs_sel_i[2])
							reg_cursor_pos[23:16] <= wbs_data_i[23:16];
						if (wbs_sel_i[1])
							reg_cursor_pos[15:8] <= wbs_data_i[15:8];
						if (wbs_sel_i[0])
							reg_cursor_pos[7:0] <= wbs_data_i[7:0];
					end
				end
				3: begin
					wbs_data_o <= reg_cursor_flash;
					if (wbs_we_i) begin
						if (wbs_sel_i[3])
							reg_cursor_flash[31:24] <= wbs_data_i[31:24];
						if (wbs_sel_i[2])
							reg_cursor_flash[23:16] <= wbs_data_i[23:16];
						if (wbs_sel_i[1])
							reg_cursor_flash[15:8] <= wbs_data_i[15:8];
						if (wbs_sel_i[0])
							reg_cursor_flash[7:0] <= wbs_data_i[7:0];
					end
				end
				default: begin
					wbs_data_o <= 0;
				end
			endcase
			wbs_ack_o <= 1;
		end
	end

	reg text_en_buf, graphic_en_buf;  // ʹ�û���
	always @(posedge wbs_clk_i) begin
		if (rst) begin
			text_en_buf <= 0;
			graphic_en_buf <= 0;
		end
		else begin
			text_en_buf <= text_en;
			graphic_en_buf <= graphic_en;
		end
	end

	always @(*) begin
		wbm_cyc_o = 0;
		wbm_stb_o = 0;
		wbm_addr_o = 0;
		wbm_cti_o = 0;
		wbm_bte_o = 0;
		wbm_sel_o = 0;
		wbm_we_o = 0;
		wbm_data_o = 0;
		if (text_en_buf) begin
			wbm_cyc_o = wbm_cyc_text;
			wbm_stb_o = wbm_stb_text;
			wbm_addr_o = wbm_addr_text;
			wbm_cti_o = wbm_cti_text;
			wbm_bte_o = wbm_bte_text;
			wbm_sel_o = wbm_sel_text;
			wbm_we_o = wbm_we_text;
			wbm_data_o = wbm_data_text;
		end
		else if (graphic_en_buf) begin
			wbm_cyc_o = wbm_cyc_graphic;
			wbm_stb_o = wbm_stb_graphic;
			wbm_addr_o = wbm_addr_graphic;
			wbm_cti_o = wbm_cti_graphic;
			wbm_bte_o = wbm_bte_graphic;
			wbm_sel_o = wbm_sel_graphic;
			wbm_we_o = wbm_we_graphic;
			wbm_data_o = wbm_data_graphic;
		end
	end

	// VGA���
	always @(*) begin
		h_sync = 0;
		v_sync = 0;
		r_color = 0;
		g_color = 0;
		b_color = 0;
		if (text_en) begin
			h_sync = h_sync_text;
			v_sync = v_sync_text;
			r_color = {4{r_text}};
			g_color = {4{g_text}};
			b_color = {4{b_text}};
		end
		else if (graphic_en_buf) begin
			h_sync = h_sync_graphic;
			v_sync = v_sync_graphic;
			r_color = {r_graphic[2:0], r_graphic[2]};
			g_color = {g_graphic[2:0], g_graphic[2]};
			b_color = {b_graphic[1:0], b_graphic[1:0]};
		end
	end

endmodule
