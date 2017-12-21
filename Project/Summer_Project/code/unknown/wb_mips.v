/*
	MIPS五级流水线与wishbone总线接口
*/
module wb_mips (
	input wire clk,  // 主频时钟，频率要大于或等于wishbine时钟
	input wire rst,  // 同步复位信号
	// CPU调试模式
	input wire debug_en,  // 调试使能
	input wire debug_step,  // 调试步长时钟
	input wire [6:0] debug_addr,  // 调试显示地址
	output wire [31:0] debug_data,  // 调试显示数据
	//ICMU的wishbone主设备接口
	input wire icmu_clk_i,	//wishbone icmu时钟线
	output wire icmu_cyc_o,	//wishbone icmu总线操作指示，置1表示发起总线操作
	output wire icmu_stb_o,	//wishbone icmu数据传输指示，置1表示发起数据传输请求
	output wire [31:2] icmu_addr_o,		//wishbone icmu输出地址线
	output wire [2:0] icmu_cti_o,		//wishbone icmu数据传输方式选择
	output wire [1:0] icmu_bte_o,		//wishbone icmu地址递增Burst下的地址递增方式选择
	output wire [3:0] icmu_sel_o,		//wishbone icmu字节选择
	output wire icmu_we_o,				//wishbone icmu写使能
	input wire [31:0] icmu_data_i,		//wishbone icmu输入数据
	output wire [31:0] icmu_data_o,		//wishbone icmu输出数据
	input wire icmu_ack_i,				//wishbone数据确认信号
	input wire icmu_err_i,		//wishbone错误信号
	//DCMU的wishbone主设备接口
	input wire dcmu_clk_i,	//wishbone dcmu时钟线
	output wire dcmu_cyc_o,	//wishbone dcmu总线操作指示，置1表示发起总线操作
	output wire dcmu_stb_o,	//wishbone dcmu数据传输指示，置1表示发起数据传输请求
	output wire [31:2] dcmu_addr_o,		//wishbone dcmu输出地址线
	output wire [2:0] dcmu_cti_o,		//wishbone dcmu数据传输方式选择
	output wire [1:0] dcmu_bte_o,		//wishbone dcmu地址递增Burst下的地址递增方式选择
	output wire [3:0] dcmu_sel_o,		//wishbone dcmu字节选择
	output wire dcmu_we_o,				//wishbone dcmu写使能
	input wire [31:0] dcmu_data_i,		//wishbone dcmu输入数据
	output wire [31:0] dcmu_data_o,		//wishbone dcmu输出数据
	input wire dcmu_ack_i,				//wishbone数据确认信号
	input wire dcmu_err_i,		//wishbone错误信号
	//中断
	input wire [30:1] ir_map,  //设备中断信号
	output wire wd_rst  //看门口复位中断，不能被全局复位信号所影响
);

	localparam
		PAGE_ADDR_BITS = 12;  // address length inside one memory page

	// MMU相关信号
	wire user_mode;
	wire mmu_en, mmu_inv;
	wire [31:PAGE_ADDR_BITS] pdb_addr;

	// 指令信号
	wire inst_ren, inst_suspend;
	wire immu_stall, icache_stall, inst_stall;
	wire [31:PAGE_ADDR_BITS] inst_addr_logical, inst_addr_physical;
	wire [PAGE_ADDR_BITS-1:0] inst_addr_page;
	wire [31:0] inst_data;
	wire inst_unalign, inst_bus_err, inst_page_fault;
	wire inst_unauth_user, inst_unauth_exec;
	wire ic_en, ic_lock;
	wire ic_inv;
	wire itlb_ren;
	wire [31:0] itlb_addr;
	reg itlb_ack;
	reg [31:0] itlb_data;

	// 内存信号
	wire mem_ren, mem_wen, mem_suspend;
	wire dmmu_stall, dcache_stall, mem_stall;
	wire [1:0] mem_type;
	wire mem_ext;
	wire [31:PAGE_ADDR_BITS] mem_addr_logical, mem_addr_physical;
	wire [PAGE_ADDR_BITS-1:0] mem_addr_page;
	reg [31:0] mem_data_r;
	wire [31:0] mem_data_w;
	wire mem_unalign, mem_bus_err, mem_page_fault;
	wire mem_unauth_user, mem_unauth_write;
	wire dc_en, dc_lock;
	wire dc_inv;
	wire dtlb_ren;
	wire [31:0] dtlb_addr;
	reg dtlb_ack;
	reg [31:0] dtlb_data;

	wire exception;
	wire inst_auth_user, inst_auth_exec;
	wire mem_auth_user, mem_auth_write;

	// mips core
	assign
		inst_stall = immu_stall | icache_stall,
		mem_stall = immu_stall | dmmu_stall | dcache_stall,
		inst_suspend = exception | immu_stall | inst_page_fault | inst_unauth_user | inst_unauth_exec,
		mem_suspend = exception | mem_page_fault | mem_unauth_user | mem_unauth_write;

	mips_core #(
		.PAGE_ADDR_BITS(PAGE_ADDR_BITS)
		) MIPS_CORE (
		.clk(clk),
		.rst(rst),
		.debug_en(debug_en),
		.debug_step(debug_step),
		.debug_addr(debug_addr),
		.debug_data(debug_data),
		.user_mode(user_mode),
		.mmu_en(mmu_en),
		.mmu_inv(mmu_inv),
		.pdb_addr(pdb_addr),
		.inst_ren(inst_ren),
		.inst_stall(inst_stall),
		.inst_addr({inst_addr_logical, inst_addr_page}),
		.inst_data(inst_data),
		.inst_unalign(inst_unalign),
		.inst_bus_err(inst_bus_err),
		.inst_page_fault(inst_page_fault),
		.inst_unauth_user(inst_unauth_user),
		.inst_unauth_exec(inst_unauth_exec),
		.ic_lock(ic_lock),
		.ic_inv(ic_inv),
		.mem_ren(mem_ren),
		.mem_wen(mem_wen),
		.mem_stall(mem_stall),
		.mem_type(mem_type),
		.mem_ext(mem_ext),
		.mem_addr({mem_addr_logical, mem_addr_page}),
		.mem_dout(mem_data_w),
		.mem_din(mem_data_r),
		.mem_unalign(mem_unalign),
		.mem_bus_err(mem_bus_err),
		.mem_page_fault(mem_page_fault),
		.mem_unauth_user(mem_unauth_user),
		.mem_unauth_write(mem_unauth_write),
		.dc_lock(dc_lock),
		.dc_inv(dc_inv),
		.ir_map(ir_map),
		.wd_rst(wd_rst),
		.exception(exception)
		);

	// 指令MMU
	mmu IMMU (
		.clk(clk),
		.rst(rst | wd_rst | mmu_inv),
		.suspend(1'b0),
		.en_mmu(mmu_en & (inst_ren | ic_inv)),
		.stall(immu_stall),
		.pdb_addr(pdb_addr),
		.logical(inst_addr_logical),
		.physical(inst_addr_physical),
		.page_fault(inst_page_fault),
		.auth_user(inst_auth_user),
		.auth_exec(inst_auth_exec),
		.auth_write(),
		.en_cache(ic_en),
		.ren(itlb_ren),
		.addr(itlb_addr),
		.ack(itlb_ack),
		.data(itlb_data)
		);

	assign
		inst_unauth_user = inst_ren & ~inst_auth_user & user_mode,
		inst_unauth_exec = inst_ren & ~inst_auth_exec;

	// 数据MMU
	mmu DMMU (
		.clk(clk),
		.rst(rst | wd_rst | mmu_inv),
		.suspend(1'b0),
		.en_mmu(mmu_en & (mem_ren | mem_wen | dc_inv)),
		.stall(dmmu_stall),
		.pdb_addr(pdb_addr),
		.logical(mem_addr_logical),
		.physical(mem_addr_physical),
		.page_fault(mem_page_fault),
		.auth_user(mem_auth_user),
		.auth_exec(),
		.auth_write(mem_auth_write),
		.en_cache(dc_en),
		.ren(dtlb_ren),
		.addr(dtlb_addr),
		.ack(dtlb_ack),
		.data(dtlb_data)
		);

	assign
		mem_unauth_user = (mem_ren | mem_wen) & ~mem_auth_user & user_mode,
		mem_unauth_write = mem_wen & ~mem_auth_write;


	// 指令缓存
	wb_cmu ICMU (
		.clk(clk),
		.rst(rst | wd_rst),
		.suspend(inst_suspend),
		.en_cache(ic_en),
		.addr_rw({inst_addr_physical, inst_addr_page}),
		.addr_type(2'h0),
		.sign_ext(1'b0),
		.en_r(inst_ren),
		.data_r(inst_data),
		.en_w(1'b0),
		.data_w(0),
		.en_f(ic_inv),
		.lock(ic_lock),
		.stall(icache_stall),
		.align_err(inst_unalign),
		.bus_err(inst_bus_err),
		.wbm_clk_i(icmu_clk_i),
		.wbm_cyc_o(icmu_cyc_o),
		.wbm_stb_o(icmu_stb_o),
		.wbm_addr_o(icmu_addr_o),
		.wbm_cti_o(icmu_cti_o),
		.wbm_bte_o(icmu_bte_o),
		.wbm_sel_o(icmu_sel_o),
		.wbm_we_o(icmu_we_o),
		.wbm_data_i(icmu_data_i),
		.wbm_data_o(icmu_data_o),
		.wbm_ack_i(icmu_ack_i),
		.wbm_err_i(icmu_err_i)
		);


	reg dcmu_en_cache;
	reg [31:0] dcmu_addr_rw;
	reg [1:0] dcmu_addr_type;
	reg dcmu_sign_ext;
	reg dcmu_en_r;
	wire [31:0] dcmu_data_r;
	reg dcmu_en_w;
	reg [31:0] dcmu_data_w;
	reg dcmu_en_f;
	reg dcmu_lock;

	always @(*) begin
		dcmu_en_cache = 0;
		dcmu_addr_rw = 0;
		dcmu_addr_type = 0;
		dcmu_sign_ext = 0;
		dcmu_en_r = 0;
		dcmu_en_w = 0;
		dcmu_data_w = 0;
		dcmu_en_f = 0;
		dcmu_lock = 0;
		itlb_ack = 0;
		itlb_data = 0;
		dtlb_ack = 0;
		dtlb_data = 0;
		mem_data_r = 0;
		if (immu_stall) begin
			dcmu_en_cache = 1;
			dcmu_addr_rw = itlb_addr;
			dcmu_addr_type = 2'h0;
			dcmu_en_r = itlb_ren;
			itlb_ack = itlb_ren & ~dcache_stall;
			itlb_data = dcmu_data_r;
		end
		else if (dmmu_stall) begin
			dcmu_en_cache = 1;
			dcmu_addr_rw = dtlb_addr;
			dcmu_addr_type = 2'h0;
			dcmu_en_r = dtlb_ren;
			dtlb_ack = dtlb_ren & ~dcache_stall;
			dtlb_data = dcmu_data_r;
		end
		else begin
			dcmu_en_cache = dc_en;
			dcmu_addr_rw = {mem_addr_physical, mem_addr_page};
			dcmu_addr_type = mem_type;
			dcmu_sign_ext = mem_ext;
			dcmu_en_r = mem_ren;
			dcmu_en_w = mem_wen;
			dcmu_data_w = mem_data_w;
			dcmu_en_f = dc_inv;
			dcmu_lock = dc_lock;
			mem_data_r = dcmu_data_r;
		end
	end


	// 数据缓存cache
	wb_cmu DCMU (
		.clk(clk),
		.rst(rst | wd_rst),
		.suspend(mem_suspend),
		.en_cache(dcmu_en_cache),
		.addr_rw(dcmu_addr_rw),
		.addr_type(dcmu_addr_type),
		.sign_ext(dcmu_sign_ext),
		.en_r(dcmu_en_r),
		.data_r(dcmu_data_r),
		.en_w(dcmu_en_w),
		.data_w(dcmu_data_w),
		.en_f(dcmu_en_f),
		.lock(dcmu_lock),
		.stall(dcache_stall),
		.align_err(mem_unalign),
		.bus_err(mem_bus_err),
		.wbm_clk_i(dcmu_clk_i),
		.wbm_cyc_o(dcmu_cyc_o),
		.wbm_stb_o(dcmu_stb_o),
		.wbm_addr_o(dcmu_addr_o),
		.wbm_cti_o(dcmu_cti_o),
		.wbm_bte_o(dcmu_bte_o),
		.wbm_sel_o(dcmu_sel_o),
		.wbm_we_o(dcmu_we_o),
		.wbm_data_i(dcmu_data_i),
		.wbm_data_o(dcmu_data_o),
		.wbm_ack_i(dcmu_ack_i),
		.wbm_err_i(dcmu_err_i)
		);


endmodule
