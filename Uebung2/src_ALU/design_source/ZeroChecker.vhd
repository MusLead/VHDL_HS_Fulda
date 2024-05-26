----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/27/2024 12:13:45 AM
-- Design Name: 
-- Module Name: ZeroChecker - Behavioral
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

entity ZeroChecker is
--  Port ( );
generic(
        sizeBit : integer := 4
    );
    port(
        a: in std_logic_vector(sizeBit - 1 downto 0); 
        isZero: out std_logic
    );
end ZeroChecker;

architecture Behavioral of ZeroChecker is
    signal result: std_logic_vector(sizeBit - 1 downto 0);
begin
    
    result(0) <= a(0) or a(1);
    -- Assumption the sizeBit musst be more than 4!
    xor_looping: for i in 2 to sizeBit - 1 generate
        result(i - 1) <= result(i - 2) or a(i);
    end generate;
    
    isZero <= not result(sizeBit - 2);
end Behavioral;
