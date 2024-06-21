library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Running_Light is
end tb_Running_Light;

architecture Behavioral of tb_Running_Light is

    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal enable_i : std_logic := '0';
    signal lights_o : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

    component Running_Light
        generic (N: integer := 8);
        port(
            clk_i : in std_logic;
            rst_i : in std_logic;
            enable_i : in std_logic;
            lights_o : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    uut: Running_Light
        generic map (N => 4)
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            enable_i => enable_i,
            lights_o => lights_o
        );

    -- Clock process
    clk_process : process
    begin
        clk_i <= '0';
        wait for clk_period / 2;
        clk_i <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        rst_i <= '1';
        enable_i <= '0';
        wait for 20 ns;
        rst_i <= '0';

        -- Enable running light
        enable_i <= '1';
        wait for 10 ns;
        
        -- Disable running light
        enable_i <= '0';
        wait for 50 ns;

        -- Enable running light again
        enable_i <= '1';
        wait for 100 ns;

        -- End simulation
        wait;
    end process stim_proc;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Running_Light is
end tb_Running_Light;

architecture Behavioral of tb_Running_Light is

    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal enable_i : std_logic := '0';
    signal lights_o : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;

    component Running_Light
        generic (N: integer := 4);
        port(
            clk_i : in std_logic;
            rst_i : in std_logic;
            enable_i : in std_logic;
            lights_o : out std_logic_vector(N-1 downto 0)
        );
    end component;

begin

    uut: Running_Light
        generic map (N => 4)
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            enable_i => enable_i,
            lights_o => lights_o
        );

    -- Clock process
    clk_process : process
    begin
        clk_i <= '0';
        wait for clk_period / 2;
        clk_i <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize
        rst_i <= '1';
        enable_i <= '0';
        wait for 20 ns;
        rst_i <= '0';

        -- Enable running light
        enable_i <= '1';
        wait for 100 ns;
        
        -- Disable running light
        enable_i <= '0';
        wait for 50 ns;

        -- Enable running light again
        enable_i <= '1';
        wait for 10 ns;
        enable_i <= '0';
        wait for 10 ns;
        enable_i <= '1';
        wait for 40 ns;
        enable_i <= '0';
        rst_i <= '1';
        wait for 50 ns;
        rst_i <= '0';
        wait for 100 ns;

        -- End simulation
        wait;
    end process stim_proc;

end Behavioral;
