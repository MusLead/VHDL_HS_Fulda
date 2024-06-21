----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 14:21:17
-- Design Name: 
-- Module Name: Volladdierer_tb - Behavioral
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

entity Volladdierer_tb is
--  Port ( );
end Volladdierer_tb;

architecture Behavioral of Volladdierer_tb is
    signal a,b,c,S,Co: std_logic;
    component Volladdierer
        port(a,b,c: in std_logic; S,Co: out std_logic);
    end component;
begin
    dut: Volladdierer port map(a=>a,b=>b,c=>c,S=>S,Co=>Co);
    
    stimulus: process
    begin
        a <= '1';
        b <= '0';
        c <= '0';
       wait for 50 ns;
        
       b <= '1';
       wait for 50 ns;
        
       a <= '0';
       wait for 50 ns;
 
       b <= '0';
       wait for 50 ns;
  end process;
    
end Behavioral;
