----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/29/2024 01:17:40 PM
-- Design Name: 
-- Module Name: tb_Seven_Segment_Driver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity tb_Seven_Segment_Driver is
end tb_Seven_Segment_Driver;

architecture tb_arch of tb_Seven_Segment_Driver is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;  -- Clock period

    -- Signals for testbench
    signal clk         : STD_LOGIC := '0';  -- Clock signal
    signal input_int   : integer range 1 to 255 := 1;  -- Input integer signal
    signal SEG         : STD_LOGIC_VECTOR(6 downto 0);  -- 7-segment outputs
    signal digit_sel   : STD_LOGIC_VECTOR(7 downto 0);  -- Digit selection signals

begin
     -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    process
    begin
        wait for 20 ns;  -- Wait for initial stabilization

        -- Test case 1: Input 123
        input_int <= 123;
        wait for 100 ns;

        -- Test case 2: Input 42
        input_int <= 42;
        wait for 100 ns;

        -- Test case 3: Input 255
        input_int <= 255;
        wait for 100 ns;

        -- Additional test cases can be added here

        wait;
    end process;

    -- Connect the entity to signal
    UUT : entity work.Seven_Segment_Driver
        port map (
            clk         => clk,
            input_int   => input_int,
            SEG         => SEG,
            digit_sel   => digit_sel
        );

end tb_arch;


