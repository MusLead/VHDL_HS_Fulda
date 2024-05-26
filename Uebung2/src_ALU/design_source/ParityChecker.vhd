----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2024 11:33:09 PM
-- Design Name: 
-- Module Name: ParityChecker - Behavioral
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

entity ParityChecker is
    generic(
        sizeBit : integer := 4
    );
    port(
        a: in std_logic_vector(sizeBit - 1 downto 0); 
        isEven: out std_logic
    );
end ParityChecker;

architecture Behavioral of ParityChecker is
    signal result: std_logic_vector(sizeBit - 1 downto 0);
begin
    
    result(0) <= a(0) xor a(1);
    -- Assumption the sizeBit musst be more than 4!
    xor_looping: for i in 2 to sizeBit - 1 generate
        result(i - 1) <= result(i - 2) xor a(i);
    end generate;
    
    isEven <= result(sizeBit - 2);
end Behavioral;
