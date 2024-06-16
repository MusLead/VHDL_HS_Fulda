library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Import numeric_std instead of std_logic_arith and std_logic_unsigned

-- TODO: reduce the logic gates in every input of the D flip-flops
entity Mod10_Counter_Sync is
    Port (
        clk_i      : in STD_LOGIC;
        rst_i      : in STD_LOGIC;
        enable_i   : in STD_LOGIC;
        up_ndown_i : in STD_LOGIC; -- 1 for count up, 0 for count down
        q_o        : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Mod10_Counter_Sync;

architecture Behavioral of Mod10_Counter_Sync is

    component D_FlipFlop is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal internal_q  : STD_LOGIC_VECTOR(3 downto 0);
    signal d_ff_inputs : STD_LOGIC_VECTOR(3 downto 0);
    signal A, B, C, D, U : STD_LOGIC;
    signal clk : STD_LOGIC;
begin
    
    clk <= enable_i and clk_i;
    U <= up_ndown_i;
    d_ff_inputs(0) <= (not(A) and not(D)) or (not(B) and not(C) and not(D));
    d_ff_inputs(1) <= (C and D and not(A) and not(U)) or (C and U and not(A) and not(D)) or (D and U and not(A) and not(C)) or (A and not(B) and not(C) and not(D) and not(U)) or (B and not(A) and not(C) and not(D) and not(U));
    d_ff_inputs(2) <= (B and C and not(A) and not(D)) or (B and D and not(A) and not(U)) or (B and U and not(A) and not(C)) or (C and D and U and not(A) and not(B)) or (A and not(B) and not(C) and not(D) and not(U));
    d_ff_inputs(3) <= (B and C and D and U and not(A)) or (A and D and not(B) and not(C) and not(U)) or (A and U and not(B) and not(C) and not(D)) or (not(A) and not(B) and not(C) and not(D) and not(U));
    
    -- Generate the D flip-flops
    dff_0:  D_FlipFlop
        port map (
            clk => clk,
            rst => rst_i,
            D   => d_ff_inputs(0),
            Q   => D
        );
    
    dff_1:  D_FlipFlop
        port map (
            clk => clk,
            rst => rst_i,
            D   => d_ff_inputs(1) ,
            Q   => C
        );

    dff_2:  D_FlipFlop
        port map (
            clk => clk,
            rst => rst_i,
            D   => d_ff_inputs(2) ,
            Q   => B
        );

    dff_3:  D_FlipFlop
        port map (
            clk => clk,
            rst => rst_i,
            D   => d_ff_inputs(3) ,
            Q   => A
        );
    
    internal_q(0) <= D;
    internal_q(1) <= C;
    internal_q(2) <= B;
    internal_q(3) <= A;

    -- Output assignment
    q_o <= internal_q;
end Behavioral;
