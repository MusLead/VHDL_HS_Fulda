library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_System_Integration is
    -- Testbench has no ports
end tb_System_Integration;

architecture Behavioral of tb_System_Integration is
    -- Signals for interfacing with the device under test
    signal tb_clk        : STD_LOGIC := '0';
    signal tb_rst        : STD_LOGIC := '0';
    signal tb_enable_MDC : STD_LOGIC := '0';
    signal tb_up_ndown   : STD_LOGIC := '0';
    signal tb_SEG        : STD_LOGIC_VECTOR(6 downto 0);
    signal tb_digit_sel  : STD_LOGIC_VECTOR(7 downto 0);
    signal tb_running_lights : STD_LOGIC_VECTOR(7 downto 0);
    signal tb_enable_running_light : STD_LOGIC := '0';

    -- Clock generation
    constant clk_period : time := 10 ns; -- Adjust the clock period as necessary
begin
     -- Instantiate the System_Integration
    uut: entity work.System_Integration
        generic map (N_Counter => 2, N_Display => 2, N_Running_Light => 2)
        port map (
            clk             => tb_clk,
            rst             => tb_rst,
            enable_MDC      => tb_enable_MDC,
            enable_running_light => tb_enable_running_light,
            up_ndown        => tb_up_ndown,
            SEG             => tb_SEG,
            digit_sel       => tb_digit_sel,
            running_lights  => tb_running_lights
        );
    
        -- Clock process definitions
    clk_process :process
    begin
        tb_clk <= '0';
        wait for clk_period/2;
        tb_clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        tb_rst <= '1';
        wait for 20 ns;
        tb_rst <= '0';

        -- Enable the counter
        tb_enable_MDC <= '1';
        tb_enable_running_light <= '1';
        wait for 100 ns; -- Run with enable high
        -- tb_enable <= '0';

        -- Test up counting
        tb_up_ndown <= '1'; -- Set to count up
        wait for 100 ns;

        -- Test down counting
        tb_up_ndown <= '0'; -- Set to count down
        wait for 100 ns;

        -- Finish the simulation
        wait;
    end process;
end Behavioral;

