----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/29/2024 03:20:12 AM
-- Design Name: 
-- Module Name: SM_Freq_Determiner - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SM_Freq_Determiner is
    Port ( increase : in STD_LOGIC;
           decrease : in STD_LOGIC;
           clk : in STD_LOGIC;
           freq : out integer range 1 to 255);
end SM_Freq_Determiner;

architecture Behavioral of SM_Freq_Determiner is
    signal incr, decr: STD_LOGIC;
    signal curr, nxt: integer := 1;
begin

    input_instance_inc: entity work.D_FlipFlop
        port map (
            D => increase,
            rst => '0',
            clk => clk,
            Q => incr
        );

    input_instance_dec: entity work.D_FlipFlop
        port map (
            D => decrease,
            rst => '0',
            clk => clk,
            Q => decr
        );

    dec_orInc: process(incr, decr)
    begin
        if curr = 1 or curr = 255 then
            nxt <= curr;
        else
            if incr = '1' and decr = '0' then
                nxt <= curr + 1;
            elsif decr = '1' and incr = '0' then
                nxt <= curr - 1;
            else
                nxt <= curr;
            end if;
        end if;
    end process;

    -- DFF for integer value
    output_instance: process(clk)
    begin
        if rising_edge(clk) then
            curr <= nxt;
        end if;
    end process;

    freq <= curr;
    

end Behavioral;
