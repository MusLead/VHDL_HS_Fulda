----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/29/2024 04:00:00 AM
-- Design Name: 
-- Module Name: TB_Crane_Control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for Crane_Control module
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
use IEEE.NUMERIC_STD.ALL;

entity tb_Crane_Control is
end tb_Crane_Control;

architecture Behavioral of tb_Crane_Control is

    -- Signals to connect to UUT
    signal direction_cw : STD_LOGIC := '0';
    signal stop_input : STD_LOGIC := '0';
    signal clk : STD_LOGIC := '0';
    signal step_enable : STD_LOGIC;
    signal step_frequency : integer range 1 to 255;

    -- Clock period definitions
    constant clk_period : time := 2_000_000 ns; 

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.Crane_Control
        Generic map (
            clk_frequency_in_hz => 500
        )
        Port map (
            direction_cw => direction_cw,
            stop_input => stop_input,
            clk => clk,
            step_enable => step_enable,
            step_frequency => step_frequency
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin	
        -- hold reset state for 100 ns.
        wait for 10 * clk_period;	

        -- Test Case 1: Move in CW direction
        direction_cw <= '1';
        stop_input <= '0';
        wait for 20 * clk_period;
        
        -- Test Case 2: Move in CCW direction
        direction_cw <= '0';
        wait for 20 * clk_period;

        -- Test Case 3: Apply stop signal
        stop_input <= '1';
        wait for 10 * clk_period;
        stop_input <= '0';

        -- Test Case 4: Move in CW direction again
        direction_cw <= '1';
        wait for 20 * clk_period;

        -- Test Case 5: Apply stop signal while moving in CW direction
        stop_input <= '1';
        wait for 10 * clk_period;
        stop_input <= '0';

        -- Test Case 6: Move in CCW direction
        direction_cw <= '0';
        wait for 20 * clk_period;
        
        -- End simulation
        wait;
    end process;

end Behavioral;
