----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2024 13:57:20
-- Design Name: 
-- Module Name: Running_Light - Behavioral
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

entity Running_Light is
--  Port ( );
    generic (N: integer := 4);
    port(clk_i,rst_i,enable_i: in std_logic; lights_o: out std_logic_vector(N-1 downto 0);
end Running_Light;

architecture Behavioral of Running_Light is
    signal current_state, next_state: std_logic_vector(N-1 downto 0);
begin
    process(clk_i, rst_i, enable_i)
end Behavioral;
