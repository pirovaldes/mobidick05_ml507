-- Top-level design for ipbus demo
--
-- This version is for xc5vfx30t on Avnet V5FXT demo board
-- Uses the v5 hard ethernet MAC with GMII inteface to an external Gb PHY
--
-- If you want to do performance testing, you can configure this design to
-- have up to 16 seperate IPbus controllers sharing the same MAC block.
--
-- You must edit this file to set the IP and MAC addresses
--
-- Dave Newbold, 23/2/11

library UNISIM;
use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ipbus.ALL;
use work.mac_arbiter_decl.all;

entity top is port(
	--clk
	sys_clk_pin : in STD_LOGIC;
	leds: out STD_LOGIC_VECTOR(3 downto 0);
	gmii_tx_clk, gmii_tx_en, gmii_tx_er : out STD_LOGIC;
	gmii_txd : out STD_LOGIC_VECTOR(7 downto 0);
	gmii_rx_clk, gmii_rx_dv, gmii_rx_er: in STD_LOGIC;
	gmii_rxd : in STD_LOGIC_VECTOR(7 downto 0);
	phy_rstb : out STD_LOGIC;
	dip_switch: in std_logic_vector(3 downto 0);
	
	--glink!
	SFP_RX_P,SFP_RX_N : in std_logic;
	SFP_TX_P,SFP_TX_N : out std_logic;
	SMA_RX_P: in std_logic;
	SMA_RX_N: in std_logic
	
	);

end top;

architecture rtl of top is

