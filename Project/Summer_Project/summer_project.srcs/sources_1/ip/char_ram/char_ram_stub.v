// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Fri Sep 08 11:06:25 2017
// Host        : DESKTOP-N4M5H14 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/Jerry
//               Chang/Desktop/Summer_Project/summer_project.srcs/sources_1/ip/char_ram/char_ram_stub.v}
// Design      : char_ram
// Purpose     : Stub declaration of top-level module interface
// Device      : xq7k325trf676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module char_ram(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[12:0],dina[31:0],clkb,addrb[12:0],doutb[31:0]" */;
  input clka;
  input [0:0]wea;
  input [12:0]addra;
  input [31:0]dina;
  input clkb;
  input [12:0]addrb;
  output [31:0]doutb;
endmodule
