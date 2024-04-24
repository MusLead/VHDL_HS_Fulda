----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 12:06:18
-- Design Name: 
-- Module Name: testBranch - Behavioral
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

entity testBranch is
--  Port ( );
end testBranch;

architecture Behavioral of testBranch is
    signal a,b,c,x: std_logic;
    component beispielGate
        port(a,b,c: in std_logic; x: out std_logic);
    end component;
begin
    dut: beispielGate port map(a,b,c,x);
    
a <= '1', '0' after 10 ns, '1' after 20 ns; 
b <= '0', '1' after 10 ns, '0' after 20 ns; 
c <= '1', '0' after 10 ns, '1' after 20 ns;
end Behavioral;
