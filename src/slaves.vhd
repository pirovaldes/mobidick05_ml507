-- The ipbus slaves live in this entity - modify according to requirements
--
-- Ports can be added to give ipbus slaves access to the chip top level.
--
-- Dave Newbold, February 2011

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ipbus.ALL;

entity slaves is
	port(
		ipb_clk: in std_logic;
		ipb_rst: in std_logic;
		ipb_in: in ipb_wbus;
		ipb_out: out ipb_rbus;
		rst_out: out std_logic;
		eth_err_ctrl: out std_logic_vector(35 downto 0);
		eth_err_stat: in std_logic_vector(47 downto 0) := X"000000000000";
		pkt_rx: in std_logic := '0';
		pkt_tx: in std_logic := '0';
		--ttc registers
		ttc_data_in: std_logic_vector(31 downto 0);
		ttc_data_out: std_logic;
		ttc_reset: std_logic;
		ttc_wr: std_logic;
		ttc_L1accept: std_logic;
		--s_link registers
		slink_data_tx: std_logic_vector(9 downto 0);
		slink_data_rx: std_logic_vector(19 downto 0)
		
	);

end slaves;

architecture rtl of slaves is

	constant NSLV: positive := 6;
	signal ipbw: ipb_wbus_array(NSLV-1 downto 0);
	signal ipbr, ipbr_d: ipb_rbus_array(NSLV-1 downto 0);
	signal ctrl_reg_0, ctrl_reg_1: std_logic_vector(31 downto 0);
	signal inj_ctrl, inj_stat: std_logic_vector(63 downto 0);

begin

  fabric: entity work.ipbus_fabric
    generic map(NSLV => NSLV)
    port map(
      ipb_in => ipb_in,
      ipb_out => ipb_out,
      ipb_to_slaves => ipbw,
      ipb_from_slaves => ipbr
    );

-- Slave 0: dummy id/rst register
	--ctrl_reg <= X"000FFFFF" and slink_data_tx;
	slave0: entity work.ipbus_mobidick_reg
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(0),
			ipbus_out => ipbr(0),
			readonly => '0',
			d => X"abcd0001",
			q => open
		);
		
		--rst_out <= ctrl_reg_0(0) and ctrl_reg_1(0);
		rst_out <= ctrl_reg_0(0);
		
-- Slave 1: register

	slave1: entity work.ipbus_reg
		generic map(addr_width => 0)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(1),
			ipbus_out => ipbr(1),
			q => open
		);
			
--	slave1: entity work.ipbus_ctrlreg
--		port map(
--			clk => ipb_clk,
--			reset => ipb_rst,
--			ipbus_in => ipbw(1),
--			ipbus_out => ipbr(1),
--			d => X"aaaa0001",
--			-- d => X"000FFFFF" and slink_data_rx,
--			q => ctrl_reg_1
--		);
--		
--		


-- Slave 2: ethernet error injection

	slave3: entity work.ipbus_ctrlreg
		generic map(
			ctrl_addr_width => 1,
			stat_addr_width => 1
		)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(2),
			ipbus_out => ipbr(2),
			d => inj_stat,
			q => inj_ctrl
		);
		
	eth_err_ctrl <= inj_ctrl(49 downto 32) & inj_ctrl(17 downto 0);
	inj_stat <= X"00" & eth_err_stat(47 downto 24) & X"00" & eth_err_stat(23 downto 0);
	
-- Slave 3: packet counters

	slave5: entity work.ipbus_pkt_ctr
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(3),
			ipbus_out => ipbr(3),
			pkt_rx => pkt_rx,
			pkt_tx => pkt_tx
		);

-- Slave 4: 1kword RAM

	slave2: entity work.ipbus_ram
		generic map(addr_width => 10)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(4),
			ipbus_out => ipbr(4)
		);
	
-- Slave 5: peephole RAM

	slave4: entity work.ipbus_peephole_ram
		generic map(addr_width => 10)
		port map(
			clk => ipb_clk,
			reset => ipb_rst,
			ipbus_in => ipbw(5),
			ipbus_out => ipbr(5)
		);

end rtl;
