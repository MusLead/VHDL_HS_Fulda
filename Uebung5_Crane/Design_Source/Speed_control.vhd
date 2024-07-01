----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/27/2024 01:53:01 AM
-- Design Name: 
-- Module Name: Speed_Control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Speed control for a stepper motor using a counter and natural frequency input.
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
use IEEE.NUMERIC_STD.ALL; -- For numeric operations

entity Speed_Control is
    generic(
        clk_frequency_in_hz : integer := 125_000_000 -- Default frequency of 125 MHz
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        step_frequency : in integer range 1 to 255 := 1; -- 8-bit input for frequency
        step_enable : out std_logic
    );
end Speed_Control;

architecture Behavioral of Speed_Control is
    signal max_count : integer;
begin

    -- Convert frequency input from std_logic_vector to integer
    max_count <= clk_frequency_in_hz / (2 * step_frequency);

    -- Instance of Clock_Divider
    CLK_DIV: entity work.Clock_Divider_SM
        port map(
            clk_i => clk,
            reset => reset, -- if this '1', enable_o is 0 always
            max_count => max_count,
            enable_o => step_enable
        );

end Behavioral;
