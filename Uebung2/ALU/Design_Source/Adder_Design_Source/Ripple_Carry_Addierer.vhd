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
-- using VHDL Version 2008
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Ripple_Carry_Addierer is
--  Port ( );
    generic(
        sizeBit : integer := 4
    );
    port(
        sub: in std_logic;
        c_out,overflow: out std_logic;
        a,b: in std_logic_vector(sizeBit - 1 downto 0); 
        S: out std_logic_vector(sizeBit - 1 downto 0)
    );
end Ripple_Carry_Addierer;

architecture Behavioral of Ripple_Carry_Addierer is
    
    component Volladdierer is port(a,b,c: in std_logic; S,Co: out std_logic);
    end component;
    
    component xorGate is port(a,b: in std_logic; o: out std_logic);
    end component; 
    
    signal carry: std_logic_vector(sizeBit downto 0);
    signal y_n,S_default: std_logic_vector(sizeBit - 1 downto 0);
    signal res: std_logic;

begin
    -- this is for determining VOlladdierer whther the operation is adding or subtracting
    carry(0) <= sub;
    
    y_instance: for i in 0 to sizeBit - 1 generate
    
        xor_instance: xorGate
            port map(a => b(i), b => sub, o => y_n(i));
    
    end generate;
    
    rca_instance: for i in 0 to sizeBit - 1 generate 
        
        va_instance: Volladdierer
            port map(
                a => a(i), 
                b => y_n(i), 
                c => carry(i), 
                S => S_default(i), 
                Co => carry(i+1)
            );
            
    end generate;
    
    S <= S_default; -- Default assignment
    c_out <= carry(sizeBit);
    
    xor_checker: xorGate
    port map(
        a => carry(sizeBit), 
        b => carry(sizeBit - 1),
        o => overflow
    );

     

end Behavioral;
