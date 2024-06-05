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

entity DFF_tb is
--  Port ( );
end DFF_tb;

architecture Behavioral of DFF_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    constant sizeBit : integer := 8;
    component DFF
        generic(
            sizeBit: integer := sizeBit
        );
        port(
            d_i : in std_logic_vector(sizeBit - 1 downto 0);
            d_o : out std_logic_vector(sizeBit - 1 downto 0);
            clk_i : in std_logic
        );
    end component;

    -- Inputs
    signal d_i : std_logic_vector(sizeBit - 1 downto 0) := (others => '0');
    signal clk_i : std_logic := '0';

    -- Outputs
    signal d_o : std_logic_vector(sizeBit - 1 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: DFF
        generic map (
            sizeBit => sizeBit
        )
        port map (
            d_i => d_i,
            d_o => d_o,
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
        d_i <= "00000001";
        wait for clk_period*2;

        -- Test vector 2
        d_i <= "00000010";
        wait for clk_period*2;

        -- Test vector 3
        d_i <= "00000100";
        wait for clk_period*2;

        -- Test vector 4
        d_i <= "00001000";
        wait for clk_period*2;

        -- Add more test vectors as needed
        wait for clk_period*2;
        
        -- End of simulation
        wait;
    end process;

end Behavioral;
