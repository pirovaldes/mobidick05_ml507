-- Generic single control read/write register

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.ipbus.all;

entity ipbus_mobidick_reg is

	port(
		clk: in std_logic;
		reset: in std_logic;
		ipbus_in: in ipb_wbus;
		ipbus_out: out ipb_rbus;
		readonly : in std_logic;
		d: in std_logic_vector(31 downto 0);
		q: out std_logic_vector(31 downto 0)
	);
	
end ipbus_mobidick_reg;

architecture rtl of ipbus_mobidick_reg is

	
	signal ack: std_logic;
	signal reg: std_logic_vector(31 downto 0);
	
begin

	
	process(clk,d)
	begin
		if rising_edge(clk) then
			if reset='1' then
				reg <= d;
			elsif readonly='1' then
				reg <= d;
			elsif ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1' then
				reg <= ipbus_in.ipb_wdata;
				
			end if;

			if readonly = '1' then
				ipbus_out.ipb_rdata <= d;
			else
				ipbus_out.ipb_rdata <= reg; 
			end if;
			
			ack <= ipbus_in.ipb_strobe and not ack;
			q <= reg;
		end if;
	end process;
	
	ipbus_out.ipb_ack <= ack;
	ipbus_out.ipb_err <= '0';
	
end rtl;
