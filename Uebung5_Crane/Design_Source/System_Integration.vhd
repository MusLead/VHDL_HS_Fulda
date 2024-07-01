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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity System_Integration is
    Generic(
        N_Display : integer := 100_000; -- 125 MHz / 625 Hz = 200_000 per one period and divided by two!
        clk_frequency_in_hz : integer := 125_000_000 -- Default frequency of 125 MHz
    );
    Port ( 
           clk : in STD_LOGIC;
           direction_cw : in STD_LOGIC;
           half_step_mode : in STD_LOGIC;
           increase : in STD_LOGIC;
           decrease : in STD_LOGIC;
           rst : in STD_LOGIC;
           m: out STD_LOGIC_VECTOR(3 downto 0);
           SEG: out STD_LOGIC_VECTOR(6 downto 0);
           digit_sel: out STD_LOGIC_VECTOR(7 downto 0)
        );
end System_Integration;

architecture Behavioral of System_Integration is
    signal se_connection, clk_display : STD_LOGIC;
    signal sf_connection : integer range 1 to 255 := 1;
begin

    FD_instance: entity work.SM_Freq_Determiner
        port map(
            increase => increase,
            decrease => decrease,
            clk => clk,
            freq => sf_connection
        );

    clock_divider_display: entity work.Clock_Divider
        generic map (N => N_Display)  
        port map (
            clk_i => clk,
            enable_o => clk_display
        );

    SSD: entity work.Seven_Segment_Driver
        port map(
            clk => clk_display,
            input_int => sf_connection,
            SEG => SEG,
            digit_sel => digit_sel
        );

    SC_instance: entity work.Speed_Control
        generic map (clk_frequency_in_hz => clk_frequency_in_hz)
        port map(
            clk => clk,
            reset => rst,
            step_frequency => sf_connection,
            step_enable => se_connection
        );

    SM_instance: entity work.Step_Motor
        port map(
            clk => clk,
            step_enable => se_connection, 
            direction_cw => direction_cw,
            half_step_mode => half_step_mode,
            output_motor => m
        );

end Behavioral;
