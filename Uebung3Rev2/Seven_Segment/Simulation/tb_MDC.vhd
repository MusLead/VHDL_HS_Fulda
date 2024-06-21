----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2024 15:45:16
-- Design Name: 
-- Module Name: tb_MDC - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Multi_Digit_Counter_tb IS
END Multi_Digit_Counter_tb;

ARCHITECTURE behavior OF Multi_Digit_Counter_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Multi_Digit_Counter
    PORT(
        clk_i : IN  std_logic;
        rst_i : IN  std_logic;
        enable_i : IN  std_logic;
        up_ndown_i : IN  std_logic;
        ones_o : OUT  std_logic_vector(3 downto 0);
        tens_o: OUT  std_logic_vector(3 downto 0);
        hundreds_o : OUT  std_logic_vector(3 downto 0);
        thousands_o : OUT  std_logic_vector(3 downto 0)
    );
    END COMPONENT;
    
    --Inputs
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal enable_i : std_logic := '0';
    signal up_ndown_i : std_logic := '0';

    --Outputs
    signal ones_o : std_logic_vector(3 downto 0);
    signal tens_o : std_logic_vector(3 downto 0);
    signal hundreds_o : std_logic_vector(3 downto 0);
    signal thousands_o : std_logic_vector(3 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;
 
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: Multi_Digit_Counter PORT MAP (
        clk_i => clk_i,
        rst_i => rst_i,
        enable_i => enable_i,
        up_ndown_i => up_ndown_i,
        ones_o => ones_o,
        tens_o => tens_o,
        hundreds_o => hundreds_o,
        thousands_o => thousands_o
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
        -- hold reset state for 100 ns.
        rst_i <= '1';
        wait for 100 ns;  
        rst_i <= '0';  

        -- Enable the counter and count up
        enable_i <= '1';
        up_ndown_i <= '1';  -- Count up
        wait for 1000 ns;

        -- Change direction: count down
        up_ndown_i <= '0';  -- Count down
        wait for 500 ns;

        -- Test reset while counting
        rst_i <= '1';
        wait for 100 ns;
        rst_i <= '0';
        
        wait for 100 ns;
        up_ndown_i <= '1';  -- Count up
        

        wait; -- will wait forever
    end process;

END;

