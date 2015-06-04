-------------------------------------------------------------------------------
--                         University of Stockholm      --
--                          Department of Physics       --
--                      System & Instrumentation Group  --
-------------------------------------------------------------------------------
--
--  File name  : ttc_encoder.vhdl
--  Author     : Jonas Klereborn     Email: klere@physto.se
--  Date       : 2001 10 16
--  Version    : 1.0
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Ttc_encoder is
  port(
    MHz40     : in  std_logic;
    MHz80     : in  std_logic;
    MHz160    : in  std_logic;
    reset     : in  std_logic;
    a_channel : in  std_logic;
    b_channel : in  std_logic;
    output    : out std_logic
    );
end Ttc_encoder;

architecture Encode of Ttc_encoder is

  signal a_and_b : std_logic;
  signal outsig  : std_logic;

begin

  a_and_b <= a_channel when (MHz40 = '1') else b_channel;
  output  <= outsig;

  ttc_encode : process (MHz160, reset)
  begin

    if reset = '0' then
      outsig <= '0';
    else

      if rising_edge(MHz160) then
        if MHz80 = '0' then
          outsig   <= not(outsig);
        else
          if a_and_b = '1' then
            outsig <= not(outsig);
          end if;
        end if;
      end if;
    end if;

  end process ttc_encode;

end Encode;