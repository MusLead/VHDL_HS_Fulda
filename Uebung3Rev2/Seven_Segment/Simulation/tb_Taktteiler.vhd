library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Taktteiler_tb is
end Taktteiler_tb;

architecture Behavioral of Taktteiler_tb is
    signal clk_i    : std_logic := '0';
    signal enable_o : std_logic;
    
    constant N : integer := 4;  -- Adjust the generic value as needed

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.Taktteiler
        generic map (
            N => N
        )
        port map (
            clk_i => clk_i,
            enable_o => enable_o
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
        -- Insert stimulus here
        wait for 100 * clk_period;  -- Run simulation for a specified time
        wait;
    end process;

end Behavioral;