--	constant N_IPB: integer := 8;
--	signal clk125, clk200, ipb_clk, locked, rst_125, rst_ipb, onehz: std_logic;
--	signal mac_tx_data, mac_rx_data: std_logic_vector(7 downto 0);
--	signal mac_tx_valid, mac_tx_last, mac_tx_error, mac_tx_ready, mac_rx_valid, mac_rx_last, mac_rx_error: std_logic;
--	signal ipb_master_out : ipb_wbus;
--	signal ipb_master_in : ipb_rbus;
--	signal mac_tx_data_bus: mac_arbiter_slv_array(N_IPB-1 downto 0);
--	signal mac_tx_valid_bus, mac_tx_last_bus, mac_tx_error_bus, mac_tx_ready_bus: mac_arbiter_sl_array(N_IPB-1 downto 0);
--	signal pkt_rx_bus, pkt_tx_bus, pkt_rx_led_bus, pkt_tx_led_bus: mac_arbiter_sl_array(N_IPB-1 downto 0);
--	signal sys_rst_array: std_logic_vector(N_IPB-1 downto 0);
--	signal pkt_rx_led, pkt_tx_led: std_logic;
--	
--
--	component GTXF 
--	generic
--	(
--		 -- Simulation attributes
--		 WRAPPER_SIM_GTXRESET_SPEEDUP    : integer   := 0; -- Set to 1 to speed up sim reset
--		 WRAPPER_SIM_PLL_PERDIV2         : bit_vector:= x"139" -- Set to the VCO Unit Interval time
--	);
--	port
--	(
--		 
--		 --_________________________________________________________________________
--		 --_________________________________________________________________________
--		 --TILE0  (Location)
--
--		 --------------- Receive Ports - Comma Detection and Alignment --------------
--		 TILE0_RXBYTEISALIGNED0_OUT              : out  std_logic;
--		 TILE0_RXBYTEISALIGNED1_OUT              : out  std_logic;
--		 TILE0_RXBYTEREALIGN0_OUT                : out  std_logic;
--		 TILE0_RXBYTEREALIGN1_OUT                : out  std_logic;
--		 TILE0_RXCOMMADET0_OUT                   : out  std_logic;
--		 TILE0_RXCOMMADET1_OUT                   : out  std_logic;
--		 TILE0_RXENMCOMMAALIGN0_IN               : in   std_logic;
--		 TILE0_RXENMCOMMAALIGN1_IN               : in   std_logic;
--		 TILE0_RXENPCOMMAALIGN0_IN               : in   std_logic;
--		 TILE0_RXENPCOMMAALIGN1_IN               : in   std_logic;
--		 ------------------- Receive Ports - RX Data Path interface -----------------
--		 TILE0_RXDATA0_OUT                       : out  std_logic_vector(19 downto 0);
--		 TILE0_RXDATA1_OUT                       : out  std_logic_vector(19 downto 0);
--		 TILE0_RXRECCLK0_OUT                     : out  std_logic;
--		 TILE0_RXRECCLK1_OUT                     : out  std_logic;
--		 TILE0_RXRESET0_IN                       : in   std_logic;
--		 TILE0_RXRESET1_IN                       : in   std_logic;
--		 TILE0_RXUSRCLK0_IN                      : in   std_logic;
--		 TILE0_RXUSRCLK1_IN                      : in   std_logic;
--		 TILE0_RXUSRCLK20_IN                     : in   std_logic;
--		 TILE0_RXUSRCLK21_IN                     : in   std_logic;
--		 ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
--		 TILE0_RXN0_IN                           : in   std_logic;
--		 TILE0_RXN1_IN                           : in   std_logic;
--		 TILE0_RXP0_IN                           : in   std_logic;
--		 TILE0_RXP1_IN                           : in   std_logic;
--		 --------------------- Shared Ports - Tile and PLL Ports --------------------
--		 TILE0_CLKIN_IN                          : in   std_logic;
--		 TILE0_GTXRESET_IN                       : in   std_logic;
--		 TILE0_PLLLKDET_OUT                      : out  std_logic;
--		 TILE0_REFCLKOUT_OUT                     : out  std_logic;
--		 TILE0_RESETDONE0_OUT                    : out  std_logic;
--		 TILE0_RESETDONE1_OUT                    : out  std_logic;
--		 ------------------ Transmit Ports - TX Data Path interface -----------------
--		 TILE0_TXDATA0_IN                        : in   std_logic_vector(9 downto 0);
--		 TILE0_TXDATA1_IN                        : in   std_logic_vector(9 downto 0);
--		 TILE0_TXOUTCLK0_OUT                     : out  std_logic;
--		 TILE0_TXOUTCLK1_OUT                     : out  std_logic;
--		 TILE0_TXUSRCLK0_IN                      : in   std_logic;
--		 TILE0_TXUSRCLK1_IN                      : in   std_logic;
--		 TILE0_TXUSRCLK20_IN                     : in   std_logic;
--		 TILE0_TXUSRCLK21_IN                     : in   std_logic;
--		 --------------- Transmit Ports - TX Driver and OOB signalling --------------
--		 TILE0_TXN0_OUT                          : out  std_logic;
--		 TILE0_TXN1_OUT                          : out  std_logic;
--		 TILE0_TXP0_OUT                          : out  std_logic;
--		 TILE0_TXP1_OUT                          : out  std_logic
--
--
--	);
--	end component;

	--clocks
	signal clk125, clk200, ipb_clk, locked, rst_125, rst_ipb, onehz : STD_LOGIC;
	signal clk40_rec, clk40_rec_i, clk40_io,clk40_io2,rxrecclk_out	: std_logic;
	signal txoutclk,txoutclk_i			 	: std_logic;
	
	--clocks_pll
	signal clk40, clk80, clk160 : std_logic;
	
	--ttc emulator
	signal ttc_reset, ttc_wr , ttc_L1accept, ttc_data_out : std_logic;
	signal ttc_data_in : std_logic_vector(31 downto 0);
	
	--i_gtfx
	signal rxbyteisaligned,rxbyterealign,rxcommadet : std_logic:='0';
	signal rxdata,rxdatab 					: std_logic_vector (19 downto 0);
	--signal txdata 					: std_logic_vector (19 downto 0);
	signal txdata 					: std_logic_vector (9 downto 0);
	
	--reset_manager
	signal TX_Digital_Reset,RX_Analog_Reset,RX_Digital_Reset : std_logic;
	
	--others
	signal mac_tx_data, mac_rx_data: std_logic_vector(7 downto 0);
	signal mac_tx_valid, mac_tx_last, mac_tx_error, mac_tx_ready, mac_rx_valid, mac_rx_last, mac_rx_error: std_logic;
	signal ipb_master_out : ipb_wbus;
	signal ipb_master_in : ipb_rbus;
	signal mac_addr: std_logic_vector(47 downto 0);
	signal ip_addr: std_logic_vector(31 downto 0);
	signal pkt_rx, pkt_tx, pkt_rx_led, pkt_tx_led, sys_rst: std_logic;

