----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 13:20:52
-- Design Name: 
-- Module Name: halbaddierer_tb - Behavioral
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

entity halbaddierer_tb is
--  Port ( );
end halbaddierer_tb;

architecture Behavioral of halbaddierer_tb is
    signal a,b,S,Co: std_logic;
    component halbaddierer
        port(a,b: in std_logic; S,Co: out std_logic);
    end component;
begin
    dut: halbaddierer port map(a,b,S,Co);
    
    a <= '1', '0' after 10 ns, '1' after 20 ns; 
    b <= '0', '1' after 10 ns; 

end Behavioral;
