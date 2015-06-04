-------------------------------------------------------------------------------
--                         University of Stockholm      --
--                          Department of Physics       --
--                      System & Instrumentation Group  --
-------------------------------------------------------------------------------
--
--  File name  : hamm32.vhdl
--  Author     : Jonas Klereborn     Email: klere@physto.se
--  Date       : 2002 10 17
--  Version    : 1.0
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Hamming_encoder_32bit is
  port(
    clk    : in  std_logic;
    strobe : in  std_logic;
    data   : in  std_logic_vector(31 downto 0);
    hamm32  : out std_logic_vector(6 downto 0)
    );
end Hamming_encoder_32bit;

architecture Hamm32 of Hamming_encoder_32bit is

  signal h_0_2 : std_logic;
  signal h_3_5 : std_logic;
  signal h_6_9 : std_logic;
  signal h_10_13 : std_logic;
  signal h_14_17 : std_logic;
  signal h_18_20 : std_logic;
  signal h_21_24 : std_logic;
  signal h_25_27 : std_logic;
  signal h_28_30 : std_logic;
  signal h4_1 : std_logic;
  signal h4_2 : std_logic;
  signal h4_3 : std_logic;
  signal h5_1 : std_logic;
  signal h5_2 : std_logic;
  signal h5_3 : std_logic;
  signal h6_1 : std_logic;
  signal h6_2 : std_logic;
  signal h6_3 : std_logic;

  signal h : std_logic_vector(6 downto 0);
  signal d : std_logic_vector(31 downto 0);

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
          h_0_2 <= d(0) xor d(1) xor d(2);
          h_3_5 <= d(3) xor d(4) xor d(5);
          h_6_9 <= d(6) xor d(7) xor d(8) xor d(9);
          h_10_13 <= d(10) xor d(11) xor d(12) xor d(13);
          h_14_17 <= d(14) xor d(15) xor d(16) xor d(17);
          h_18_20 <= d(18) xor d(19) xor d(20);
          h_21_24 <= d(21) xor d(22) xor d(23) xor d(24);
          h_25_27 <= d(25) xor d(26) xor d(27);
          h_28_30 <= d(28) xor d(29) xor d(30);
          h4_1 <= d(0) xor d(3) xor d(4) xor d(6) xor d(7) xor d(10);
          h4_2 <= d(11) xor d(14) xor d(15) xor d(18) xor d(19) xor d(21);
          h4_3 <= d(22) xor d(25) xor d(26) xor d(28) xor d(29) xor d(31);
          h5_1 <= d(1) xor d(3) xor d(5) xor d(6) xor d(8) xor d(10);
          h5_2 <= d(12) xor d(14) xor d(16) xor d(18) xor d(20) xor d(21);
          h5_3 <= d(23) xor d(25) xor d(27) xor d(28) xor d(30) xor d(31);
          h6_1 <= d(2) xor d(4) xor d(5) xor d(7) xor d(8) xor d(10);
          h6_2 <= d(13) xor d(14) xor d(17) xor d(19) xor d(20) xor d(21);
          h6_3 <= d(24) xor d(26) xor d(27) xor d(29) xor d(30) xor d(31);
          state <= enc2;

        when enc2 =>
          hamm32(0) <= h_0_2 xor h_3_5;
          hamm32(1) <= h_6_9 xor h_10_13 xor h_14_17 xor h_18_20;
          hamm32(2) <= h_6_9 xor h_10_13 xor h_21_24 xor h_25_27;
          hamm32(3) <= h_0_2 xor h_6_9 xor h_14_17 xor h_21_24 xor h_28_30;
          hamm32(4) <= h4_1 xor h4_2 xor h4_3;
          hamm32(5) <= h5_1 xor h5_2 xor h5_3;
          hamm32(6) <= h6_1 xor h6_2 xor h6_3;
          state <= waiting;

      end case;

    end if;
  end process encode;

end Hamm32;