begin

-- DCM clock generation for internal bus, ethernet, IO delay logic
-- Input clock 100MHz

	clocks: entity work.clocks_v5_extphy port map(
		sysclk => sys_clk_pin,
		clko_125 => clk125,
		clko_200 => clk200,
		clko_ipb => ipb_clk,
		locked => locked,
		--nuke => sys_rst_array(0),
		nuke => sys_rst,
		rsto_125 => rst_125,
		rsto_ipb => rst_ipb,
		onehz => onehz
		);
		
		
	clocks_pll: entity work.clock_pll PORT MAP(
		CLKIN1_IN => sys_clk_pin,
		RST_IN => '0',
		CLKOUT0_OUT => clk40,
		CLKOUT1_OUT => clk80,
		CLKOUT2_OUT => clk160,
		--CLKOUT3_OUT => clk160,
		LOCKED_OUT => open
	);
	
	i_reset_manager : entity work.reset_manager
	PORT MAP(Reset_Button_N => '1',
		 Clock_40MHz 		=> clk40,
		 TX_Digital_Reset => TX_Digital_Reset,
		 RX_Analog_Reset 	=> RX_Analog_Reset,
		 RX_Digital_Reset => RX_Digital_Reset);


	
	leds <= (pkt_rx_led, pkt_tx_led, locked, onehz);
