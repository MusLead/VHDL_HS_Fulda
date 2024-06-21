library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Import numeric_std instead of std_logic_arith and std_logic_unsigned


entity Mod10_Counter is
    Port (
        clk_i      : in STD_LOGIC;
        rst_i      : in STD_LOGIC;
        enable_i   : in STD_LOGIC;
        q_o        : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mod10_Counter;

architecture Behavioral of Mod10_Counter is
    signal d_ff_inputs : STD_LOGIC_VECTOR(3 downto 0);
    signal internal_q  : STD_LOGIC_VECTOR(3 downto 0);
begin
    -- Generate the D flip-flops
    gen_ffs: for i in 0 to 3 generate
        dff: entity work.D_FlipFlop
            port map (
                clk => clk_i,
                rst => rst_i,
                D   => d_ff_inputs(i),
                Q   => internal_q(i)
            );
    end generate gen_ffs;

    -- Logic to determine the next state based on the current state
    process(internal_q, enable_i)
    begin
        if enable_i = '1' then
            case internal_q is
                when "1001" =>  -- When the counter reaches 9
                    d_ff_inputs <= "0000";  -- Roll over to 0
                when others =>
                    d_ff_inputs <= std_logic_vector(unsigned(internal_q) + 1);  -- Increment counter
            end case;
        else
            d_ff_inputs <= internal_q;  -- No change if enable is low
        end if;
    end process;

    -- Output assignment
    q_o <= internal_q;
end Behavioral;
