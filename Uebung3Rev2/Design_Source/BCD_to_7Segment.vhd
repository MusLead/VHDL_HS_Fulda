library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_to_7Segment is
    Port ( BCD : in  STD_LOGIC_VECTOR (3 downto 0);
           SEG : out STD_LOGIC_VECTOR (6 downto 0));
end BCD_to_7Segment;

architecture Behavioral of BCD_to_7Segment is
begin
    process(BCD)
    begin
        case BCD is
            when "0000" => SEG <= "0000001"; -- 0
            when "0001" => SEG <= "1001111"; -- 1
            when "0010" => SEG <= "0010010"; -- 2
            when "0011" => SEG <= "0000110"; -- 3
            when "0100" => SEG <= "1001100"; -- 4
            when "0101" => SEG <= "0100100"; -- 5
            when "0110" => SEG <= "0100000"; -- 6
            when "0111" => SEG <= "0001111"; -- 7
            when "1000" => SEG <= "0000000"; -- 8
            when "1001" => SEG <= "0000100"; -- 9
            when others => SEG <= "0110000"; -- E (Invalid BCD)
        end case;
    end process;
end Behavioral;
