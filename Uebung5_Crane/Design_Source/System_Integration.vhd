----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2024 09:22:48 AM
-- Design Name: 
-- Module Name: System_Integration - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity System_Integration is
  generic
  (
    N_Display           : integer := 100_000; -- 125 MHz / 625 Hz = 200_000 per one period and divided by two!
    clk_frequency_in_hz : integer := 125_000_000 -- Default frequency of 125 MHz
  );
  port
  (
    clk          : in std_logic;
    direction_cw : in std_logic;
    stop_button  : in std_logic;
    magnet_in    : in std_logic;
    magnet_out   : out std_logic;
    magnet_led   : out std_logic;
    m            : out std_logic_vector(3 downto 0);
    SEG          : out std_logic_vector(6 downto 0);
    digit_sel    : out std_logic_vector(7 downto 0)
  );
end System_Integration;

architecture Behavioral of System_Integration is
  signal se_connection, clk_display : std_logic;
  signal sf_connection              : integer range 1 to 255 := 1;
  signal magnet_out_signal           : std_logic              := '0';
  signal clk_magnet                 : std_logic;
begin

  clock_divider_magnet : entity work.Clock_Divider
    generic
    map (N => 15_625_000)
    port map
    (
      clk_i    => clk,
      enable_o => clk_magnet
    );

  magnet_toggle : entity work.ButtonToggle
    port
    map (
    clk    => clk_magnet,
    button => magnet_in,
    led    => magnet_out_signal
    );

    magnet_out <= magnet_out_signal;
    magnet_led <= magnet_out_signal;

  Crane_instance : entity work.Crane_Control
    generic
    map (
    clk_frequency_in_hz => clk_frequency_in_hz
    )
    port
    map(
    direction_cw   => direction_cw,
    stop_input     => stop_button,
    clk            => clk,
    step_enable    => se_connection,
    step_frequency => sf_connection
    );

  clock_divider_display : entity work.Clock_Divider
    generic
    map (N => N_Display)
    port
    map (
    clk_i    => clk,
    enable_o => clk_display
    );

  SSD : entity work.Seven_Segment_Driver
    port
    map(
    clk       => clk_display,
    input_int => sf_connection,
    SEG       => SEG,
    digit_sel => digit_sel
    );

  SM_instance : entity work.Step_Motor
    port
    map(
    clk            => clk,
    step_enable    => se_connection,
    direction_cw   => direction_cw,
    half_step_mode => '1',
    output_motor   => m
    );

end Behavioral;