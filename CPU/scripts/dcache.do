onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate /dcache_tb/PROG/hit_counter
add wave -noupdate /dcache_tb/PROG/test_case
add wave -noupdate -expand -group dcache /dcache_tb/DUT/cache_add
add wave -noupdate -expand -group dcache /dcache_tb/DUT/en
add wave -noupdate -expand -group dcache /dcache_tb/DUT/selL
add wave -noupdate -expand -group dcache /dcache_tb/DUT/selR
add wave -noupdate -expand -group dcache -subitemconfig {{/dcache_tb/DUT/dcache[2]} -expand {/dcache_tb/DUT/dcache[2][1]} -expand} /dcache_tb/DUT/dcache
add wave -noupdate -expand -group dcache /dcache_tb/DUT/next_dcache
add wave -noupdate -expand -group dcache /dcache_tb/DUT/lru
add wave -noupdate -expand -group dcache /dcache_tb/DUT/next_lru
add wave -noupdate -expand -group dcache /dcache_tb/DUT/counter
add wave -noupdate -expand -group dcache /dcache_tb/DUT/next_counter
add wave -noupdate -expand -group dcache /dcache_tb/DUT/hit_counter
add wave -noupdate -expand -group dcache /dcache_tb/DUT/next_hit_counter
add wave -noupdate -expand -group dcache /dcache_tb/DUT/state
add wave -noupdate -expand -group dcache /dcache_tb/DUT/next_state
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/halt
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dhit
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dmemREN
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dmemWEN
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/flushed
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dmemload
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dmemstore
add wave -noupdate -expand -group {datapath cache interface} /dcache_tb/dpif/dmemaddr
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/dwait
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/dREN
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/dWEN
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/dload
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/dstore
add wave -noupdate -expand -group {cache interface} /dcache_tb/cif/daddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {64 ns} 0}
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
WaveRestoreZoom {0 ns} {247 ns}
