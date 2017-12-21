/*
	Top File
*/
module SystemOnFPGA_Sword (
	// board
	input wire clk_p,  // on board clock, 200MHz
	input wire clk_n,  // on board clock, 200MHz
	input wire rst_n,  // reset button
	input wire [15:0] switch,
	output wire [4:0] btn_x,
	input wire [4:0] btn_y,
	output wire led_clk,
	output wire led_pen,
	//output wire led_clr_n,
	output wire led_do,
	output wire seg_clk,
	output wire seg_pen,
	//output wire seg_clr_n,
	output wire seg_do,
	output wire tri_led0_r_n,
	output wire tri_led0_g_n,
	output wire tri_led0_b_n,
	output wire tri_led1_r_n,
	output wire tri_led1_g_n,
	output wire tri_led1_b_n,
	// SRAM
	output wire [2:0] sram_ce_n,
	output wire [2:0] sram_oe_n,
	output wire [2:0] sram_we_n,
	output wire [2:0] sram_lb_n,
	output wire [2:0] sram_ub_n,
	output wire [19:0] sram_addr,
	inout wire [47:0] sram_data,
	// flash
	output wire [1:0] flash_ce_n,
	output wire flash_rst_n,
	output wire flash_oe_n,
	output wire flash_we_n,
	input wire [1:0] flash_ready,
	output wire [23:0] flash_addr,
	//output wire [23:0] flash_addr,
	inout wire [31:0] flash_data,
	// VGA
	output wire vga_h_sync,
	output wire vga_v_sync,
	output wire [3:0] vga_red,
	output wire [3:0] vga_green,
	output wire [3:0] vga_blue,
	// keyboard
	input wire PS2A_CLK_OUT,
	input wire PS2A_DATA_OUT,
	// UART
	input wire uart_rx,
	output wire uart_tx,
	// Arduino Basic IO
	output wire buzzer,
	output wire [7:0] segment,
	output wire [3:0] an,
	output wire [7:0] a_led,
	// MicroSD SD Mode
	output wire sd_clk,
	inout sd_cmd,
	inout [3:0] sd_dat,
	output wire sd_rst,
	input sd_cd
	
	);
		
	// clock & reset
	wire clk_100m, clk_50m, clk_25m, clk_10m;
	wire clk_sys, clk_bus, clk_cpu, clk_mem, clk_dev;
	reg rst_all = 1;
	wire wd_rst;
	
	localparam
		CLK_FREQ_SYS = 100,
		CLK_FREQ_BUS = 25,
		CLK_FREQ_CPU = 25,
		CLK_FREQ_MEM = 50,
		CLK_FREQ_DEV = 50;
	assign
		clk_sys = clk_100m,
		clk_bus = clk_25m,
		clk_cpu = clk_25m,
		clk_mem = clk_50m,
		clk_dev = clk_50m,	// should be multiple of 10M, which UART needs
		clk_sd  = clk_10m;
	
	// wishbone master - VRAM
	wire vram_cyc_o;
	wire vram_stb_o;
	wire [31:2] vram_addr_o;
	wire [2:0] vram_cti_o;
	wire [1:0] vram_bte_o;
	wire [3:0] vram_sel_o;
	wire vram_we_o;
	wire [31:0] vram_data_i;
	wire [31:0] vram_data_o;
	wire vram_ack_i;
	
	// wishbone master - ICMU
	wire icmu_cyc_o;
	wire icmu_stb_o;
	wire [31:2] icmu_addr_o;
	wire [2:0] icmu_cti_o;
	wire [1:0] icmu_bte_o;
	wire [3:0] icmu_sel_o;
	wire icmu_we_o;
	wire [31:0] icmu_data_i;
	wire [31:0] icmu_data_o;
	wire icmu_ack_i;
	
	// wishbone master - DCMU
	wire dcmu_cyc_o;
	wire dcmu_stb_o;
	wire [31:2] dcmu_addr_o;
	wire [2:0] dcmu_cti_o;
	wire [1:0] dcmu_bte_o;
	wire [3:0] dcmu_sel_o;
	wire dcmu_we_o;
	wire [31:0] dcmu_data_i;
	wire [31:0] dcmu_data_o;
	wire dcmu_ack_i;
	
	// wishbone slave - RAM
	wire ram_cyc_i;
	wire ram_stb_i;
	wire [31:2] ram_addr_i;
	wire [2:0] ram_cti_i;
	wire [1:0] ram_bte_i;
	wire [3:0] ram_sel_i;
	wire ram_we_i;
	wire [31:0] ram_data_o;
	wire [31:0] ram_data_i;
	wire ram_ack_o;
	
	// wishbone slave - ROM
	wire rom_cyc_i;
	wire rom_stb_i;
	wire [31:2] rom_addr_i;
	wire [2:0] rom_cti_i;
	wire [1:0] rom_bte_i;
	wire [3:0] rom_sel_i;
	wire rom_we_i;
	wire [31:0] rom_data_o;
	wire [31:0] rom_data_i;
	wire rom_ack_o;
	
	
	// wishbone slave - I/O devices
	wire dev_cyc_i;
	wire dev_stb_i;
	wire [31:2] dev_addr_i;
	wire [2:0] dev_cti_i;
	wire [1:0] dev_bte_i;
	wire [3:0] dev_sel_i;
	wire dev_we_i;
	wire [31:0] dev_data_o;
	wire [31:0] dev_data_i;
	wire dev_ack_o;
	wire dev_err_o;
	
	// peripheral wishbone - VGA
	wire vga_cs_i;
	wire [7:2] vga_addr_i;
	wire [3:0] vga_sel_i;
	wire vga_we_i;
	wire [31:0] vga_data_o;
	wire [31:0] vga_data_i;
	wire vga_ack_o;
	
	// peripheral wishbone - board
	wire board_cs_i;
	wire [7:2] board_addr_i;
	wire [3:0] board_sel_i;
	wire board_we_i;
	wire [31:0] board_data_o;
	wire [31:0] board_data_i;
	wire board_ack_o;
	
	// peripheral wishbone - keyboard
	wire keyboard_cs_i;
	wire [7:2] keyboard_addr_i;
	wire [3:0] keyboard_sel_i;
	wire keyboard_we_i;
	wire [31:0] keyboard_data_o;
	wire [31:0] keyboard_data_i;
	wire keyboard_ack_o;
	
	// peripheral wishbone - SPI
	wire spi_cs_i;
	wire [7:2] spi_addr_i;
	wire [3:0] spi_sel_i;
	wire spi_we_i;
	wire [31:0] spi_data_o;
	wire [31:0] spi_data_i;
	wire spi_ack_o;
	
	// peripheral wishbone - SD
	wire sd_cs_i;
	wire [15:2] sd_addr_i;
	wire [3:0] sd_sel_i;
	wire sd_we_i;
	wire [31:0] sd_data_o;
	wire [31:0] sd_data_i;
	wire sd_ack_o;
	
	// peripheral wishbone - UART
	wire uart_cs_i;
	wire [7:2] uart_addr_i;
	wire [3:0] uart_sel_i;
	wire uart_we_i;
	wire [31:0] uart_data_o;
	wire [31:0] uart_data_i;
	wire uart_ack_o;
	
	// anti-jitter
	wire [15:0] switch_buf;
	wire [4:0] btn_y_buf;
	wire rst_buf;
	wire uart_rx_buf;
	/*
	anti_jitter #(.INIT_VALUE(0))
		AJ0 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[0]), .sig_o(switch_buf[0])),
		AJ1 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[1]), .sig_o(switch_buf[1])),
		AJ2 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[2]), .sig_o(switch_buf[2])),
		AJ3 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[3]), .sig_o(switch_buf[3])),
		AJ4 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[4]), .sig_o(switch_buf[4])),
		AJ5 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[5]), .sig_o(switch_buf[5])),
		AJ6 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[6]), .sig_o(switch_buf[6])),
		AJ7 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[7]), .sig_o(switch_buf[7])),
		AJ8 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[8]), .sig_o(switch_buf[8])),
		AJ9 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[9]), .sig_o(switch_buf[9])),
		AJ10 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[10]), .sig_o(switch_buf[10])),
		AJ11 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[11]), .sig_o(switch_buf[11])),
		AJ12 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[12]), .sig_o(switch_buf[12])),
		AJ13 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[13]), .sig_o(switch_buf[13])),
		AJ14 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[14]), .sig_o(switch_buf[14])),
		AJ15 (.clk(clk_cpu), .rst(1'b0), .sig_i(switch[15]), .sig_o(switch_buf[15])),
		AJY0 (.clk(clk_cpu), .rst(1'b0), .sig_i(btn_y[0]), .sig_o(btn_y_buf[0])),
		AJY1 (.clk(clk_cpu), .rst(1'b0), .sig_i(btn_y[1]), .sig_o(btn_y_buf[1])),
		AJY2 (.clk(clk_cpu), .rst(1'b0), .sig_i(btn_y[2]), .sig_o(btn_y_buf[2])),
		AJY3 (.clk(clk_cpu), .rst(1'b0), .sig_i(btn_y[3]), .sig_o(btn_y_buf[3])),
		AJY4 (.clk(clk_cpu), .rst(1'b0), .sig_i(btn_y[4]), .sig_o(btn_y_buf[4]));
	anti_jitter #(.INIT_VALUE(1))
		AJRST (.clk(clk_cpu), .rst(1'b0), .sig_i(~rst_n), .sig_o(rst_buf));
	anti_jitter #(.INIT_VALUE(1))
		AJUART (.clk(clk_dev), .rst(1'b0), .sig_i(uart_rx), .sig_o(uart_rx_buf));
	*/
	assign switch_buf = switch,
			btn_y_buf = btn_y,
			rst_buf = ~rst_n,
			uart_rx_buf = uart_rx;
	
	// clock generator
	wire locked;
	reg [15:0] rst_count = 16'hFFFF;
	
	clk_gen_sword CLK_GEN (
		.clk_pad_p(clk_p),
		.clk_pad_n(clk_n),
		.clk_100m(clk_100m),
		.clk_50m(clk_50m),
		.clk_25m(clk_25m),
		.clk_10m(clk_10m),
		.locked(locked)
		);
	
	always @(posedge clk_cpu) begin
		rst_all <= (rst_count != 0);
		rst_count <= {rst_count[14:0], (rst_buf | (~locked))};
	end
	
	// interrupts
	wire ir_board, ir_keyboard, ir_spi, ir_uart;
	wire [30:1] ir_orig, ir_map;
	
	assign
		ir_orig = {24'b0, ir_uart, ir_sd, ir_keyerr, ir_keyboard, ir_board, 1'b0};
	
	ir_conv #(
		.INTERRUPT_NUMBER(30)
		) IR_CONV (
		.clk(clk_dev),
		.rst(1'b0),
		.ir_i(ir_orig),
		.ir_o(ir_map)
		);
	
	// debug
	wire debug_en;
	wire debug_step;
	wire [6:0] debug_addr;
	wire [31:0] debug_data_cpu;
	reg [31:0] debug_data;
	wire debug_disp_en;
	wire [15:0] debug_disp_led;
	wire [31:0] debug_disp_data;
	wire [7:0] debug_disp_dot;
	
	always @(*) begin
		case (debug_addr[6:5])
			0: debug_data = debug_data_cpu;  // GPR
			1: debug_data = debug_data_cpu;  // DATAPATH
			2: debug_data = debug_data_cpu;  // CP0
			3: debug_data = debug_data_cpu;  // INST_DATA
		endcase
	end
	
	assign
		debug_en = switch_buf[7],
		debug_step = switch_buf[8],
		debug_addr = switch_buf[6:0],
		debug_disp_en = debug_en ^ switch_buf[9],
		debug_disp_led = {9'b0, vram_cyc_o, icmu_cyc_o, dcmu_cyc_o, 1'b0, dev_bte_i, dev_cti_i, dev_cyc_i},
		debug_disp_data = debug_data,
		debug_disp_dot = 8'h55;

	
	// wishbone bus
	wb_arb WB_ARB (
		.wb_clk(clk_bus),
		.wb_rst(rst_all | wd_rst),
		.m0_cyc_i(vram_cyc_o),
		.m0_stb_i(vram_stb_o),
		.m0_addr_i(vram_addr_o),
		.m0_cti_i(vram_cti_o),
		.m0_bte_i(vram_bte_o),
		.m0_sel_i(vram_sel_o),
		.m0_we_i(vram_we_o),
		.m0_data_o(vram_data_i),
		.m0_data_i(vram_data_o),
		.m0_ack_o(vram_ack_i),
		.m0_err_o(),
		.m1_cyc_i(icmu_cyc_o),
		.m1_stb_i(icmu_stb_o),
		.m1_addr_i(icmu_addr_o),
		.m1_cti_i(icmu_cti_o),
		.m1_bte_i(icmu_bte_o),
		.m1_sel_i(icmu_sel_o),
		.m1_we_i(icmu_we_o),
		.m1_data_o(icmu_data_i),
		.m1_data_i(icmu_data_o),
		.m1_ack_o(icmu_ack_i),
		.m1_err_o(),
		.m2_cyc_i(dcmu_cyc_o),
		.m2_stb_i(dcmu_stb_o),
		.m2_addr_i(dcmu_addr_o),
		.m2_cti_i(dcmu_cti_o),
		.m2_bte_i(dcmu_bte_o),
		.m2_sel_i(dcmu_sel_o),
		.m2_we_i(dcmu_we_o),
		.m2_data_o(dcmu_data_i),
		.m2_data_i(dcmu_data_o),
		.m2_ack_o(dcmu_ack_i),
		.m2_err_o(),
		.m3_cyc_i(1'b0),
		.m3_stb_i(1'b0),
		.m3_addr_i(30'b0),
		.m3_cti_i(3'b0),
		.m3_bte_i(2'b0),
		.m3_sel_i(4'b0),
		.m3_we_i(1'b0),
		.m3_data_o(),
		.m3_data_i(32'b0),
		.m3_ack_o(),
		.m3_err_o(),
		.s0_cyc_o(ram_cyc_i),
		.s0_stb_o(ram_stb_i),
		.s0_addr_o(ram_addr_i),
		.s0_cti_o(ram_cti_i),
		.s0_bte_o(ram_bte_i),
		.s0_sel_o(ram_sel_i),
		.s0_we_o(ram_we_i),
		.s0_data_i(ram_data_o),
		.s0_data_o(ram_data_i),
		.s0_ack_i(ram_ack_o),
		.s0_err_i(1'b0),
		.s1_cyc_o(rom_cyc_i),
		.s1_stb_o(rom_stb_i),
		.s1_addr_o(rom_addr_i),
		.s1_cti_o(rom_cti_i),
		.s1_bte_o(rom_bte_i),
		.s1_sel_o(rom_sel_i),
		.s1_we_o(rom_we_i),
		.s1_data_i(rom_data_o),
		.s1_data_o(rom_data_i),
		.s1_ack_i(rom_ack_o),
		.s1_err_i(1'b0),
		.s2_cyc_o(dev_cyc_i),
		.s2_stb_o(dev_stb_i),
		.s2_addr_o(dev_addr_i),
		.s2_cti_o(dev_cti_i),
		.s2_bte_o(dev_bte_i),
		.s2_sel_o(dev_sel_i),
		.s2_we_o(dev_we_i),
		.s2_data_i(dev_data_o),
		.s2_data_o(dev_data_i),
		.s2_ack_i(dev_ack_o),
		.s2_err_i(1'b0)
		);
	
	// CPU
	wb_mips WB_MIPS (
		.clk(clk_cpu),
		.rst(rst_all),
		.debug_en(debug_en),
		.debug_step(debug_step),
		.debug_addr(debug_addr),
		.debug_data(debug_data_cpu),
		.icmu_clk_i(clk_bus),
		.icmu_cyc_o(icmu_cyc_o),
		.icmu_stb_o(icmu_stb_o),
		.icmu_addr_o(icmu_addr_o),
		.icmu_cti_o(icmu_cti_o),
		.icmu_bte_o(icmu_bte_o),
		.icmu_sel_o(icmu_sel_o),
		.icmu_we_o(icmu_we_o),
		.icmu_data_i(icmu_data_i),
		.icmu_data_o(icmu_data_o),
		.icmu_ack_i(icmu_ack_i),
		.icmu_err_i(1'b0),
		.dcmu_clk_i(clk_bus),
		.dcmu_cyc_o(dcmu_cyc_o),
		.dcmu_stb_o(dcmu_stb_o),
		.dcmu_addr_o(dcmu_addr_o),
		.dcmu_cti_o(dcmu_cti_o),
		.dcmu_bte_o(dcmu_bte_o),
		.dcmu_sel_o(dcmu_sel_o),
		.dcmu_we_o(dcmu_we_o),
		.dcmu_data_i(dcmu_data_i),
		.dcmu_data_o(dcmu_data_o),
		.dcmu_ack_i(dcmu_ack_i),
		.dcmu_err_i(1'b0),
		.ir_map(ir_map),
		.wd_rst(wd_rst)
		);
	
	// memory (including RAM and ROM)
	wire [47:0] sram_din, sram_dout;
	assign
		sram_data = (sram_we_n[0] & sram_we_n[1] & sram_we_n[2]) ? {48{1'bz}} : sram_dout,
		sram_din = sram_data;
	
	wb_sram_sword #(
		.ADDR_BITS(22)
		) WB_SRAM (
		.clk(clk_mem),
		.rst(1'b0),
		.ram_busy(),
		.sram_ce_n(sram_ce_n),
		.sram_oe_n(sram_oe_n),
		.sram_we_n(sram_we_n),
		.sram_lb_n(sram_lb_n),
		.sram_ub_n(sram_ub_n),
		.sram_addr(sram_addr),
		.sram_din(sram_din),
		.sram_dout(sram_dout),
		.wbs_clk_i(clk_bus),
		.wbs_cyc_i(ram_cyc_i),
		.wbs_stb_i(ram_stb_i),
		.wbs_addr_i(ram_addr_i),
		.wbs_cti_i(ram_cti_i),
		.wbs_bte_i(ram_bte_i),
		.wbs_sel_i(ram_sel_i),
		.wbs_we_i(ram_we_i),
		.wbs_data_i(ram_data_i),
		.wbs_data_o(ram_data_o),
		.wbs_ack_o(ram_ack_o),
		.wbs_err_o()
		);
	
	wire [31:0] flash_din, flash_dout;
	assign
		flash_data = flash_we_n ? {32{1'bz}} : flash_dout,
		flash_din = flash_data;
	
	wb_flash_sword #(
		.ADDR_BITS(24)
		) WB_FLASH (
		.clk(clk_mem),
		.rst(1'b0),
		.flash_busy(),
		.flash_ce_n(flash_ce_n),
		.flash_rst_n(flash_rst_n),
		.flash_oe_n(flash_oe_n),
		.flash_we_n(flash_we_n),
		.flash_wp_n(),
		.flash_ready(flash_ready),
		.flash_addr({flash_addr}),
		.flash_din(flash_din),
		.flash_dout(flash_dout),
		.wbs_clk_i(clk_bus),
		.wbs_cyc_i(rom_cyc_i),
		.wbs_stb_i(rom_stb_i),
		.wbs_addr_i(rom_addr_i),
		.wbs_cti_i(rom_cti_i),
		.wbs_bte_i(rom_bte_i),
		.wbs_sel_i(rom_sel_i),
		.wbs_we_i(rom_we_i),
		.wbs_data_i(rom_data_i),
		.wbs_data_o(rom_data_o),
		.wbs_ack_o(rom_ack_o)
		);
	
	
	// I/O devices
	localparam
		DEV_TOTAL_ADDR_BITS = 16,
		DEV_SINGAL_ADDR_BITS = 8;
	
	wb_dev_adapter #(
		.TOTAL_ADDR_BITS(DEV_TOTAL_ADDR_BITS),
		.SINGLE_ADDR_BITS(DEV_SINGAL_ADDR_BITS)
		) WB_DEV_ADAPTER (
		.wbs_cyc_i(dev_cyc_i),
		.wbs_stb_i(dev_stb_i),
		.wbs_addr_i(dev_addr_i[15:2]),
		.wbs_sel_i(dev_sel_i),
		.wbs_we_i(dev_we_i),
		.wbs_data_i(dev_data_i),
		.wbs_data_o(dev_data_o),
		.wbs_ack_o(dev_ack_o),
		.wbs_err_o(),
		.d0_cs_o(),
		.d0_addr_o(),
		.d0_sel_o(),
		.d0_we_o(),
		.d0_data_o(),
		.d0_data_i(32'b0),
		.d0_ack_i(1'b0),
		.d1_cs_o(vga_cs_i),
		.d1_addr_o(vga_addr_i),
		.d1_sel_o(vga_sel_i),
		.d1_we_o(vga_we_i),
		.d1_data_o(vga_data_i),
		.d1_data_i(vga_data_o),
		.d1_ack_i(vga_ack_o),
		.d2_cs_o(board_cs_i),
		.d2_addr_o(board_addr_i),
		.d2_sel_o(board_sel_i),
		.d2_we_o(board_we_i),
		.d2_data_o(board_data_i),
		.d2_data_i(board_data_o),
		.d2_ack_i(board_ack_o),
		.d3_cs_o(keyboard_cs_i),
		.d3_addr_o(keyboard_addr_i),
		.d3_sel_o(keyboard_sel_i),
		.d3_we_o(keyboard_we_i),
		.d3_data_o(keyboard_data_i),
		.d3_data_i(keyboard_data_o),
		.d3_ack_i(keyboard_ack_o),
		.d4_cs_o(),
		.d4_addr_o(),
		.d4_sel_o(),
		.d4_we_o(),
		.d4_data_o(),
		.d4_data_i(32'b0),
		.d4_ack_i(1'b0),
		.d5_cs_o(),
		.d5_addr_o(),
		.d5_sel_o(),
		.d5_we_o(),
		.d5_data_o(),
		.d5_data_i(32'b0),
		.d5_ack_i(1'b0),
		.d6_cs_o(uart_cs_i),
		.d6_addr_o(uart_addr_i),
		.d6_sel_o(uart_sel_i),
		.d6_we_o(uart_we_i),
		.d6_data_o(uart_data_i),
		.d6_data_i(uart_data_o),
		.d6_ack_i(uart_ack_o),
		.d7_cs_o(),
		.d7_addr_o(),
		.d7_sel_o(),
		.d7_we_o(),
		.d7_data_o(),
		.d7_data_i(32'b0),
		.d7_ack_i(1'b0),
		.d8_cs_o(),
		.d8_addr_o(),
		.d8_sel_o(),
		.d8_we_o(),
		.d8_data_o(),
		.d8_data_i(32'b0),
		.d8_ack_i(1'b0),
		.d9_cs_o(),
		.d9_addr_o(),
		.d9_sel_o(),
		.d9_we_o(),
		.d9_data_o(),
		.d9_data_i(32'b0),
		.d9_ack_i(1'b0),
		.d1x_cs_o(sd_cs_i),
		.d1x_addr_o(sd_addr_i),
		.d1x_sel_o(sd_sel_i),
		.d1x_we_o(sd_we_i),
		.d1x_data_o(sd_data_i),
		.d1x_data_i(sd_data_o),
		.d1x_ack_i(sd_ack_o)
		);
	
	
	// VGA
	wb_vga_sword #(
		.DEV_ADDR_BITS(DEV_SINGAL_ADDR_BITS)
		) WB_VGA (
		.clk(clk_dev),
		.rst(1'b0),
		.clk_base(clk_25m),
		.h_sync(vga_h_sync),
		.v_sync(vga_v_sync),
		.r_color(vga_red),
		.g_color(vga_green),
		.b_color(vga_blue),
		.wbm_clk_i(clk_bus),
		.wbm_cyc_o(vram_cyc_o),
		.wbm_stb_o(vram_stb_o),
		.wbm_addr_o(vram_addr_o),
		.wbm_cti_o(vram_cti_o),
		.wbm_bte_o(vram_bte_o),
		.wbm_sel_o(vram_sel_o),
		.wbm_we_o(vram_we_o),
		.wbm_data_i(vram_data_i),
		.wbm_data_o(vram_data_o),
		.wbm_ack_i(vram_ack_i),
		.wbs_clk_i(clk_bus),
		.wbs_cs_i(vga_cs_i),
		.wbs_addr_i(vga_addr_i),
		.wbs_sel_i(vga_sel_i),
		.wbs_data_i(vga_data_i),
		.wbs_we_i(vga_we_i),
		.wbs_data_o(vga_data_o),
		.wbs_ack_o(vga_ack_o)
		);
	
	// board
	wb_board_sword #(
		.DEV_ADDR_BITS(DEV_SINGAL_ADDR_BITS)
		) WB_BOARD_SWORD (
		.clk(clk_dev),
		.rst(1'b0),
		.switch(switch_buf),
		.btn_x(btn_x),
		.btn_y(btn_y_buf),
		.led_clk(led_clk),
		.led_en(led_pen),
		.led_clr_n(),
		.led_do(led_do),
		.seg_clk(seg_clk),
		.seg_en(seg_pen),
		.seg_clr_n(),
		.seg_do(seg_do),
		.wbs_clk_i(clk_bus),
		.wbs_cs_i(board_cs_i),
		.wbs_addr_i(board_addr_i),
		.wbs_sel_i(board_sel_i),
		.wbs_data_i(board_data_i),
		.wbs_we_i(board_we_i),
		.wbs_data_o(board_data_o),
		.wbs_ack_o(board_ack_o),
		.debug_en(debug_disp_en),
		.debug_led(debug_disp_led),
		.debug_data(debug_disp_data),
		.debug_dot(debug_disp_dot),
		.interrupt(ir_board)
		);
	
	
	// keyboard
	wb_ps2 #(
		.DEV_ADDR_BITS(DEV_SINGAL_ADDR_BITS)
		) WB_PS2 (
		.clk(clk_dev),
		.rst(1'b0),
		.ps2_clk(PS2A_CLK_OUT),
		.ps2_dat(PS2A_DATA_OUT),
		.wbs_clk_i(clk_bus),
		.wbs_cs_i(keyboard_cs_i),
		.wbs_addr_i(keyboard_addr_i),
		.wbs_sel_i(keyboard_sel_i),
		.wbs_data_i(keyboard_data_i),
		.wbs_we_i(keyboard_we_i),
		.wbs_data_o(keyboard_data_o),
		.wbs_ack_o(keyboard_ack_o),
		.interrupt(ir_keyboard),
		.intererr(ir_keyerr)
		);
	
	
	// SPI
	wire [15:1] spi_sel_tmp;
	wire sd_dat_oe, sd_cmd_oe;
	wire [3:0] sd_dat_dat_i, sd_dat_out_o;
	wire sd_cmd_dat_i, sd_cmd_out_o;
	assign sd_dat = sd_dat_oe? sd_dat_out_o: 4'bzzzz,
	       sd_dat_dat_i = sd_dat;
	assign sd_cmd = sd_cmd_oe? sd_cmd_out_o: 1'bz,
		   sd_cmd_dat_i = sd_cmd;
	
	wb_sd WB_SD (
			.clk(clk_sd),
			.rst(1'b0),
			.sd_cmd_dat_i(sd_cmd_dat_i),
			.sd_cmd_out_o(sd_cmd_out_o),
			.sd_dat_dat_i(sd_dat_dat_i),
			.sd_dat_out_o(sd_dat_out_o)	,		
			.sd_cd(sd_cd),
			.sd_clk(sd_clk),
			.sd_rst(sd_rst),
			.sd_dat_oe(sd_dat_oe),
			.sd_cmd_oe(sd_cmd_oe),
			.wbs_clk_i(clk_bus),
			.wbs_cs_i(sd_cs_i),
			.wbs_addr_i(sd_addr_i),
			.wbs_sel_i(sd_sel_i),
			.wbs_data_i(sd_data_i),
			.wbs_we_i(sd_we_i),
			.wbs_data_o(sd_data_o),
			.wbs_ack_o(sd_ack_o),
			.interrupt(ir_sd)
		);
	
	// UART
	wb_uart #(
		.DEV_ADDR_BITS(DEV_SINGAL_ADDR_BITS)
		) WB_UART (
		.clk(clk_dev),
		.rst(1'b0),
		.rx(uart_rx_buf),
		.tx(uart_tx),
		.wbs_clk_i(clk_bus),
		.wbs_cs_i(uart_cs_i),
		.wbs_addr_i(uart_addr_i),
		.wbs_sel_i(uart_sel_i),
		.wbs_data_i(uart_data_i),
		.wbs_we_i(uart_we_i),
		.wbs_data_o(uart_data_o),
		.wbs_ack_o(uart_ack_o),
		.interrupt(ir_uart)
		);
	

		
	tri_led TRI_LED(
		.clk(clk_sys),
		.tri_led0_r_n(tri_led0_r_n),
		.tri_led0_g_n(tri_led0_g_n),
		.tri_led0_b_n(tri_led0_b_n),
		.tri_led1_r_n(tri_led1_r_n),
		.tri_led1_g_n(tri_led1_g_n),
		.tri_led1_b_n(tri_led1_b_n)
	);
	
	// Arduino Basic IO
	basic_io BASIC_IO(
		.clk(clk_sys),
		.digit_text(16'h1234),
		.digit_graph(32'b11000111101000111110001110000110),
		.dot(4'b1010),
		.mode(switch_buf[14]),
		.extend(switch_buf[15]),
		.a_led_in(8'haa),
		.a_led(a_led),
		.buzzer_in(1'b0),
		.buzzer(buzzer),
		.an(an),
		.segment(segment)
	);
	
	

endmodule
