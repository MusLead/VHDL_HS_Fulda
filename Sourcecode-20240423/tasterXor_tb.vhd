library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tasterXor_tb is
end tasterXor_tb;

architecture behavioral of tasterXor_tb is
    component tasterXor
        port(
            btn: in std_logic_vector(3 downto 0);
            led: out std_logic
        );
    end component;
    
    signal btn_tb: std_logic_vector(3 downto 0);
    signal led_tb: std_logic;
    
begin
    uut: tasterXor port map(btn => btn_tb, led => led_tb);
    
    stimulus: process 
    begin
        btn_tb <= "0001";
        wait for 50 ns;
        
        btn_tb <= "0010";
        wait for 50 ns;
        
        btn_tb <= "0100";
        wait for 50 ns;
        
        btn_tb <= "1000";
        wait for 50 ns;
 
        btn_tb <= "1001";
        wait for 50 ns;
       
        btn_tb <= "1010";
        wait for 50 ns;  
        
        -- ....  
    end process;
end behavioral;
