-- Generic control / status register block
--
-- Provides 2**n control registers (32b each), rw
-- Provides 2**m status registers (32b each), ro
--
-- Bottom part of read address space is control, top is status
--
-- Useful for misc control of firmware block
-- Unused registers should be optimised away
--
-- Alberto Valero, Feb 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use work.ipbus.all;

entity ipbus_tileram is
	port(
		clk: in std_logic;
		reset: in std_logic;
		ipbus_in: in ipb_wbus;
		ipbus_out: out ipb_rbus;
		bcid_wr :in std_logic_vector(11 downto 0);
		Cmd_address: in std_logic_vector(15 downto 0);
		MD_index : in std_logic_vector(2 downto 0);
		-- Extract the commands --
		bcid_rd : in std_logic_vector(11 downto 0);
		cmd_rclk : in std_logic;
		reset_mem : in std_logic;
		enable : in std_logic;
		iterations :  in std_logic_vector(13 downto 0);
		synchro_command : out std_logic_vector(50 downto 0)
	);
	
end ipbus_tileram;

architecture rtl of ipbus_tileram is
	
	constant RAM_SIZE: positive := 20;
	type command_type is array(0 to RAM_SIZE-1) of std_logic_vector(63 downto 0); -- up to 2^12 words
	signal cmd_bcid : command_type :=(others => (others => '0'));   --memory for queue.
	
	signal ptr : integer range 0 to (RAM_SIZE-1) :=0;
	
	signal ack: std_logic;
	signal ipbusstrobe, ipbuswrite : std_logic;

	signal synchro_command_internal :  std_logic_vector(50 downto 0);
	
	type state_type is (IDLE, RX_COMMAND, UPDATE_PTR);  --type of state machine.
	signal current_state,next_state: state_type;  --current and next state declaration.
				
	signal counter_iter : std_logic_vector(13 downto 0);
	attribute keep	: boolean;
	attribute keep of ipbusstrobe, ipbuswrite,ptr	: signal is true;


begin








process (clk,reset, reset_mem)
begin
 if (reset='1' or reset_mem='1') then
  current_state <= IDLE;  
 elsif (rising_edge(clk)) then
  current_state <= next_state;   
end if;
end process;
		
		
--state machine 
process (current_state,ipbus_in.ipb_strobe,ipbus_in.ipb_write)
begin
  case current_state is
  
     when IDLE =>
		if(ptr=0)then
			  ipbus_out.ipb_rdata <= cmd_bcid(19)(31 downto 0); 
		else
			  ipbus_out.ipb_rdata <= cmd_bcid(ptr-1)(31 downto 0); 
		end if;			 
		if(ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1') then
			next_state <= RX_COMMAND;
		else
			next_state <= IDLE;
		end if;   

     when RX_COMMAND =>   
	 if(ipbus_in.ipb_strobe='0' or ipbus_in.ipb_write='0') then
      next_state <= UPDATE_PTR;
    else
      next_state <= RX_COMMAND;
    end if;
	 
	 when UPDATE_PTR =>
		next_state <= IDLE;
  end case;
end process;	


process(clk)
	begin
		if rising_edge(clk) then
			if (reset='1' or reset_mem='1' )then
				cmd_bcid <= (others=>(others=>'0'));
			elsif ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1' then
				cmd_bcid(ptr)(31 downto 0) <= ipbus_in.ipb_wdata;
				cmd_bcid(ptr)(47 downto 32) <= Cmd_address ;
				cmd_bcid(ptr)(59 downto 48) <= bcid_wr;
				cmd_bcid(ptr)(62 downto 60) <= MD_index;
			end if;
			
			ack <= ipbus_in.ipb_strobe and not ack;

		end if;
	end process;

ipbus_out.ipb_ack <= ack;
ipbus_out.ipb_err <= '0';
	
process(clk, reset, reset_mem)
begin
if(reset='1' or reset_mem='1') then
ptr <= 0;
elsif(falling_edge(clk)) then
	if current_state=UPDATE_PTR then
		if(ptr=(RAM_SIZE-1)) then
			ptr <= 0;
		else
			ptr <= ptr + 1;      --points to next address.
		end if;
end if;
end if;
end process;


--- read the commands out
process(reset,cmd_rclk,enable,iterations,reset_mem)
	begin
		if (reset='1' or reset_mem='1') then
			synchro_command <= (others=>'0');
		--	counter_iter <= (others=>'0');
		elsif( rising_edge(cmd_rclk)) then
			if(enable='1') then
				if(counter_iter /= iterations or iterations="00000000000000") then
					synchro_command <= synchro_command_internal;
				--	counter_iter <= counter_iter + '1';
				else
					synchro_command <= (others=>'0');
				end if;
			else -- every time the enable goes to '0' the counter is reset
				synchro_command <= (others=>'0');
				--counter_iter <= (others=>'0');
			end if;
		end if;
end process;


--- ORBIT COUNTER --
process(bcid_rd,cmd_rclk)
begin
if (rising_edge(cmd_rclk)) then
	if(enable='0') then
		counter_iter <= (others=>'0');
	elsif (bcid_rd=x"000" and counter_iter /= iterations) then
		counter_iter <= counter_iter + '1';
	else 
		counter_iter <= counter_iter;
	end if;
end if;
end process;
		


process(bcid_rd,cmd_bcid)
variable synchr_command_variable: std_logic_vector(50 downto 0) := (others => '0');
begin
synchr_command_variable := (others => '0');
for i in 0 to (RAM_SIZE-1) loop
	if ((cmd_bcid(i)(59 downto 48) = bcid_rd)) then
		synchr_command_variable(47 downto 0) := cmd_bcid(i)(47 downto 0);
		synchr_command_variable(50 downto 48) := cmd_bcid(i)(62 downto 60);
	end if;
end loop;
synchro_command_internal <= synchr_command_variable;
end process;



end rtl;
