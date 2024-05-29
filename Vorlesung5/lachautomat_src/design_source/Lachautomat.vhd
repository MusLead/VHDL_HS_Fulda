----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2024 11:24:58
-- Design Name: 
-- Module Name: Lachautomat - Behavioral
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

entity Lachautomat is
    port( 
        rst_i : in std_logic; 
        clk_i : in std_logic; 
        witzig_i: in std_logic; 
        ascii_o : out std_logic_vector(7 downto 0) 
    );
end Lachautomat;

architecture Behavioral of Lachautomat is
    type state_t is (warte, output_H, output_A); 
    signal state, current_state, next_state : state_t;
begin
    speicher_p : process(rst_i, clk_i)
    begin
        if rst_i='1' then
            current_state <= warte;
        elsif clk_i'event and clk_i = '1' then
            current_state <= next_state;
        end if;
    end process;
    
    zuef_p: process(current_state, witzig_i) begin
        case current_state is 
            when warte => 
                if witzig_i='1' then
                    next_state <= output_H;
                else
                    next_state <= warte;
                end if;
            when output_H => 
                next_state <= output_A;
            when output_A =>
                if witzig_i='1' then
                    next_state <= output_H;
                else
                    next_state <= warte;
                end if;
        end case;
    end process;
    
    af_p: process(current_state)
    begin
        case current_state is
            when warte => 
                ascii_o <= x"00";
            when output_H => 
                ascii_o <= x"48";
            when output_A =>
                ascii_o <= x"41";
        end case;
    end process;

end Behavioral;
