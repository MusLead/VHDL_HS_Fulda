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
        generic(
            sizeBit:integer;
            isSigned:boolean := false
        );
        port(
            sub: in std_logic;
            c_out, overflow, forbidden: out std_logic;
            a,b: in std_logic_vector(sizeBit - 1 downto 0); 
            S: out std_logic_vector(sizeBit - 1 downto 0)
        );
   -- Signals for interfacing with the instantiated component
   end component;
   signal sub, c_out, overflow, forbidden: std_logic;
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
            S => S,
            overflow => overflow,
            forbidden => forbidden
        );

-- Test stimulus process
    stimulus: process
    begin
        -- Test Case 1: Simple addition
        a <= "00001111";   -- Decimal 15
        b <= "00000101";   -- Decimal 5
        sub <= '1';
        wait for 100 ns;

        -- Test Case 2: Check carry out
        a <= "11111111";   -- Max value for 8-bit
        b <= "00000001";   -- Decimal 1
        sub <= '0';
        wait for 100 ns;

        -- Test Case 3: Subtraction with borrow
        a <= "00001111";   -- Decimal 15
        b <= "00010001";   -- Decimal 17 (more than 'a', requires borrow)
        sub <= '1';
        wait for 100 ns;

        -- Test Case 4: Overflow scenario
        a <= "10000000";   -- Decimal -128 (highest bit set)
        b <= "10000000";   -- Decimal -128 (highest bit set)
        sub <= '0';
        wait for 100 ns;

        -- Test Case 5: Zero inputs
        a <= (others => '0');
        b <= (others => '0');
        sub <= '0';
        wait for 100 ns;

        -- Test Case 6: Full-bit complement subtraction 
        -- (for signed, should be overflow because of the substraction)
        a <= "01010101";   -- Binary pattern
        b <= "10101010";   -- Complement of 'a'
        sub <= '1';
        wait for 100 ns;

        -- Test Case 7: Add boundary numbers
        a <= "01111111";   -- Max positive value for signed 8-bit without overflow
        b <= "00000001";   -- Increment to cause overflow in signed
        sub <= '0';
        wait for 100 ns;

        -- Test Case 8: Random input values
        a <= "00110011";
        b <= "11001100";
        sub <= '0';
        wait for 100 ns;

        -- Finish the simulation
        wait;
    end process;

end Behavioral;
