###############################################################################
##$Date: 2009/11/11 05:22:01 $
##$Revision: 1.1 $
###############################################################################
## wave_mti.do
###############################################################################
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {FRAME CHECK MODULE tile0_frame_check0 }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check0/begin_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check0/track_data_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check0/data_error_detected_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check0/start_of_packet_detected_r
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/gtxf_top_i/tile0_frame_check0/RX_DATA
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/gtxf_top_i/tile0_frame_check0/ERROR_COUNT
add wave -noupdate -divider {FRAME CHECK MODULE tile0_frame_check1 }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check1/begin_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check1/track_data_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check1/data_error_detected_r
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/tile0_frame_check1/start_of_packet_detected_r
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/gtxf_top_i/tile0_frame_check1/RX_DATA
add wave -noupdate -format Logic -radix hexadecimal /DEMO_TB/gtxf_top_i/tile0_frame_check1/ERROR_COUNT
add wave -noupdate -divider {TILE0_GTXF }
add wave -noupdate -divider {Receive Ports - Comma Detection and Alignment }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEISALIGNED0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEISALIGNED1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEREALIGN0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEREALIGN1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXCOMMADET0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXCOMMADET1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENMCOMMAALIGN0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENMCOMMAALIGN1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENPCOMMAALIGN0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENPCOMMAALIGN1_IN
add wave -noupdate -divider {Receive Ports - RX Data Path interface }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXDATA0_OUT
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXDATA1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRECCLK0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRECCLK1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRESET0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRESET1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK20_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK21_IN
add wave -noupdate -divider {Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXN0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXN1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXP0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXP1_IN
add wave -noupdate -divider {Shared Ports - Tile and PLL Ports }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/CLKIN_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/GTXRESET_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/PLLLKDET_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/REFCLKOUT_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RESETDONE0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RESETDONE1_OUT
add wave -noupdate -divider {Transmit Ports - TX Data Path interface }
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXDATA0_IN
add wave -noupdate -format Literal -radix hexadecimal /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXDATA1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXOUTCLK0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXOUTCLK1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK0_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK1_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK20_IN
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK21_IN
add wave -noupdate -divider {Transmit Ports - TX Driver and OOB signalling }
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXN0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXN1_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXP0_OUT
add wave -noupdate -format Logic /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXP1_OUT

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
configure wave -namecolwidth 282
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
update
WaveRestoreZoom {0 ps} {5236 ps}

