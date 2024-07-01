----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/29/2024 04:22:34 AM
-- Design Name: 
-- Module Name: tb_System_Integration - Behavioral
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
-- Testbench for System_Integration

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_System_Integration IS
END tb_System_Integration;

ARCHITECTURE behavior OF tb_System_Integration IS 

    -- Inputs
    signal clk : std_logic := '0';
    signal direction_cw : std_logic := '0';
    signal rst : std_logic := '0';

    -- Outputs
    signal m : std_logic_vector(3 downto 0);
    signal SEG : std_logic_vector(6 downto 0);
    signal digit_sel : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period : time := 2 ms;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.System_Integration
    GENERIC MAP (
        N_Display => 5,
        clk_frequency_in_hz => 500
    )
    PORT MAP (
        clk => clk,
        direction_cw => direction_cw,
        stop_button => rst,
        m => m,
        SEG => SEG,
        digit_sel => digit_sel
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
        rst <= '1';
        wait for 50 * clk_period;
        rst <= '0';
        
        -- Change direction and mode
        direction_cw <= '1';
        wait for 20 * clk_period;
        
        wait for 10 * clk_period;

        wait for 20 * clk_period;

        wait for 10 * clk_period;

        wait for 20 * clk_period;

        direction_cw <= '0';
        wait for 20 * clk_period;

        -- Finish simulation
        wait for 50 * clk_period;
        wait;
    end process;

END;
