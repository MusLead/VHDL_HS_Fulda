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
        clk_frequency_in_hz : integer := 125_000_000 -- Default frequency of 125 MHz
    );
    Port ( 
           clk : in STD_LOGIC;
           direction_cw : in STD_LOGIC;
           half_step_mode : in STD_LOGIC;
           rst : in STD_LOGIC,
           m: out STD_LOGIC_VECTOR(3 downto 0)
        );
end System_Integration;

architecture Behavioral of System_Integration is
    signal se_connection : STD_LOGIC;
begin

    sf_connection <= "00000100"

    SC_instance: entity work.Step_Control
        generic map (clk_frequency_in_hz => clk_frequency_in_hz)
        port map(
            clk => clk,
            rst => rst,
            step_frequency => sf_connection,
            step_enable => se_connection
        );

    SM_instance: entity work.Step_Motor
        port map(
            clk => clk,
            step_enable => se_connection, 
            direction_cw => direction_cw,
            half_step_mode => half_step_mode,
            output_motor => m;
        );

end Behavioral;
