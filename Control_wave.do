onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Control_testbench/ClockDelay
add wave -noupdate /Control_testbench/clk
add wave -noupdate /Control_testbench/rst
add wave -noupdate /Control_testbench/instruction
add wave -noupdate /Control_testbench/sel_se
add wave -noupdate /Control_testbench/EX
add wave -noupdate /Control_testbench/MEM
add wave -noupdate /Control_testbench/WB
add wave -noupdate /Control_testbench/linked_br
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {112 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {3150 ps}
