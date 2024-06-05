----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2024 10:50:30
-- Design Name: 
-- Module Name: DFF (D-FlipFlop) - Behavioral
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

entity DFF is
--  Port ( );
    generic(
        sizeBit: integer := 8
    );
    port(
        d_i : in std_logic_vector(sizeBit - 1 downto 0);
        d_o : out std_logic_vector(sizeBit - 1 downto 0);
        clk_i : in std_logic
    );
end DFF;

architecture Behavioral of DFF is
    signal current_state: std_logic_vector(sizeBit - 1 downto 0) := (others => '0');
begin
    
    speicher_p : process(clk_i)
    begin
        if clk_i'event and clk_i = '1' then
            current_state <= d_i;
        end if;
    end process;
    
    d_o <= current_state;
end Behavioral;