--	pkt_rx_led <= '0' when pkt_rx_led_bus = (pkt_rx_led_bus'range => '0') else '1';
--	pkt_tx_led <= '0' when pkt_tx_led_bus = (pkt_tx_led_bus'range => '0') else '1';

	
-- Ethernet MAC core and PHY interface
-- In this version, consists of hard MAC core and GMII interface to external PHY
-- Can be replaced by any other MAC / PHY combination
	
	eth: entity work.eth_v5_gmii port map(
		clk125 => clk125,
		clk200 => clk200,
		rst => rst_125,
		locked => locked,
		gmii_tx_clk => gmii_tx_clk,
		gmii_tx_en => gmii_tx_en,
		gmii_tx_er => gmii_tx_er,
		gmii_txd => gmii_txd,
		gmii_rx_clk => gmii_rx_clk,
		gmii_rx_dv => gmii_rx_dv,
		gmii_rx_er => gmii_rx_er,
		gmii_rxd => gmii_rxd,
		tx_data => mac_tx_data,
		tx_valid => mac_tx_valid,
		tx_last => mac_tx_last,
		tx_error => mac_tx_error,
		tx_ready => mac_tx_ready,
		rx_data => mac_rx_data,
		rx_valid => mac_rx_valid,
		rx_last => mac_rx_last,
		rx_error => mac_rx_error
	);
	
	--TTC Emulator
	TTC_Emulator: entity work.TTC port map
	(
    data_in  => ttc_data_in,
    wr       => ttc_wr,
    L1accept => ttc_L1accept,
    data_out => open,
    clk40MHz => clk40,
    clk80MHz => clk80,
    clk160MHz => clk160,
    reset     => ttc_reset	);
	
	phy_rstb <= '1';


    ----------------------------- The GTX Wrapper -----------------------------
	 i_gtfx : entity  work.GTXF
    generic map
    (
        WRAPPER_SIM_GTXRESET_SPEEDUP    =>      1,
        WRAPPER_SIM_PLL_PERDIV2         =>      x"139"
    )
    port map
    (
        --_____________________________________________________________________
        --_____________________________________________________________________
        --TILE0  (X0Y5)
        
		  --------------- Receive Ports - Comma Detection and Alignment --------------
        TILE0_RXBYTEISALIGNED0_OUT      =>      rxbyteisaligned,
        TILE0_RXBYTEISALIGNED1_OUT      =>      open,
        TILE0_RXBYTEREALIGN0_OUT        =>      rxbyterealign,
        TILE0_RXBYTEREALIGN1_OUT        =>      open,
        TILE0_RXCOMMADET0_OUT           =>      rxcommadet,
        TILE0_RXCOMMADET1_OUT           =>      open,
        TILE0_RXENMCOMMAALIGN0_IN       =>      '1',
        TILE0_RXENMCOMMAALIGN1_IN       =>      '1',
        TILE0_RXENPCOMMAALIGN0_IN       =>      '1',
        TILE0_RXENPCOMMAALIGN1_IN       =>      '1',
        ------------------- Receive Ports - RX Data Path interface -----------------
		  TILE0_RXDATA0_OUT               =>      rxdata, --rxdatab
        TILE0_RXDATA1_OUT               =>      open,
        TILE0_RXRECCLK0_OUT             =>		clk40_rec_i, --rxrecclk_out,
		  TILE0_RXRECCLK1_OUT             =>		open,
        TILE0_RXRESET0_IN               =>      RX_Digital_Reset,
        TILE0_RXRESET1_IN               =>      RX_Digital_Reset,
        TILE0_RXUSRCLK0_IN              =>      clk40_rec, --clk40
        TILE0_RXUSRCLK1_IN              =>      clk40_rec, --clk40
        TILE0_RXUSRCLK20_IN             =>      clk40_rec, --clk40
        TILE0_RXUSRCLK21_IN             =>      clk40_rec, --clk40
        ------- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        TILE0_RXN0_IN                   =>      SFP_RX_N,
        TILE0_RXN1_IN                   =>      SMA_RX_N,
        TILE0_RXP0_IN                   =>      SFP_RX_P,
        TILE0_RXP1_IN                   =>      SMA_RX_P,
		  --------------------- Shared Ports - Tile and PLL Ports --------------------
        TILE0_CLKIN_IN                  =>      clk80,
        TILE0_GTXRESET_IN               =>      TX_Digital_Reset,
        TILE0_PLLLKDET_OUT              =>      open,
        TILE0_REFCLKOUT_OUT             =>      open,
        TILE0_RESETDONE0_OUT            =>      open,
        TILE0_RESETDONE1_OUT            =>      open,
        ------------------ Transmit Ports - TX Data Path interface -----------------
		  TILE0_TXDATA0_IN                =>		txdata,
        TILE0_TXDATA1_IN                =>      txdata,
        TILE0_TXOUTCLK0_OUT             =>      txoutclk_i, -- es un clk de 160MHz
        TILE0_TXOUTCLK1_OUT             =>      open,
        TILE0_TXUSRCLK0_IN              =>      clk80, --clk80
        TILE0_TXUSRCLK1_IN              =>      clk80,--clk80
        TILE0_TXUSRCLK20_IN             =>      clk160,--clk160
        TILE0_TXUSRCLK21_IN             =>      clk160,--clk160
        --------------- Transmit Ports - TX Driver and OOB signalling --------------
        TILE0_TXN0_OUT                  =>      SFP_TX_N,
        TILE0_TXN1_OUT                  =>      open,
        TILE0_TXP0_OUT                  =>      SFP_TX_P,
        TILE0_TXP1_OUT                  =>      open
    );

	BUFR_clk40 : BUFR
	generic map (
		BUFR_DIVIDE => "1", -- "BYPASS", "1", "2", "3", "4", "5", "6", "7", "8"
		SIM_DEVICE => "VIRTEX5") -- Specify target device, "VIRTEX4", "VIRTEX5", "VIRTEX6"
	port map (
		O => clk40_rec, -- Clock buffer output
		CE => '1', -- Clock enable input
		CLR => '0', -- Clock buffer reset input
		I => clk40_rec_i -- Clock buffer input
	);	

--	arb: entity work.mac_arbiter
--		generic map(
--			NSRC => N_IPB
--		)
--		port map(
--			clk => clk125,
--			rst => rst_125,
--			src_tx_data_bus => mac_tx_data_bus,
--			src_tx_valid_bus => mac_tx_valid_bus,
--			src_tx_last_bus => mac_tx_last_bus,
--			src_tx_error_bus => mac_tx_error_bus,
--			src_tx_ready_bus => mac_tx_ready_bus,
--			mac_tx_data => mac_tx_data,
--			mac_tx_valid => mac_tx_valid,
--			mac_tx_last => mac_tx_last,
--			mac_tx_error => mac_tx_error,
--			mac_tx_ready => mac_tx_ready
--		);
	
--	ipbus_gen: for i in N_IPB-1 downto 0 generate

--		signal ipb_master_out: ipb_wbus;
--		signal ipb_master_in: ipb_rbus;
--		signal mac_addr: std_logic_vector(47 downto 0);
--		signal ip_addr: std_logic_vector(31 downto 0);

-- ipbus control logic

	ipbus: entity work.ipbus_ctrl
		port map(
			mac_clk => clk125,
			rst_macclk => rst_125,
			ipb_clk => ipb_clk,
			rst_ipb => rst_ipb,
			mac_rx_data => mac_rx_data,
			mac_rx_valid => mac_rx_valid,
			mac_rx_last => mac_rx_last,
			mac_rx_error => mac_rx_error,
			mac_tx_data => mac_tx_data,
			mac_tx_valid => mac_tx_valid,
			mac_tx_last => mac_tx_last,
			mac_tx_error => mac_tx_error,
			mac_tx_ready => mac_tx_ready,
			ipb_out => ipb_master_out,
			ipb_in => ipb_master_in,
			mac_addr => mac_addr,
			ip_addr => ip_addr,
			pkt_rx => pkt_rx,
			pkt_tx => pkt_tx,
			pkt_rx_led => pkt_rx_led,
			pkt_tx_led => pkt_tx_led
		);
		
	mac_addr <= X"020ddba11599"; -- Careful here, arbitrary addresses do not always work
	ip_addr <= X"c0a80008"; -- 192.168.0.8


		slaves: entity work.slaves port map(
			ipb_clk => ipb_clk,
			ipb_rst => rst_ipb,
			ipb_in => ipb_master_out,
			ipb_out => ipb_master_in,
--			rst_out => sys_rst_array,
			rst_out => sys_rst,
--			pkt_rx => pkt_rx_bus,
--			pkt_tx => pkt_tx_bus
			pkt_rx => pkt_rx,
			pkt_tx => pkt_tx,
			
			--ttc emulator
			ttc_data_in => ttc_data_in,
			ttc_data_out =>ttc_data_out,
			ttc_reset =>ttc_reset,
			ttc_wr => ttc_wr,
			ttc_L1accept =>ttc_L1Accept,
			--slink_register
			slink_data_tx => txdata,
			slink_data_rx => rxdata
		);
		


--	begin
--    
--		ipbus: entity work.ipbus_ctrl
--			port map(
--				ipb_clk => ipb_clk,
--				rst_ipb => rst_ipb,
--				rst_macclk => rst_125,
--				mac_clk => clk125,
--				mac_rx_data => mac_rx_data,
--				mac_rx_valid => mac_rx_valid,
--				mac_rx_last => mac_rx_last,
--				mac_rx_error => mac_rx_error,
--				mac_tx_data => mac_tx_data_bus(i),
--				mac_tx_valid => mac_tx_valid_bus(i),
--				mac_tx_last => mac_tx_last_bus(i),
--				mac_tx_error => mac_tx_error_bus(i),
--				mac_tx_ready => mac_tx_ready_bus(i),
--				ipb_out => ipb_master_out,
--				ipb_in => ipb_master_in,
--				mac_addr => mac_addr,
--				ip_addr => ip_addr,
--				pkt_rx => pkt_rx_bus(i),
--				pkt_tx => pkt_tx_bus(i),
--				pkt_rx_led => pkt_rx_led_bus(i),
--				pkt_tx_led => pkt_tx_led_bus(i)
--			);
--		
--		mac_addr <= X"020ddba115" & dip_switch & std_logic_vector(to_unsigned(i, 4));
--		ip_addr <= X"c0a8c8" & dip_switch & std_logic_vector(to_unsigned(i, 4));
--		
--		slaves: entity work.slaves port map(
--			ipb_clk => ipb_clk,
--			ipb_rst => rst_ipb,
--			ipb_in => ipb_master_out,
--			ipb_out => ipb_master_in,
--			rst_out => sys_rst_array(i),
--			pkt_rx => pkt_rx_bus(i),
--			pkt_tx => pkt_tx_bus(i)
--		);
--	 
--	end generate;-- ipbus control logic

end rtl;

