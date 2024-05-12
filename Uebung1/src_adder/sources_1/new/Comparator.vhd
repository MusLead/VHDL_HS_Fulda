----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2024 08:40:37 PM
-- Design Name: 
-- Module Name: Comparator - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Comparator is
    generic (n : integer := 4);  -- Default bit width
    port (
        a : in std_logic_vector(n-1 downto 0);
        b : in std_logic_vector(n-1 downto 0);
        b_greater_a : out std_logic  -- Output now indicates if b > a
    );
end Comparator;

architecture Behavioral of Comparator is
    signal greater : std_logic_vector(n-1 downto 0);
    signal result : std_logic;
begin

    -- Generating the logic for each bit from MSB to LSB
    gen_comparator: for i in n-1 downto 0 generate
        eq_chain: if i = n-1 generate
            -- Direct comparison for the most significant bit, now b(i) > a(i)
            greater(i) <= b(i) and not a(i);
        else generate
            -- Generate cascaded equality check for all higher bits
            signal higher_bits_equal : std_logic := '1';
            begin
                eq_loop: for k in n-1 downto i+1 generate
                    begin
                        higher_bits_equal <= higher_bits_equal and (b(k) xnor a(k));
                    end generate eq_loop;

                -- Use higher_bits_equal to enable the current bit comparison, now b(i) > a(i)
                greater(i) <= higher_bits_equal and b(i) and not a(i);
            end;
        end generate eq_chain;
    end generate gen_comparator;
    
    result <= '0';
    -- Aggregate all individual bit comparisons to determine if b > a
    bits_checker: for i in n-1 downto 0 generate
        result <= result or greater(i);
    end generate;
    b_greater_a <= result;
    -- b_greater_a <= or_reduce(greater)

end Behavioral;
