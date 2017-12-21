onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib cmd_ram_opt

do {wave.do}

view wave
view structure
view signals

do {cmd_ram.udo}

run -all

quit -force
