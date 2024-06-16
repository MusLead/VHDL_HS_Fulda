library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Mod10_Counter_Sync is
--  Port ( );
end tb_Mod10_Counter_Sync;

architecture Behavioral of tb_Mod10_Counter_Sync is

    component Mod10_Counter_Sync
        Port (
            clk_i      : in STD_LOGIC;
            rst_i      : in STD_LOGIC;
            enable_i   : in STD_LOGIC;
            up_ndown_i : in STD_LOGIC;
            q_o        : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Test signals
    signal clk_i    : STD_LOGIC := '0';
    signal rst_i    : STD_LOGIC := '0';
    signal enable_i : STD_LOGIC := '0';
    signal up_ndown_i : STD_LOGIC := '1'; -- Start with counting up
    signal q_o      : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Mod10_Counter_Sync
        Port map (
            clk_i => clk_i,
            rst_i => rst_i,
            enable_i => enable_i,
            up_ndown_i => up_ndown_i,
            q_o => q_o
        );

    -- Clock process definitions
    clk_process : process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
        clk_i <= not clk_i;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply Reset
        rst_i <= '1';
        wait for 20 ns;
        rst_i <= '0';
        
        -- Enable and count up
        enable_i <= '1';
        up_ndown_i <= '1'; -- Count up
        wait for 100 ns; -- enough time to see several increments
        
        -- Switch to count down
        up_ndown_i <= '0';
        wait for 100 ns;

        -- Complete simulation
        wait;
    end process;

end Behavioral;
