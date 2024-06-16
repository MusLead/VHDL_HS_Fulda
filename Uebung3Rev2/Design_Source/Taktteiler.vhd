library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Taktteiler is
    generic (
        N : integer := 2  -- Teilungsfaktor
    );
    port (
        clk_i    : in  std_logic; -- Eingangstakt
        enable_o : out std_logic  -- Ausgabe-Steuersignal
    );
end Taktteiler;

architecture Behavioral of Taktteiler is
    signal counter : integer := 0;
begin
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if counter = (N-1) then
                enable_o <= '1';
                counter <= 0;
            else
                enable_o <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;
end Behavioral;