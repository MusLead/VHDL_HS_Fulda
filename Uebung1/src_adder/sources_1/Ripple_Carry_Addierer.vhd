----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.05.2024 11:45:59
-- Design Name: 
-- Module Name: Ripple_Carry_Addierer - Behavioral
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

entity Ripple_Carry_Addierer is
--  Port ( );
generic(sizeBit : integer);
port(
    sub: in std_logic;
    a,b: in std_logic_vector(sizeBit - 1 downto 0); 
    S: out std_logic_vector(sizeBit - 1 downto 0)
);

end Ripple_Carry_Addierer;

architecture Behavioral of Ripple_Carry_Addierer is
    component Volladdierrer is port(a,b,c: in std_logic; S,Co: out std_logic);
    end component;
    component xorGate is port(a,b: in std_logic; o: out std_logic);
    end component;
begin
    -- coba pakai for in generate 

end Behavioral;
