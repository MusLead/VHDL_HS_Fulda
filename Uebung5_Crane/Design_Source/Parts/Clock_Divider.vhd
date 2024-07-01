library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clock_Divider is
    generic (
        N : integer := 2  -- Teilungsfaktor
    );
    port (
        clk_i    : in  std_logic; -- Eingangstakt
        enable_o : out std_logic  -- Ausgabe-Steuersignal
    );
end Clock_Divider;

architecture Behavioral of Clock_Divider is
    signal counter : integer := 0;
    signal out_sig : std_logic := '1';
begin
    
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if counter = (N-1) then
                out_sig <= '1';
                counter <= 0;
            else
                out_sig <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;
    enable_o <= out_sig;
end Behavioral;