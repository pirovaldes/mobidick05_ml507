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
use ieee.numeric_std.all;
use work.ipbus.all;

entity ipbus_tilefifo is
	port(
		clk: in std_logic;
		reset: in std_logic;
		ipbus_in: in ipb_wbus;
		ipbus_out: out ipb_rbus;
		fifo_empty: out std_logic:='1';
		fifo_ren: in std_logic;
		fifo_rclk: in std_logic;
		fifo_d: out std_logic_vector(31 downto 0)
	);
	
end ipbus_tilefifo;

architecture rtl of ipbus_tilefifo is

	--type memory_type is array(7 downto 0) of std_logic_vector(31 downto 0); -- up to 256 words
	--signal memory : memory_type :=(others => (others => '0'));   --memory for queue.
	--signal readptr,writeptr : integer range 0 to 15 :=0;
	signal ack, fifo_emptyi,fifo_ren_i : std_logic;
	signal ipbusstrobe, ipbuswrite : std_logic;
	signal memory : std_logic_vector(31 downto 0);
	signal state : integer range 0 to 2;
		
	type state_type is (IDLE, RX_COMMAND, TX_COMMAND);  --type of state machine.
	signal current_state,next_state: state_type;  --current and next state declaration.
	
	attribute keep	: boolean;
	attribute keep of ipbusstrobe, ipbuswrite, memory,state	: signal is true;
begin

--- Input signals
ipbusstrobe <= ipbus_in.ipb_strobe;
ipbuswrite <= ipbus_in.ipb_write;



	
process (fifo_rclk,reset)
begin
 if (reset='1') then
  current_state <= IDLE;  
 elsif (rising_edge(fifo_rclk)) then
  current_state <= next_state;   
end if;
end process;
		
		
--state machine 
process (current_state,ipbus_in.ipb_strobe,ipbus_in.ipb_write)
begin
  case current_state is
  
     when IDLE =>
	  fifo_empty <= '1';
	  fifo_d <= memory;
	  state<=0;
	  ipbus_out.ipb_rdata <= memory; 
	 if(ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1') then
      next_state <= RX_COMMAND;
    else
      next_state <= IDLE;
     end if;   

     when RX_COMMAND =>	 
		fifo_empty <= '1';
		fifo_d <= memory;		
		state<= 1;
	 if(ipbus_in.ipb_strobe='0' or ipbus_in.ipb_write='0') then
      next_state <= TX_COMMAND;
    else
      next_state <= RX_COMMAND;
    end if;
	 
	 
	 when TX_COMMAND =>
   	fifo_empty <= '0';
  	   fifo_d <= memory;
		state <=2;
		if(fifo_ren_i='1') then
			next_state <= IDLE;
		else
			next_state <= TX_COMMAND;
		end if;
  end case;
end process;		



process(fifo_ren, current_state)
begin
if (current_state <= IDLE) then
	fifo_ren_i <= '0';
elsif (rising_edge(fifo_ren)) then
	fifo_ren_i <= '1';
end if;
end process;


process(clk)
	begin
		if rising_edge(clk) then
			if reset='1' then
				memory <= (others=>'0');
			elsif ipbus_in.ipb_strobe='1' and ipbus_in.ipb_write='1' then
				memory <= ipbus_in.ipb_wdata;
			end if;
			
			ack <= ipbus_in.ipb_strobe and not ack;

		end if;
	end process;

ipbus_out.ipb_ack <= ack;
ipbus_out.ipb_err <= '0';




end rtl;
