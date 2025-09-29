onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Interface siganls}
add wave -noupdate /alu_tb/aluif/alu_op
add wave -noupdate /alu_tb/aluif/neg
add wave -noupdate /alu_tb/aluif/ovf
add wave -noupdate /alu_tb/aluif/zero
add wave -noupdate /alu_tb/aluif/pa
add wave -noupdate /alu_tb/aluif/pb
add wave -noupdate /alu_tb/aluif/presult
add wave -noupdate -divider {Internal Results Signals}
add wave -noupdate /alu_tb/DUT/sll_res
add wave -noupdate /alu_tb/DUT/srl_res
add wave -noupdate /alu_tb/DUT/sra_res
add wave -noupdate /alu_tb/DUT/add_res
add wave -noupdate /alu_tb/DUT/sub_res
add wave -noupdate /alu_tb/DUT/and_res
add wave -noupdate /alu_tb/DUT/or_res
add wave -noupdate /alu_tb/DUT/xor_res
add wave -noupdate /alu_tb/DUT/slt_res
add wave -noupdate /alu_tb/DUT/sltu_res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 155
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {14 ns}
