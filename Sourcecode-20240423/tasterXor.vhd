library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tasterXor is
port ( btn : in std_logic_vector(3 downto 0); 
led : out std_logic);
end tasterXor ;

architecture behavioral of tasterXor is
begin
    led <= (((btn(0) xor btn(1)) xor btn(2)) xor btn(3)); --- led aktiviert bei 1 oder 3 gedr�ckten Tastern
end behavioral ;
