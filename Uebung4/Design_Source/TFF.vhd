library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- T-Flip Flop Component
entity T_FlipFlop is
    port (
        clk : in std_logic;
        rst : in std_logic;
        T : in std_logic;
        Q : out std_logic
    );
end T_FlipFlop;

architecture Behavioral of T_FlipFlop is
    signal tmp : std_logic := '0';
begin
    process (clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                tmp <= '0';
            end if;
            if T = '0' then
                tmp <= tmp;
            elsif T = '1' then
                tmp <= not (tmp);
            end if;
        end if;
    end process;
    Q <= tmp;
end Behavioral;