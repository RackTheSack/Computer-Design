onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate -divider {CPU Side}
add wave -noupdate /system_tb/DUT/CPU/DP/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group Datapath /system_tb/DUT/CPU/DP/pipeline_control
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group Datapath /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -group {Datapath Local} /system_tb/DUT/CPU/DP/pc
add wave -noupdate -group {Datapath Local} /system_tb/DUT/CPU/DP/nxt_pc
add wave -noupdate -expand -group {Register File} -childformat {{{/system_tb/DUT/CPU/DP/reg_file/reg_file[10]} -radix hexadecimal} {{/system_tb/DUT/CPU/DP/reg_file/reg_file[4]} -radix hexadecimal}} -expand -subitemconfig {{/system_tb/DUT/CPU/DP/reg_file/reg_file[10]} {-height 16 -radix hexadecimal} {/system_tb/DUT/CPU/DP/reg_file/reg_file[4]} {-height 16 -radix hexadecimal}} /system_tb/DUT/CPU/DP/reg_file/reg_file
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group {Register File} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/wdat_mem
add wave -noupdate /system_tb/DUT/CPU/DP/wdat_wb
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/alu_op
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/neg
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/ovf
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/pa
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/pb
add wave -noupdate -expand -group ALU /system_tb/DUT/CPU/DP/aluif/presult
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/zero
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/ALUsrc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/jal
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/jalr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/auipc
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/branch
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dmemr
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/dmemw
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/alu_op
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/imemload
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/WEN
add wave -noupdate -expand -group {Control Unit} /system_tb/DUT/CPU/DP/cuif/memtoreg
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/imemaddr_if
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/imemload_if
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/imemaddr_id
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/imemload_id
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/ihit
add wave -noupdate -group {latch 1 (idif)} /system_tb/DUT/CPU/DP/latch1/ifid/flush
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imemaddr_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imemaddr_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imemload_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imemload_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/branch_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/branch_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/halt_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/halt_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/ALUsrc_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/ALUsrc_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/jal_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/jal_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/jalr_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/jalr_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/auipc_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/auipc_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/lui_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/lui_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/dmemr_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/dmemr_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/dmemw_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/dmemw_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/WEN_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/WEN_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/memtoreg_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/memtoreg_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/ihit
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/flush
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/alu_op_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/alu_op_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/rdat1_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/rdat1_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/rdat2_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/rdat2_exe
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imm_id
add wave -noupdate -group {latch 2 (idexe)} /system_tb/DUT/CPU/DP/latch2/idex/imm_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imemaddr_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imemaddr_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imemload_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imemload_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/branch_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/branch_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/halt_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/halt_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/jal_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/jal_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/jalr_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/jalr_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/auipc_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/auipc_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/lui_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/lui_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dmemr_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dmemr_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dmemw_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dmemw_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/WEN_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/WEN_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/memtoreg_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/memtoreg_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/ihit
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dhit
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/flush
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/rdat2_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/dmemstore
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imm_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/imm_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/presult_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/presult_mem
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/zero_exe
add wave -noupdate -group {latch 3 (exemem)} /system_tb/DUT/CPU/DP/latch3/exmem/zero_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/jal_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/jal_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/jalr_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/jalr_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/auipc_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/auipc_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/lui_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/lui_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/WEN_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/WEN_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/memtoreg_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/memtoreg_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/ihit
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/dhit
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/presult_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/presult_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/dmemload_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/dmemload_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imm_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imm_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imemaddr_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imemaddr_wb
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imemload_mem
add wave -noupdate -group {latch 4 (memwb)} /system_tb/DUT/CPU/DP/latch4/memwb/imemload_wb
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/PCsrc
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/jal_mem
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/jalr_mem
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/flush
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/dmemr_exe
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/imemload_exe
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/imemload_id
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/hazard_detected
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/IFID_write
add wave -noupdate -group {hazard unit} /system_tb/DUT/CPU/DP/huif/PC_write
add wave -noupdate -group {forwarding unit} /system_tb/DUT/CPU/DP/fuif/imemload_exe
add wave -noupdate -group {forwarding unit} /system_tb/DUT/CPU/DP/fuif/imemload_mem
add wave -noupdate -group {forwarding unit} /system_tb/DUT/CPU/DP/fuif/imemload_wb
add wave -noupdate -group {forwarding unit} /system_tb/DUT/CPU/DP/fuif/forward_a
add wave -noupdate -group {forwarding unit} /system_tb/DUT/CPU/DP/fuif/forward_b
add wave -noupdate -group {immediate generator} /system_tb/DUT/CPU/DP/igif/inst
add wave -noupdate -group {immediate generator} /system_tb/DUT/CPU/DP/igif/imm
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/imemload
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/iaddr
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/imemaddr
add wave -noupdate -group icache -expand /system_tb/DUT/CPU/CM/ICACHE/icache
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/nxt_icache
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/state
add wave -noupdate -group icache /system_tb/DUT/CPU/CM/ICACHE/nxt_state
add wave -noupdate -group icache /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/cache_add
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/en
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/selL
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/selR
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/dcache
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_dcache
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/lru
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_lru
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/counter
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_counter
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/hit_counter
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_hit_counter
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate -expand -group dcache /system_tb/DUT/CPU/CM/DCACHE/next_state
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dwait
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dREN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dWEN
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dload
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/dstore
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/iaddr
add wave -noupdate -expand -group cif /system_tb/DUT/CPU/CM/cif/daddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -expand -group dpif /system_tb/DUT/CPU/DP/dpif/dmemaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2553097 ps} 0}
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
WaveRestoreZoom {1619992 ps} {2746368 ps}
