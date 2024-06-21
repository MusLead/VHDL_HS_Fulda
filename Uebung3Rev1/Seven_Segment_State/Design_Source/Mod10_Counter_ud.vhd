library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mod10_Counter_ud is
    Port (
        clk_i      : in STD_LOGIC;
        rst_i      : in STD_LOGIC;
        enable_i   : in STD_LOGIC;
        up_ndown_i : in STD_LOGIC; -- 1 for count up, 0 for count down
        q_o        : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mod10_Counter_ud;

architecture Behavioral of Mod10_Counter_ud is
    component D_FlipFlop is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal internal_q  : STD_LOGIC_VECTOR(3 downto 0);
    signal d_inputs    : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instanzieren der D-Flipflops
    gen_ff: for i in 0 to 3 generate
        dff: D_FlipFlop
            port map (
                clk => clk_i,
                rst => rst_i,
                D   => d_inputs(i),
                Q   => internal_q(i)
            );
    end generate;

    -- Logik zur Bestimmung des naechsten Zustands abhaengig von der Zaehlrichtung
    process(internal_q, enable_i, up_ndown_i)
    begin
        if enable_i = '1' then
            if up_ndown_i = '1' then  -- Zaehlen aufwaerts
                if internal_q = "1001" then
                    d_inputs <= "0000";  -- Zuruecksetzen auf 0, wenn 9 erreicht ist
                else
                    d_inputs <= std_logic_vector(unsigned(internal_q) + 1);
                end if;
            else  -- Zaehlen abwaerts
                if internal_q = "0000" then
                    d_inputs <= "1001";  -- Zuruecksetzen auf 9, wenn 0 erreicht ist
                else
                    d_inputs <= std_logic_vector(unsigned(internal_q) - 1);
                end if;
            end if;
        else
            d_inputs <= internal_q;  -- No change if enable is low
        end if;
    end process;

    q_o <= internal_q; -- Ausgabe des aktuellen Zählerstandes
end Behavioral;
