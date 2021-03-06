# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xq7k325trf676-2L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.xpr} [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files {{C:/Users/Jerry Chang/Desktop/summer2017/Project/textmode.coe}}
add_files {{C:/Users/Jerry Chang/Desktop/summer2017/Project/vram.coe}}
add_files {{C:/Users/Jerry Chang/Desktop/summer2017/Project/cmd_ram.coe}}
add_files {{C:/Users/Jerry Chang/Desktop/textmode.coe}}
add_files -quiet {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/RAM_B/RAM_B.dcp}}
set_property used_in_implementation false [get_files {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/RAM_B/RAM_B.dcp}}]
add_files -quiet {{c:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/char_ram/char_ram.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/char_ram/char_ram.dcp}}]
add_files -quiet {{c:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/cmd_ram/cmd_ram.dcp}}
set_property used_in_implementation false [get_files {{c:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/ip/cmd_ram/cmd_ram.dcp}}]
read_verilog -library xil_defaultlib {
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MC14495_ZJU.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/REG32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX4T1_5.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/ALU_v.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/regs.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Ext_32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX4T1_32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX2T1_32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MDPath.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/SSeg_map.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX8T1_8.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/LEDP2S_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/P2S_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/HexTo8SEG.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MCtrl.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX2T1_64.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MUX8T1_32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/font_table.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MIO_BUS.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Multi_8CH32.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/clk_diff.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/SAnti_jitter_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/clk_div.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/SEnter_2_32_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/MCPU.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Seg7_Dev_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Counter_3_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/VGA.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/GPIO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Display.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/PIO_IO.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/PS2.v}
  {C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/top.v}
}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/P2S.ngc}}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/LEDP2S.ngc}}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/PIO.ngc}}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/SEnter_2_32.ngc}}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/Seg7_Dev.ngc}}
read_edif {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/sources_1/imports/src/SAnti_jitter.ngc}}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/constrs_1/imports/sources_1/contraints.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Jerry Chang/Desktop/summer2017/Project/Summer_Project/summer_project.srcs/constrs_1/imports/sources_1/contraints.xdc}}]


synth_design -top top -part xq7k325trf676-2L


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
