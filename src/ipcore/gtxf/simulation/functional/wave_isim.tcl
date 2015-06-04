###############################################################################
##$Date: 2010/03/03 07:21:19 $
##$Revision: 1.2 $
###############################################################################
## wave_isim.tcl
###############################################################################

scope /DEMO_TB/gtxf_top_i/tile0_frame_check0
ntrace select -n begin_r track_data_r data_error_detected_r start_of_packet_detected_r RX_DATA ERROR_COUNT
scope /DEMO_TB/gtxf_top_i/tile0_frame_check1
ntrace select -n begin_r track_data_r data_error_detected_r start_of_packet_detected_r RX_DATA ERROR_COUNT
wcfg new
divider add "Receive Ports - Comma Detection and Alignment"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEISALIGNED0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEISALIGNED1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEREALIGN0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXBYTEREALIGN1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXCOMMADET0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXCOMMADET1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENMCOMMAALIGN0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENMCOMMAALIGN1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENPCOMMAALIGN0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXENPCOMMAALIGN1_IN
divider add "Receive Ports - RX Data Path interface"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXDATA0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXDATA1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRECCLK0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRECCLK1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRESET0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXRESET1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK20_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXUSRCLK21_IN
divider add "Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXN0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXN1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXP0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RXP1_IN
divider add "Shared Ports - Tile and PLL Ports"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/CLKIN_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/GTXRESET_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/PLLLKDET_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/REFCLKOUT_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RESETDONE0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/RESETDONE1_OUT
divider add "Transmit Ports - TX Data Path interface"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXDATA0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXDATA1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXOUTCLK0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXOUTCLK1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK0_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK1_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK20_IN
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXUSRCLK21_IN
divider add "Transmit Ports - TX Driver and OOB signalling"
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXN0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXN1_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXP0_OUT
wave add /DEMO_TB/gtxf_top_i/gtxf_i/tile0_gtxf_i/TXP1_OUT

ntrace start
run 50us
quit

