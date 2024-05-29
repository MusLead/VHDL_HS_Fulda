----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2024 11:24:58
-- Design Name: 
-- Module Name: Lachautomat_tb - Testbench
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

entity Lachautomat_tb is
--  Port ( );
end Lachautomat_tb;

architecture Behavioral of Lachautomat_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component Lachautomat
    port(
         rst_i : in std_logic;
         clk_i : in std_logic;
         witzig_i : in std_logic;
         ascii_o : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Inputs
    signal rst_i : std_logic := '0';
    signal clk_i : std_logic := '0';
    signal witzig_i : std_logic := '0';

    -- Outputs
    signal ascii_o : std_logic_vector(7 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Lachautomat port map (
          rst_i => rst_i,
          clk_i => clk_i,
          witzig_i => witzig_i,
          ascii_o => ascii_o
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 20 ns.
        rst_i <= '1';
        wait for 20 ns;  
        rst_i <= '0';

        wait for 20 ns;

        -- Test case 1: witzig_i high
        witzig_i <= '1';
        wait for 20 ns;
        witzig_i <= '0';
        wait for 20 ns;

        -- Test case 2: witzig_i high again to toggle state
        witzig_i <= '1';
        wait for 20 ns;
        witzig_i <= '0';
        wait for 20 ns;

        -- Test case 3: No input, should remain in 'warte' state
        witzig_i <= '0';
        wait for 40 ns;

        -- Test case 4: Reset during operation
        witzig_i <= '1';
        wait for 10 ns;
        rst_i <= '1';
        wait for 10 ns;
        rst_i <= '0';
        witzig_i <= '0';
        
        wait for 50 ns;

        -- Stop simulation
        wait;
    end process;

end Behavioral;
