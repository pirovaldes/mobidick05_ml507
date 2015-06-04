-------------------------------------------------------------------------------
-- TTC top
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity TTC is
  
  port (
    data_in   : in  std_logic_vector(31 downto 0);
    wr        : in  std_logic;
    L1accept  : in  std_logic;
    data_out  : out std_logic;
    clk40MHz  : in  std_logic;
    clk80MHz  : in  std_logic;
    clk160MHz : in  std_logic;
    reset     : in  std_logic);

end TTC;

architecture TTC_design of TTC is
--
--  component TTC_test
--    port(
--      reset     : in  std_logic;
--      send      : in  std_logic;
--      b_channel : in  std_logic;
--      clk40MHz  : in  std_logic;
--      clk80MHz  : in  std_logic;
--      clk160MHz : in  std_logic;
--      output    : out std_logic
--      );
--  end component;
--
  component TTC_broadcast_cmd
    port(
      clk    : in  std_logic;
      strobe : in  std_logic;
      data   : in  std_logic_vector(7 downto 0);
      done   : out std_logic;
      output : out std_logic
      );
  end component;
  component TTC_addressed_cmd
    port(
      clk     : in  std_logic;
      strobe  : in  std_logic;
      ttcaddr : in  std_logic_vector(13 downto 0);
      e_i     : in  std_logic;
      subaddr : in  std_logic_vector(7 downto 0);
      data    : in  std_logic_vector(7 downto 0);
      done    : out std_logic;
      output  : out std_logic
      );
  end component;

  signal sel, data8, data32, data : std_logic;
  signal done1, done2 : std_logic;
  
-- Signals for pipeline
  signal    wr_i  	: std_logic;
  signal 	L1accept_i  :   std_logic;
  signal		data_in_i    : std_logic_vector(31 downto 0);
  signal		reset_i		: std_logic;
  begin  -- TTC_design
--pipeline: process (clk40MHz,wr)
--begin
--	if rising_edge(clk40MHz) then  -- rising clock edge
--		reset_i	<= reset;
--		L1accept_i	<= L1accept;
--		if wr = '1' then
--			wr_i	 	<= '1';
--			data_in_i	<= data_in;
--		else
--			wr_i	<= '0';
--			data_in_i	<= data_in_i;
--		end if;
--	end if;
--end process pipeline;

reset_i	<= reset;
L1accept_i	<= L1accept;
data_in_i	<= data_in;
wr_i	<= wr;

S1: process (reset_i,clk40MHz,wr_i)
begin  -- process S1
 if reset_i = '0' then                 -- asynchronous reset (active low)
	sel <= '0';
 elsif rising_edge(clk40MHz) then  -- rising clock edge
	if wr_i = '1' then
	  sel <= data_in_i(8);
	end if;
 end if;
end process S1;

data <= data32 when sel = '1' else data8;

TTCB: Ttc_broadcast_cmd port map(clk40MHz,wr_i,data_in_i(7 downto 0),done1,data8);
TTCA: Ttc_addressed_cmd port map(clk40MHz,wr_i,data_in_i(31 downto 18),data_in_i(17),data_in_i(16 downto 9),data_in_i(7 downto 0),done2,data32);
--TTCT: TTC_test port map(reset_i,L1accept_i,data,clk40MHz,clk80MHz,clk160MHz,data_out);

end TTC_design;