onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /armCPU_Pipelined_testbench/ClockDelay
add wave -noupdate /armCPU_Pipelined_testbench/clk
add wave -noupdate /armCPU_Pipelined_testbench/rst
add wave -noupdate -radix decimal /armCPU_Pipelined_testbench/dut/pc_add4
add wave -noupdate -radix decimal -childformat {{{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[31]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[30]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[29]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[28]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[27]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[26]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[25]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[24]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[23]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[22]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[21]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[20]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[19]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[18]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[17]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[16]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[15]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[14]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[13]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[12]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[11]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[10]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[9]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[8]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[7]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[6]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[5]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[4]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[3]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[2]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[1]} -radix decimal} {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[0]} -radix decimal}} -subitemconfig {{/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[31]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[30]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[29]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[28]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[27]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[26]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[25]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[24]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[23]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[22]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[21]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[20]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[19]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[18]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[17]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[16]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[15]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[14]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[13]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[12]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[11]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[10]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[9]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[8]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[7]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[6]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[5]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[4]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[3]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[2]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[1]} {-height 15 -radix decimal} {/armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers[0]} {-height 15 -radix decimal}} /armCPU_Pipelined_testbench/dut/id_stage/regfilerun/registers
add wave -noupdate -radix decimal /armCPU_Pipelined_testbench/dut/ALU_result
add wave -noupdate -group IF_Stage /armCPU_Pipelined_testbench/dut/if_Stage/pc_src
add wave -noupdate -group IF_Stage -radix decimal /armCPU_Pipelined_testbench/dut/if_Stage/ex_mem_out
add wave -noupdate -group IF_Stage -radix hexadecimal /armCPU_Pipelined_testbench/dut/if_Stage/instruction
add wave -noupdate -group IF_Stage -radix decimal /armCPU_Pipelined_testbench/dut/if_Stage/pc
add wave -noupdate -group IF_Stage -radix decimal /armCPU_Pipelined_testbench/dut/if_Stage/pc_next
add wave -noupdate -group IF_Stage -radix decimal /armCPU_Pipelined_testbench/dut/if_Stage/pc_add4
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/clk
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/rst
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/instruction_in
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/pc_in
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/instruction_out
add wave -noupdate -group IF_ID_register -radix decimal /armCPU_Pipelined_testbench/dut/if_id_register/pc_out
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/instruction_id
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/write_data
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/wr_reg_addr
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/reg_to_loc
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/reg_write
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/id_EX
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/id_MEM
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/id_WB
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/se_data
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/read_data_1
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/read_data_2
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/linked_or_Rd
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/read_reg_2
add wave -noupdate -group ID_Stage -radix decimal /armCPU_Pipelined_testbench/dut/id_stage/sel_se
add wave -noupdate -group ID_Stage /armCPU_Pipelined_testbench/dut/id_stage/linked_br
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {19990 ps} 0}
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
WaveRestoreZoom {0 ps} {307125 ps}
