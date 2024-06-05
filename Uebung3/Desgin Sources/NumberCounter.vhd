----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.06.2024 12:43:57
-- Design Name: 
-- Module Name: NumberCounter - Behavioral
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

entity NumberCounter is
--  Port ( );
    port(
        enable_i : in std_logic;
        rst_i : in std_logic;
        q_o : out std_logic_vector(2 downto 0);
        clk_i : in std_logic
    );
end NumberCounter;

architecture Behavioral of NumberCounter is
    constant sizeBit : integer := 3;
    
    component Ripple_Carry_Addierer
        generic(
            sizeBit:integer := sizeBit
        );
        port(
            sub: in std_logic;
            c_out, overflow: out std_logic;
            a,b: in std_logic_vector(sizeBit - 1 downto 0); 
            S: out std_logic_vector(sizeBit - 1 downto 0)
        );
   end component;
   
   component RSFF
        generic(
            sizeBit: integer := sizeBit
        );
        port(
            s_i : in std_logic_vector(sizeBit - 1 downto 0);
            r_i : in std_logic;
            q_o : out std_logic_vector(sizeBit - 1 downto 0);
            clk_i : in std_logic
        );
    end component;
    
   signal  c_out, overflow: std_logic;
   signal current_state, next_state, currentEnable: std_logic_vector(sizeBit - 1 downto 0);  -- Using sizeBit
begin


    currentEnable <= "00" & enable_i;
    
    counter: Ripple_Carry_Addierer
        generic map(sizeBit => sizeBit)
        port map(
            sub => '0',
            c_out => c_out,
            a => currentEnable,
            b => current_state,
            S => next_state,
            overflow => overflow
        );
     
end Behavioral;
