----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2024
-- Design Name: 
-- Module Name: FPGA_integration_tb - Testbench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for FPGA_integration module
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FPGA_integration_tb is
-- Testbench has no ports
end FPGA_integration_tb;

architecture Behavioral of FPGA_integration_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component FPGA_integration
        generic( N_Running_Light, N_Button_takt : integer);
        Port ( 
            clk : in std_logic;
            enable_running_light: in std_logic;
            rst: in std_logic;
            running_lights: out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals to connect to the UUT
    signal clk_tb : std_logic := '0';
    signal enable_running_light_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal running_lights_tb : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns; -- 100 MHz clock

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: FPGA_integration
        generic map(
            N_Running_Light => 2,  -- Setting the generic parameter
            N_Button_takt => 1
        )
        port map (
            clk => clk_tb,
            enable_running_light => enable_running_light_tb,
            rst => rst_tb,
            running_lights => running_lights_tb
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk_tb <= '0';
        wait for clk_period/2;
        clk_tb <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin        
        -- hold reset state for 20 ns.
        rst_tb <= '1';
        wait for 20 ns;
        
        rst_tb <= '0';
        wait for 20 ns;
        
        -- enable running light
        enable_running_light_tb <= '1';
        wait for 100 ns;
        
        enable_running_light_tb <= '0';
        wait for 300 ns;
        
        enable_running_light_tb <= '1';
        wait for 50 ns;
        enable_running_light_tb <= '0';
        
        -- enable_running_light_tb <= '1';
        wait;
    end process;

end Behavioral;
