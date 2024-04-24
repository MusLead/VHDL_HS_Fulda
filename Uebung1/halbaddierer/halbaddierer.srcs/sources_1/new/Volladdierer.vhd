----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 13:45:45
-- Design Name: 
-- Module Name: Volladdierer - Behavioral
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

entity Volladdierer is
--  Port ( );
    port(a,b,c: in std_logic; S,Co: out std_logic);
end Volladdierer;

architecture Behavioral of Volladdierer is
    component halbaddierer is port(a,b: in std_logic; S,Co: out std_logic);
    end component;
    component orGate is port(a,b: in std_logic; o: out std_logic);
    end component;
    signal sHA_sig,c1_sig,c2_sig: std_logic; --TODO ASK: man braucht keine in, oout, or inout, correct?? 
begin
    ha1_instance: halbaddierer
        port map(a=>a,b=>b,S=>sHA_sig,Co=>c1_sig);
    ha2_instance: halbaddierer
        port map(a=>sHA_sig,b=>c,S=>S,Co=>c2_sig);
    or_instance: orGate
        port map(a=>c1_sig,b=>c2_sig,o=>Co);
end Behavioral;
