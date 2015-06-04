-------------------------------------------------------------------------------
--                         University of Stockholm      --
--                          Department of Physics       --
--                      System & Instrumentation Group  --
-------------------------------------------------------------------------------
--
--  File name  : hamm8.vhdl
--  Author     : Jonas Klereborn     Email: klere@physto.se
--  Date       : 2002 10 17
--  Version    : 1.0
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Hamming_encoder_8bit is
  port(
    clk    : in  std_logic;
    strobe : in  std_logic;
    data   : in  std_logic_vector(7 downto 0);
    hamm8  : out std_logic_vector(4 downto 0)
    );
end Hamming_encoder_8bit;

architecture Hamm8 of Hamming_encoder_8bit is

  signal h : std_logic_vector(3 downto 0);
  signal d : std_logic_vector(7 downto 0);

  type states is (waiting, enc1, enc2);
  signal state : states;

begin

  encode : process (clk)

  begin  -- process encode

    if rising_edge(clk) then

      case state is
        when waiting =>
          if strobe = '1' then
            d     <= data;
            state <= enc1;
          end if;

        when enc1 =>
          h(0)  <= d(0) xor d(1) xor d(2) xor d(3);
          h(1)  <= d(0) xor d(4) xor d(5) xor d(6);
          h(2)  <= d(1) xor d(2) xor d(4) xor d(5) xor d(7);
          h(3)  <= d(1) xor d(3) xor d(4) xor d(6) xor d(7);
          state <= enc2;

        when enc2 =>
          hamm8(3 downto 0) <= h;
          hamm8(4)  <= h(2) xor h(3) xor d(0) xor d(7);
          state <= waiting;

      end case;

    end if;
  end process encode;

end Hamm8;