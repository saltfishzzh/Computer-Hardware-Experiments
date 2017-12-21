`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:50:53 05/15/2017
// Design Name:   MDPath
// Module Name:   D:/ISE/OExp10-MDP/MDP_sim.v
// Project Name:  OExp10-MDP
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MDPath
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MDP_sim;

	// Inputs
	reg clk;
	reg reset;
	reg MIO_ready;
	reg IorD;
	reg IRWrite;
	reg [1:0] RegDst;
	reg RegWrite;
	reg [1:0] MemtoReg;
	reg ALUSrcA;
	reg [1:0] ALUSrcB;
	reg [1:0] PCSource;
	reg PCWrite;
	reg PCWriteCond;
	reg Branch;
	reg [2:0] ALU_operation;
	reg [31:0] data2CPU;

	// Outputs
	wire [31:0] PC_Current;
	wire [31:0] Inst;
	wire [31:0] data_out;
	wire [31:0] M_addr;
	wire zero;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	MDPath uut (
		.clk(clk), 
		.reset(reset), 
		.MIO_ready(MIO_ready), 
		.IorD(IorD), 
		.IRWrite(IRWrite), 
		.RegDst(RegDst), 
		.RegWrite(RegWrite), 
		.MemtoReg(MemtoReg), 
		.ALUSrcA(ALUSrcA), 
		.ALUSrcB(ALUSrcB), 
		.PCSource(PCSource), 
		.PCWrite(PCWrite), 
		.PCWriteCond(PCWriteCond), 
		.Branch(Branch), 
		.ALU_operation(ALU_operation), 
		.data2CPU(data2CPU), 
		.PC_Current(PC_Current), 
		.Inst(Inst), 
		.data_out(data_out), 
		.M_addr(M_addr), 
		.zero(zero), 
		.overflow(overflow)
	);
	initial begin
		`define signals {IorD,IRWrite,RegDst,RegWrite,MemtoReg,ALUSrcA,ALUSrcB,PCSource,PCWrite,PCWriteCond,Branch,ALU_operation}
		// Initialize Inputs
		reset = 1;
		MIO_ready = 1;
		data2CPU = 0;
		`signals = 18'd0;
		#40;
		reset = 0;
		// Add stimulus here
		//add r1,r0,r0; R-format
		data2CPU = 32'b000000_00000_00000_00001_00000_100000;
		`signals=18'b010000000100100010;#20;
		`signals=18'b000000001100000010;#20;
		`signals=18'b000000010000000010;#20;
		`signals=18'b000110000000000010;#20;
		
		//lw r2,0(r1);
		data2CPU = 32'b100011_00001_00010_00000_00000_000000;
		`signals=18'b010000000100100010;#20;
		`signals=18'b000000001100000010;#20;
		`signals=18'b000000011000000010;#20;
		data2CPU = 32'd1;//r1
		`signals=18'b100000000000000010;#20;
		`signals=18'b000010100000000010;#20;
		#20;
		//sw r2,0(r1);
		data2CPU = 32'b101011_00001_00010_00000_00000_000000;
		`signals=18'b010000000100100010;#20;
		`signals=18'b000000001100000010;#20;
		`signals=18'b000000011000000010;#20;
		`signals=18'b100000000000000010;#20;
		//beq r1,r2,2;
		data2CPU = 32'b000100_00010_00001_00000_00000_000010;
		`signals=18'b010000000100100010;#20;
		`signals=18'b000000001100000010;#20;
		`signals=18'b000000010001011110;#20;
		//j 32;
		data2CPU = 32'b000010_00000_00000_00000_00000_001000;
		`signals=18'b010000000100100010;#20;
		`signals=18'b000000001100000010;#20;
		`signals=18'b000000000010100010;#20;
	end
    always begin
		clk = 0;#10;
		clk = 1;#10;
	end
		
endmodule

