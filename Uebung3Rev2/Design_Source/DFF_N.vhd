library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Declare the entity with generic to specify the number of bits N
entity D_FlipFlop_NBits is
    Generic (N : natural := 8); -- Default to an 8-bit flip-flop, can be changed as required
    Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        D   : in STD_LOGIC_VECTOR(N-1 downto 0); -- Input D is now an N-bit vector
        Q   : out STD_LOGIC_VECTOR(N-1 downto 0) -- Output Q is also an N-bit vector
    );
end D_FlipFlop_NBits;

-- Implement the behavioral architecture
architecture Behavioral of D_FlipFlop_NBits is
    signal Q_sig : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0'); -- Initialize Q_sig to 0 for all bits
begin
    process(clk, rst)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                Q_sig <= (others => '0'); -- Reset all bits of Q_sig to 0
            else
                Q_sig <= D; -- Assign the input vector D to the signal Q_sig
            end if;
        end if;
    end process;

    Q <= Q_sig; -- Output the value of Q_sig
end Behavioral;
