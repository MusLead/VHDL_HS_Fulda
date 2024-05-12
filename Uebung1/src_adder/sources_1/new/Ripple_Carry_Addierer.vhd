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
    sizeBit : integer := 4;
    isSigned: boolean := false
);
port(
    sub: in std_logic;
    c_out,overflow,forbidden: out std_logic;
    a,b: in std_logic_vector(sizeBit - 1 downto 0); 
    S: out std_logic_vector(sizeBit - 1 downto 0)
);

end Ripple_Carry_Addierer;

architecture Behavioral of Ripple_Carry_Addierer is
    
    component Volladdierer is port(a,b,c: in std_logic; S,Co: out std_logic);
    end component;
    
    component xorGate is port(a,b: in std_logic; o: out std_logic);
    end component;
    
    component Comparator is 
    generic(n : integer := sizeBit);
    port(a,b: in std_logic_vector(sizeBit - 1 downto 0); b_greater_a: out std_logic);
    end component; 
    
    signal carry: std_logic_vector(sizeBit downto 0);
    signal y_n,S_default: std_logic_vector(sizeBit - 1 downto 0);
    signal a_unsigned, b_unsigned: unsigned(sizeBit - 1 downto 0); -- Conversion for safe comparison
    signal res, sub_gen: std_logic;

begin
    -- implement for in generate
    carry(0) <= sub;
    forbidden <= '0'; -- checker for unsigned 
    -- carry <= (others => '0');
    
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
     
    -- Overflow logic based on the signedness
    overflow_checker: if isSigned generate
        -- When signed
        xor_checker: xorGate
            port map(
                a => carry(sizeBit), 
                b => carry(sizeBit - 1),
                o => overflow
            );
    else generate -- this else fiture for 2008
        -- When unsigned
        -- Special case for unsigned subtraction where b > a
      compare_ab: Comparator
          port map(a => a,b => b, b_greater_a => res);
      forbidden <= res and sub; --fixme why the line is red with X?
       
      overflow <= carry(sizeBit) and not sub; -- this only works for addition, how about subs?  
    end generate overflow_checker;
        
    
     

end Behavioral;
