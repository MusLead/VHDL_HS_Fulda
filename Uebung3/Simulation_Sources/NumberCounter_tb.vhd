----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2024 11:35:57 PM
-- Design Name: 
-- Module Name: NumberCounter_tb - Behavioral
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

entity NumberCounter_tb is
end NumberCounter_tb;

architecture Behavioral of NumberCounter_tb is
    constant sizeBit: integer := 5;
    component NumberCounter
        Port (
            clk_i      : in  std_logic;
            rst_i      : in  std_logic;
            enable_i   : in  std_logic;
            q_o        : out std_logic_vector(sizeBit - 1 downto 0)
        );
    end component;
    
    signal clk_i     : std_logic := '0';
    signal rst_i     : std_logic := '0';
    signal enable_i  : std_logic := '0';
    signal q_o       : std_logic_vector(sizeBit - 1 downto 0);
    
    constant clk_period : time := 10 ns;
    
begin
    uut: NumberCounter
        Port map (
            clk_i     => clk_i,
            rst_i     => rst_i,
            enable_i  => enable_i,
            q_o       => q_o
        );
    
    clk_process : process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
    end process;
    
    stimulus : process
    begin
        rst_i <= '1';
        enable_i <= '0';
        wait for 20 ns;
        
        rst_i <= '0';
        enable_i <= '1';
        wait for 150 ns; -- Allow multiple cycles
        
        enable_i <= '0';
        wait for 20 ns;
        
        enable_i <= '1';
        wait for 100 ns;
        
        rst_i <= '1';
        wait for 20 ns;
        
        rst_i <= '0';
        wait;
    end process;
end Behavioral;
