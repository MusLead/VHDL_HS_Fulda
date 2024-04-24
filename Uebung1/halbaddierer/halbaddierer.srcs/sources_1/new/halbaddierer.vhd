----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 11:52:50
-- Design Name: 
-- Module Name: halbaddierer - Behavioral
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

entity halbaddierer is
--  Port ( );
    port(a,b: in std_logic; S,Co: out std_logic);
end halbaddierer;

architecture Behavioral of halbaddierer is
    component andGate is port(a,b: in std_logic; o: out std_logic);
    end component;
    component xorGate is port(a,b: in std_logic; o: out std_logic);
    end component;
begin
   and_instance: andGate
        port map(a=>a, b=>b, o=>Co);
   xor_instance: xorGate
        port map(a=>a, b=>b, o=>S);

end Behavioral;
