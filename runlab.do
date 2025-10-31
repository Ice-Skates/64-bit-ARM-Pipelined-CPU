# start fresh
vdel -all -lib work
vlib work

# 1) Compile the package
vlog -sv ./struct/structures.sv

# 2) Compile leaf modules (no cross‑depend on your pipeline)
vlog -sv ./regfile/*.sv
vlog -sv ./ALU/*.sv
vlog -sv ./armCPU/*.sv

# 3) Compile your pipeline‑stage & utility modules
vlog -sv \
     ./IF_Stage.sv            \
     ./IF_ID_reg.sv           \
     ./ID_Stage.sv            \
	 ./ID_EX_reg.sv			  \
     ./EX_Stage.sv            \
     ./EX_MEM_reg.sv          \
     ./MEM_Stage.sv           \
     ./MEM_WB_reg.sv          \
     ./WB_Stage.sv

# 4) Compile your memories & control logic
vlog -sv \
     ./instructmem.sv         \
     ./datamem.sv             \
     ./Hazard_Detection_Unit.sv \
     ./Forwarding_Unit.sv     \
     ./Control.sv             \
     ./Conditonal_Branch_Check.sv \
     ./ALU_ctrl.sv            \
     ./ProgramCounter.sv      \
     ./Sign_Extender.sv

# 5) Compile top‐level & testbench last
vlog -sv \
     ./armCPU_Pipelined.sv    \

# 6) Launch simulation
vsim -voptargs="+acc" -t 1ps -lib work armCPU_Pipelined_testbench 
do CPU_wave.do
run -all
