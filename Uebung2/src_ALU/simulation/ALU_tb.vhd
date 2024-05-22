----------------------------------------------------------------------------------
-- Testbench for ALU
-- Company:
-- Engineer:
--
-- Create Date: 05/13/2024 10:00:00 AM
-- Design Name:
-- Module Name: Test_ALU - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
-- Testing ALU with sizeBit set to 4.
--
-- Dependencies:
-- ALU module
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ALU_tb IS
END ALU_tb;

ARCHITECTURE behavior OF ALU_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ALU
        GENERIC(
            sizeBit : INTEGER := 4
        );
        PORT(
            codex: IN  std_logic_vector(2 downto 0);
            flag: OUT std_logic_vector(3 downto 0);
            a, b: IN  std_logic_vector(3 downto 0);
            O: OUT std_logic_vector(3 downto 0);
            C: OUT std_logic
        );
    END COMPONENT;

    -- Inputs
    signal a, b : std_logic_vector(3 downto 0);
    signal codex : std_logic_vector(2 downto 0);

    -- Outputs
    signal O : std_logic_vector(3 downto 0);
    signal C : std_logic;
    signal flag : std_logic_vector(3 downto 0);

    -- Instantiate the Unit Under Test (UUT)
    BEGIN
        uut: ALU PORT MAP (
            codex => codex,
            flag => flag,
            a => a,
            b => b,
            O => O,
            C => C
        );

    -- Test Stimulus
    stimulus: PROCESS
    BEGIN
        -- Initialize Inputs
        a <= "0000";
        b <= "0000";
        codex <= "000"; -- Testing addition
        wait for 10 ns;
        --ASSERT C /= '1' REPORT "" SEVERITY NOTE;
        
        a <= "0011";
        b <= "0101";        
        codex <= "000"; -- Testing subtraction
        wait for 10 ns;

        codex <= "010"; -- Testing AND
        wait for 10 ns;

        codex <= "011"; -- Testing OR
        wait for 10 ns;

        codex <= "100"; -- Testing XOR
        wait for 10 ns;

        codex <= "101"; -- Testing NOR
        wait for 10 ns;

        codex <= "110"; -- Testing NAND
        wait for 10 ns;

        codex <= "111"; -- Testing NOT
        wait for 10 ns;

        -- Test Complete
        ASSERT FALSE REPORT "Test completed!" SEVERITY NOTE;
        wait;
    END PROCESS stimulus;

END behavior;
