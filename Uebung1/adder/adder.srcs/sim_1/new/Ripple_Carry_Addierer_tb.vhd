----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/09/2024 07:03:03 AM
-- Design Name: 
-- Module Name: Ripple_Carry_Addierer_tb - Behavioral
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

entity Ripple_Carry_Addierer_tb is
--  Port ( );
end Ripple_Carry_Addierer_tb;

architecture Behavioral of Ripple_Carry_Addierer_tb is
    constant sizeBit:integer := 8;
    component Ripple_Carry_Addierer
        generic(sizeBit:integer);
        port(
            sub: in std_logic;
            c_out: out std_logic;
            a,b: in std_logic_vector(sizeBit - 1 downto 0); 
            S: out std_logic_vector(sizeBit - 1 downto 0)
        );
   -- Signals for interfacing with the instantiated component
   end component;
   signal sub, c_out: std_logic;
   signal a, b, S: std_logic_vector(sizeBit - 1 downto 0);  -- Using sizeBit

-- Instantiate the Ripple_Carry_Addierer
begin
    uut: Ripple_Carry_Addierer
        generic map(sizeBit => sizeBit)
        port map(
            sub => sub,
            c_out => c_out,
            a => a,
            b => b,
            S => S
        );

-- Test stimulus process
stimulus: process
begin
    -- Test Case 1: Simple addition
    a <= (others => '0');
    b <= (others => '0');
    a(sizeBit-1 downto 4) <= "1010";  -- Setting part of the vector
    b(sizeBit-1 downto 4) <= "0101";
    sub <= '0';
    wait for 100 ns;

    -- Add more test cases as needed...

    -- Finish the simulation
    wait;
end process;


end Behavioral;
