library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Mod10_Counter is
end tb_Mod10_Counter;

architecture Behavioral of tb_Mod10_Counter is

    -- Component Declaration
    component Mod10_Counter
        Port (
            clk_i      : in STD_LOGIC;
            rst_i      : in STD_LOGIC;
            enable_i   : in STD_LOGIC;
            q_o        : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Test signals
    signal clk_i    : STD_LOGIC := '0';
    signal rst_i    : STD_LOGIC := '0';
    signal enable_i : STD_LOGIC := '0';
    signal q_o      : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Mod10_Counter
        Port map (
            clk_i => clk_i,
            rst_i => rst_i,
            enable_i => enable_i,
            q_o => q_o
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset
        rst_i <= '1';
        wait for 20 ns;
        rst_i <= '0';
        
        -- Enable and count
        enable_i <= '1';
        wait for 100 ns; -- Allow it to count through several cycles

        -- Disable and hold
        enable_i <= '0';
        wait for 30 ns;

        -- Enable again and count more
        enable_i <= '1';
        wait for 50 ns;

        -- Complete simulation
        wait;
    end process;

end Behavioral;
