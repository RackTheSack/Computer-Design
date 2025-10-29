onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/CLK
add wave -noupdate /control_unit_tb/cuif/zero
add wave -noupdate /control_unit_tb/cuif/halt
add wave -noupdate /control_unit_tb/cuif/ALUsrc
add wave -noupdate /control_unit_tb/cuif/PCsrc
add wave -noupdate /control_unit_tb/cuif/jal
add wave -noupdate /control_unit_tb/cuif/jalr
add wave -noupdate /control_unit_tb/cuif/auipc
add wave -noupdate /control_unit_tb/cuif/branch
add wave -noupdate /control_unit_tb/cuif/alu_op
add wave -noupdate /control_unit_tb/cuif/imemload
add wave -noupdate /control_unit_tb/cuif/presult
add wave -noupdate /control_unit_tb/cuif/dmemr
add wave -noupdate /control_unit_tb/cuif/dmemw
add wave -noupdate /control_unit_tb/PROG/test_case
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {62 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {116 ns}
