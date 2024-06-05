----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2024 11:26:46
-- Design Name: 
-- Module Name: DFF_tb - Behavioral
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

entity RSFF_tb is
--  Port ( );
end RSFF_tb;

architecture Behavioral of RSFF_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    constant sizeBit : integer := 8;
    component RSFF
        generic(
            sizeBit: integer := sizeBit
        );
        port(
            s_i : in std_logic_vector(sizeBit - 1 downto 0);
            r_i : in std_logic;
            q_o : out std_logic_vector(sizeBit - 1 downto 0);
            clk_i : in std_logic
        );
    end component;

    -- Inputs
    signal s_i : std_logic_vector(sizeBit - 1 downto 0) := (others => '0');
    signal clk_i, r_i : std_logic := '0';

    -- Outputs
    signal q_o : std_logic_vector(sizeBit - 1 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: RSFF
        generic map (
            sizeBit => sizeBit
        )
        port map (
            s_i => s_i,
            r_i => r_i,
            q_o => q_o,
            clk_i => clk_i
        );

    -- Clock process definitions
    clk_process : process
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
        wait for 100 ns;

        -- Test vector 1
        s_i <= "00000001";
        wait for clk_period*2;

        -- Test vector 2
        s_i <= "00000010";
        wait for clk_period*2;

        -- Test vector 3
        s_i <= "00000100";
        r_i <= '1';
        wait for clk_period*2;

        -- Test vector 4
        s_i <= "00001000";
        wait for clk_period*2;

        -- Test vector 5
        s_i <= "00010000";
        r_i <= '0';
        wait for clk_period*2;
        
        -- Test vector 5
        s_i <= "00100000";
        wait for clk_period*2;
        
        -- End of simulation
        wait;
    end process;

end Behavioral;
