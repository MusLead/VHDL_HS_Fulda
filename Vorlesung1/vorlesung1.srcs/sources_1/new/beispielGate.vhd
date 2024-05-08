----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.04.2024 11:32:49
-- Design Name: 
-- Module Name: beispielGate - Behavioral
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

entity beispielGate is
  port (a, b, c: in std_logic; o, x: out std_logic); 
end beispielGate;

architecture Behavioral of beispielGate is 
    component and_gate is port (i0,i1:in std_logic; o: out std_logic); 
    end component; 
    component xor_gate is port (i0,i1:in std_logic; o: out std_logic); 
    end component; 
    signal s: std_logic; 
begin 
    and_instance: and_gate 
        port map(i0=>a, i1=>b, o=>s); 
    xor_instance: xor_gate 
        port map(i0=>s, i1=>c, o=>x); 
end architecture;
