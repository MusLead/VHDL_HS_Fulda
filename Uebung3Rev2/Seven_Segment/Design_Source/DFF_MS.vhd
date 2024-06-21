library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Master-Slave D-Flip Flop Component
entity D_FlipFlop_MS is
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC
    );
end D_FlipFlop_MS;

architecture Behavioral of D_FlipFlop_MS is
    signal D_master : STD_LOGIC; -- Intermediate signal between master and slave
begin
    -- Master latch, captures input at rising edge
    process(clk, rst)
    begin
        if rst = '1' then
            D_master <= '0';
        elsif rising_edge(clk) then
            D_master <= D;
        end if;
    end process;

    -- Slave latch, transfers to output at falling edge
    process(clk, rst)
    begin
        if rst = '1' then
            Q <= '0';
        elsif falling_edge(clk) then
            Q <= D_master;
        end if;
    end process;
end Behavioral;
