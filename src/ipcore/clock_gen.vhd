--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : xaw2vhdl
--  /   /         Filename : clock_gen.vhd
-- /___/   /\     Timestamp : 05/18/2015 15:37:30
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: xaw2vhdl-st /home/pirovaldes/Data/Documents/Documents/apps/ml507/ipcore_dir/./clock_gen.xaw /home/pirovaldes/Data/Documents/Documents/apps/ml507/ipcore_dir/./clock_gen
--Design Name: clock_gen
--Device: xc5vfx70t-1ff1136
--
-- Module clock_gen
-- Generated by Xilinx Architecture Wizard
-- Written for synthesis tool: XST
-- Period Jitter (unit interval) for block DCM_ADV_INST = 0.020 UI
-- Period Jitter (Peak-to-Peak) for block DCM_ADV_INST = 0.158 ns

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity clock_gen is
   port ( CLKIN_IN        : in    std_logic; 
          RST_IN          : in    std_logic; 
          CLKDV_OUT       : out   std_logic; 
          CLKFX_OUT       : out   std_logic; 
          CLKFX180_OUT    : out   std_logic; 
          CLKIN_IBUFG_OUT : out   std_logic; 
          CLK0_OUT        : out   std_logic; 
          CLK2X_OUT       : out   std_logic; 
          CLK2X180_OUT    : out   std_logic; 
          CLK90_OUT       : out   std_logic; 
          CLK180_OUT      : out   std_logic; 
          CLK270_OUT      : out   std_logic; 
          DO_OUT          : out   std_logic_vector (15 downto 0); 
          LOCKED_OUT      : out   std_logic);
end clock_gen;

architecture BEHAVIORAL of clock_gen is
   signal CLKDV_BUF       : std_logic;
   signal CLKFB_IN        : std_logic;
   signal CLKFX_BUF       : std_logic;
   signal CLKFX180_BUF    : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal CLK2X_BUF       : std_logic;
   signal CLK2X180_BUF    : std_logic;
   signal CLK90_BUF       : std_logic;
   signal CLK180_BUF      : std_logic;
   signal CLK270_BUF      : std_logic;
   signal GND_BIT         : std_logic;
   signal GND_BUS_7       : std_logic_vector (6 downto 0);
   signal GND_BUS_16      : std_logic_vector (15 downto 0);
begin
   GND_BIT <= '0';
   GND_BUS_7(6 downto 0) <= "0000000";
   GND_BUS_16(15 downto 0) <= "0000000000000000";
   CLKIN_IBUFG_OUT <= CLKIN_IBUFG;
   CLK0_OUT <= CLKFB_IN;
   CLKDV_BUFG_INST : BUFG
      port map (I=>CLKDV_BUF,
                O=>CLKDV_OUT);
   
   CLKFX_BUFG_INST : BUFG
      port map (I=>CLKFX_BUF,
                O=>CLKFX_OUT);
   
   CLKFX180_BUFG_INST : BUFG
      port map (I=>CLKFX180_BUF,
                O=>CLKFX180_OUT);
   
   CLKIN_IBUFG_INST : IBUFG
      port map (I=>CLKIN_IN,
                O=>CLKIN_IBUFG);
   
   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>CLKFB_IN);
   
   CLK2X_BUFG_INST : BUFG
      port map (I=>CLK2X_BUF,
                O=>CLK2X_OUT);
   
   CLK2X180_BUFG_INST : BUFG
      port map (I=>CLK2X180_BUF,
                O=>CLK2X180_OUT);
   
   CLK90_BUFG_INST : BUFG
      port map (I=>CLK90_BUF,
                O=>CLK90_OUT);
   
   CLK180_BUFG_INST : BUFG
      port map (I=>CLK180_BUF,
                O=>CLK180_OUT);
   
   CLK270_BUFG_INST : BUFG
      port map (I=>CLK270_BUF,
                O=>CLK270_OUT);
   
   DCM_ADV_INST : DCM_ADV
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => 2.0,
            CLKFX_DIVIDE => 4,
            CLKFX_MULTIPLY => 5,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 10.000,
            CLKOUT_PHASE_SHIFT => "NONE",
            DCM_AUTOCALIBRATION => TRUE,
            DCM_PERFORMANCE_MODE => "MAX_SPEED",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"F0F0",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE,
            SIM_DEVICE => "VIRTEX5")
      port map (CLKFB=>CLKFB_IN,
                CLKIN=>CLKIN_IBUFG,
                DADDR(6 downto 0)=>GND_BUS_7(6 downto 0),
                DCLK=>GND_BIT,
                DEN=>GND_BIT,
                DI(15 downto 0)=>GND_BUS_16(15 downto 0),
                DWE=>GND_BIT,
                PSCLK=>GND_BIT,
                PSEN=>GND_BIT,
                PSINCDEC=>GND_BIT,
                RST=>RST_IN,
                CLKDV=>CLKDV_BUF,
                CLKFX=>CLKFX_BUF,
                CLKFX180=>CLKFX180_BUF,
                CLK0=>CLK0_BUF,
                CLK2X=>CLK2X_BUF,
                CLK2X180=>CLK2X180_BUF,
                CLK90=>CLK90_BUF,
                CLK180=>CLK180_BUF,
                CLK270=>CLK270_BUF,
                DO(15 downto 0)=>DO_OUT(15 downto 0),
                DRDY=>open,
                LOCKED=>LOCKED_OUT,
                PSDONE=>open);
   
end BEHAVIORAL;

