library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- T-Flip Flop Component
entity T_FlipFlop is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        T   : in STD_LOGIC;
        Q   : out STD_LOGIC
    );
end T_FlipFlop;

architecture Behavioral of T_FlipFlop is
    signal Q_int : STD_LOGIC := '0';
begin
    -- Process to handle the toggling based on T input
    process(clk, rst)
    begin
        if rst = '1' then
            Q_int <= '0';
        elsif rising_edge(clk) then
            if T = '1' then
                Q_int <= not Q_int;
            end if;
        end if;
    end process;

    Q <= Q_int;
end Behavioral;
