library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FlipFlop is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC
    );
end D_FlipFlop;

architecture Behavioral of D_FlipFlop is
    signal Q_sig : STD_LOGIC := '0';
begin
    process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                Q_sig <= '0';
            else
                Q_sig <= D;
            end if;
        end if;
    end process;

    Q <= Q_sig;
end Behavioral;
