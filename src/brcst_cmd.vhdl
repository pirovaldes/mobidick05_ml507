-------------------------------------------------------------------------------
--                         University of Stockholm      --
--                          Department of Physics       --
--                      System & Instrumentation Group  --
-------------------------------------------------------------------------------
--
--  File name  : brcst_cmd.vhdl
--  Author     : Jonas Klereborn     Email: klere@physto.se
--  Date       : 2002 10 17
--  Version    : 1.0
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity TTC_broadcast_cmd is
  port(
    clk    : in  std_logic;
    strobe : in  std_logic;
    data   : in  std_logic_vector(7 downto 0);
    done   : out std_logic;
    output : out std_logic
    );
end TTC_broadcast_cmd;

architecture TTC_brcst_cmd of TTC_broadcast_cmd is

  component Hamming_encoder_8bit
    port(
      clk    : in  std_logic;
      strobe : in  std_logic;
      data   : in  std_logic_vector(7 downto 0);
      hamm8  : out std_logic_vector(4 downto 0)
      );
  end component;

  type states is (waiting, running1, running2);
  signal state : states;

  signal cmd_data : std_logic_vector(9 downto 0);
  signal hamm     : std_logic_vector(4 downto 0);
  signal strobe2  : std_logic;
  signal count    : integer;
  signal done_int : std_logic;

begin

  Hamming_encoder : Hamming_encoder_8bit port map (
    clk    => clk,
    strobe => strobe2,
    data   => cmd_data(7 downto 0),
    hamm8  => hamm);

  build_cmd : process (clk)

  begin  -- process encode

    if rising_edge(clk) then

      done_int <= '0';

      case state is

        when waiting =>
          output     <= '1';
          if strobe = '1' then
            cmd_data <= "00" & data;
            count    <= 9;
            state    <= running1;
          end if;

        when running1 =>
          output  <= cmd_data(count);
          if count = 0 then
            count <= 4;
            state <= running2;
          else
            count <= count - 1;
          end if;

        when running2 =>
          output  <= hamm(count);
          if count = 0 then
            state <= waiting;
            done_int  <= '1';
          else
            count <= count - 1;
          end if;

      end case;

      strobe2 <= strobe;
      done <= done_int;

    end if;
  end process build_cmd;

end TTC_brcst_cmd;