`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:17:43 05/24/2017 
// Design Name: 
// Module Name:    ctrl 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ctrl(input clk,
				input reset,
				input [31:0]Inst_in,
				input zero,
				input overflow,
				input MIO_ready,
				
				output reg MemRead,
				output reg MemWrite,
				output reg[2:0]ALU_operation,
				output [4:0]state_out,
				output reg CPU_MIO,
				output reg IorD,
				output reg IRWrite,
				output reg [1:0]RegDst,
				output reg RegWrite,
				output reg [1:0]MemtoReg,
				output reg ALUSrcA,
				output reg [1:0]ALUSrcB,
				output reg [1:0]PCSource,
				output reg PCWrite,
				output reg PCWriteCond,
				output reg signsignal,
				output reg Branch
    );
	
/*reg [4:0] state;


parameter IF = 5'b00000, ID=5'b00001, EX_R= 5'b00010, EX_Mem=5'b00011, EX_I= 5'b00100,
			 Lui_WB=5'b00101, EX_beq=5'b00110, EX_bne= 5'b00111, EX_jr= 5'b01000, EX_JAL=5'b01001,
			 Exe_J = 5'b01010, MEM_RD=5'b01011, MEM_WD= 5'b01100,
			 WB_R= 5'b01101, WB_I=5'b01110, WB_LW=5'b01111, Error=11111;
parameter  AND=3'b000, OR=3'b001, ADD=3'b010, SUB=3'b110, NOR=3'b100, SLT=3'b111, XOR=3'b011, SRL=3'b101;

`define Datapath_signals{PCWrite, PCWriteCond, IorD, MemRead, MemWrite, IRWrite, MemtoReg, PCSource, ALUSrcB, ALUSrcA, RegWrite, RegDst, CPU_MIO}

