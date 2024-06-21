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
    component T_FlipFlop is 
        port(
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            T   : in STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component

    signal current_state, next_state: std_logic_vector(N-1 downto 0);
    signal enable: std_logic;
begin

    clk_instance: T_FlipFlop
        port map(
            clk => clk_i,
            rst => '0',
            T => enable_i,
            Q => enable
        );

    process(clk_i, rst_i, enable_i)
    begin
        if rst_i = '1' then 
            current_state <= (others => '1');
        elif enable = '1' then
            -- shift 0 into the current_state

    end process;
end Behavioral;