parameter 	value0 = 20'h12821,	value1 = 20'h00060,
				value2 = 20'h00050,	value3 = 20'h06001,
				value4 = 20'h00208,	value5 = 20'h05001,
				value6 = 20'h00010,	value7 = 20'h0001a,
				value8 = 20'h08090,	value9 = 20'h10160,
				value10 = 20'h00050, value11 = 20'h00058,
				value12 = 20'h00468, value13 = 20'h08090,
				value14 = 20'h10010, value15 = 20'h1076c;
				
	assign state_out[4:0] = state[4:0];
	
	
	always @ (posedge clk or posedge reset)
		if  (reset==1) state <= IF;
		else
			case (state)
			IF:  if (MIO_ready) state <= ID;
				else  state <= IF;
			ID:  case (Inst_in[31:26])
					6'b000000: begin state <= EX_R; //R-type OP
											if(Inst_in[5:0] == 6'b001000) state <= EX_jr;
								  end
					6'b100011: state <= EX_Mem;  //Lw
					6'b001000: state <= EX_I;	 //addi
					6'b001100: state <= EX_I;   //andi
					6'b001101: state <= EX_I;   //ori
					6'b001110: state <= EX_I;   //xori
					6'b001010: state <= EX_I;   //slti
					6'b001111: state <= Lui_WB; //Lui
					6'b000100: state <= EX_beq; //Beq
					6'b000101: state <= EX_bne; //Bne
					6'b000010: state <= Exe_J;
					6'b000011: state <= EX_JAL;
					default : state <= Error;
					endcase
			EX_Mem: case (Inst_in[31:26])
						6'b100011: state <= MEM_RD;
						6'b101011: state <= MEM_WD;
						default: begin end
			endcase
			EX_R: begin state<= WB_R; end
			EX_I: begin state <= WB_I; end
			EX_beq: begin state <= IF; end
			EX_bne: begin state <= IF; end
			Exe_J: begin state <= IF; end
			EX_jr: begin state <= IF; end
			EX_JAL: begin state <= IF; end
			MEM_RD: begin
							if(MIO_ready) state <= WB_LW;
							else state <= MEM_WD;
						end
			MEM_WD: begin
							if (MIO_ready) state <= IF;
							else state <= MEM_WD;
						end
			Lui_WB: begin state <= IF; end
			WB_R: begin state <= IF; end
			WB_I: begin state <= IF; end
			WB_LW: begin state <= IF; end
			Error: state <= Error;
			default: state <= Error;
	endcase
	
	always@ *begin
		case(state)
			IF: begin `Datapath_signals = value0; ALU_operation = ADD; end
			ID: begin `Datapath_signals = value1; ALU_operation = ADD; end
			EX_Mem: begin `Datapath_signals = value2; ALU_operation = ADD; end
			EX_R: begin `Datapath_signals = value6;
					case(Inst_in[5:0])
						6'b100000: ALU_operation = ADD;
						6'b100010: ALU_operation = SUB;
						6'b100100: ALU_operation = AND;
						6'b100101: ALU_operation = OR;
						6'b100110: ALU_operation = XOR;
						6'b100111: ALU_operation = NOR;
						6'b101010: ALU_operation = SLT;
						6'b000010: ALU_operation = SRL;
					endcase
					end
			MEM_RD: begin `Datapath_signals = value3; ALU_operation = ADD; end
			WB_LW : begin `Datapath_signals = value4; ALU_operation = ADD; end
			MEM_WD: begin `Datapath_signals = value5; ALU_operation = ADD; end
			WB_R:	  begin `Datapath_signals = value7; ALU_operation = ADD; end
			EX_beq: begin `Datapath_signals = value8; ALU_operation = SUB; end
			Exe_J: begin `Datapath_signals = value9; ALU_operation = ADD; end
			EX_I:	  begin `Datapath_signals = value10;
						case(Inst_in[31:26])
						6'b001000: ALU_operation = ADD;	 //addi
						6'b001100: ALU_operation = AND;   //andi
						6'b001101: ALU_operation = OR;   //ori
						6'b001110: ALU_operation = XOR;   //xori
						6'b001010: ALU_operation = SLT;   //slti
						6'b001111: ALU_operation = SRL;   //lui
						default : ALU_operation = ADD;
						endcase
					  end
			WB_I: begin `Datapath_signals = value11; ALU_operation = ADD; end
			Lui_WB: begin `Datapath_signals = value12; ALU_operation = ADD; end
			EX_bne: begin `Datapath_signals = value13; ALU_operation = SUB; Branch = 0; end
			EX_jr: begin `Datapath_signals = value14; ALU_operation = ADD; end
			EX_JAL: begin `Datapath_signals = value15; ALU_operation = ADD; end
			default:begin `Datapath_signals = value0; ALU_operation = ADD; end
		endcase
	end*/
	
	reg [4:0] state;

assign state_out[4:0] = state[4:0];
//assign OP = Inst_in[31:26];

parameter 	IF = 5'b00000,
				ID=5'b00001,
				EX_R= 5'b00010,
				EX_Mem=5'b00011,
				EX_I= 5'b00100,
				Lui_WB=5'b00101,
				EX_beq=5'b00110,
				EX_bne= 5'b00111,
				EX_jr= 5'b01000,
				EX_JAL=5'b01001, 
				Exe_J = 5'b01010,
				MEM_RD=5'b01011,
				MEM_WD= 5'b01100,
				WB_R= 5'b01101,
				WB_I=5'b01110,
				WB_LW=5'b01111,
				Error=5'b11111;
`define Datapath_signals{PCWrite, PCWriteCond,IorD, MemRead, MemWrite,IRWrite, MemtoReg, PCSource, ALUSrcB, ALUSrcA, RegWrite, RegDst, CPU_MIO}
							  //	1				2			3			4		5			6			7 8		 9 10			11 12		 13		14			15 16		17  

parameter 	value0 = 17'h12821,
				value1 = 17'h00060,
				value2 = 17'h00050,
				value3 = 17'h06001,
				value4 = 17'h00208,
				value5 = 17'h05001,
				value6 = 17'h00010,
				value7 = 17'h0001A,
				value8 = 17'h08090,
				value9 = 17'h10160,
				valueA = 17'h00050,
				valueB = 17'h00058,
				valueC = 17'h00468,
				valueD = 17'h08090,
				valueE = 17'h10010,
				valueF = 17'h1076C;
				
				
parameter 	AND=3'b000,
				OR=3'b001,
				ADD=3'b010,
				SUB=3'b110,
				NOR=3'b100,
				SLT=3'b111,
				XOR=3'b011,
				SRL=3'b101;


always @ (posedge clk or posedge reset) 
	if (reset==1) state <= IF;
	else case (state)
		IF: if(MIO_ready) state <= ID;
				else state <= IF;
		ID: case (Inst_in[31:26])
		
				6'b000000: begin state <= EX_R; //R-type OP 
								if (Inst_in[5:0] == 6'b001000) state <= EX_jr;
								end
				6'b100011: state <= EX_Mem; //Lw
				
				6'b001000: state <= EX_I; //addi
				6'b001100: state <= EX_I; //andi
				6'b001101: state <= EX_I; //ori
				6'b001110: state <= EX_I; //xori
				6'b001111: state <= Lui_WB; //lui
		      6'b001010: state <= EX_I; //slti
				6'b101011: state <= EX_Mem; //Sw
				
				6'b000010: state <= Exe_J; //J
				6'b000011: state <= EX_JAL; //Jal
				6'b000100: state <= EX_beq; //Beq
				6'b000101: state <= EX_bne; //Bne
				default: state <= Error;
			endcase
		EX_Mem: case (Inst_in[31:26])
				6'b100011: state <= MEM_RD;
				6'b101011: state <= MEM_WD;
				default: begin end
			endcase
		EX_R: begin state <= WB_R; end
		EX_I: begin state <= WB_I; end
		EX_beq: begin state <= IF; end
		EX_bne: begin state <= IF; end
		Exe_J: begin state <= IF; end
		EX_jr: begin state <= IF; end
		EX_JAL: begin state <= IF; end
		MEM_RD: begin
					if (MIO_ready) state <= WB_LW;
					else state <= MEM_WD;
				end
		MEM_WD: begin
					if (MIO_ready) state <= IF;
					else state <= MEM_WD;
				end
		Lui_WB: begin state <= IF; end
		WB_R: begin state <= IF; end
		WB_I: begin state <= IF; end
		WB_LW: begin state <= IF; end
		Error: state <= Error;
		default: state <= Error;
	endcase

	always@ * begin
	   signsignal = 1;
		case(state)//state
			IF: begin `Datapath_signals = value0; ALU_operation = ADD; end
			ID: begin `Datapath_signals = value1; ALU_operation = ADD; end
			EX_Mem: begin `Datapath_signals = value2; ALU_operation = ADD; end
			EX_R: begin `Datapath_signals = value6;
					case (Inst_in[5:0])
						6'b100000: ALU_operation= ADD;
						6'b100010: ALU_operation= SUB;
						6'b100100: ALU_operation= AND;
						6'b100101: ALU_operation= OR;
						6'b100111: ALU_operation= NOR;
						6'b101010: ALU_operation= SLT;
						6'b000010: ALU_operation= SRL; //shfit1bit right
						6'b000000: ALU_operation= XOR;
						default: ALU_operation= ADD;
					endcase
					end
			MEM_RD: begin `Datapath_signals = value3; ALU_operation = ADD; end
			WB_LW:  begin `Datapath_signals = value4; ALU_operation = ADD; end
			MEM_WD: begin `Datapath_signals = value5; ALU_operation = ADD; end
			
			WB_R: begin `Datapath_signals = value7; ALU_operation = ADD; end
			EX_beq: begin `Datapath_signals = value8; ALU_operation = SUB; Branch = 1; end
			Exe_J: begin `Datapath_signals = value9; ALU_operation = ADD; end
			EX_I: begin `Datapath_signals = valueA;  
					case (Inst_in[31:26])
						6'b001000: ALU_operation= ADD; //addi
						6'b001100:begin ALU_operation= AND; signsignal = 0;end //andi
						6'b001101:begin ALU_operation= OR; signsignal = 0; end//ori
						6'b001110:begin ALU_operation= XOR;signsignal = 0; end //xori
						6'b001111: ALU_operation= SRL; //lui
						6'b001010: ALU_operation= SLT; //slti
						default:ALU_operation= ADD;
					endcase
					end
			WB_I: begin `Datapath_signals = valueB; ALU_operation = ADD; end
			Lui_WB: begin `Datapath_signals = valueC; ALU_operation = ADD; end
			EX_bne: begin `Datapath_signals = valueD; ALU_operation = SUB; Branch = 0; end
			EX_jr: begin `Datapath_signals = valueE; ALU_operation = ADD; end
			EX_JAL: begin `Datapath_signals = valueF; ALU_operation = ADD; end
			default:begin `Datapath_signals = value0; ALU_operation = ADD; end
		endcase
	end
								
endmodule
