library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Speed_Control is
-- Empty entity as this is the testbench
end tb_Speed_Control;

architecture tb of tb_Speed_Control is
    -- Signal declarations
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal step_frequency : integer range 1 to 255 := 1;
    signal step_enable : std_logic;

    -- Clock period definition for 500 Hz
    constant clk_period : time := 2 ms;  -- 500 Hz frequency

begin
    -- UUT instantiation
    uut: entity work.Speed_Control
        generic map (
            clk_frequency_in_hz => 500  -- Overriding the default frequency for testing
        )
        port map (
            clk => clk,
            reset => reset,
            step_frequency => step_frequency,
            step_enable => step_enable
        );

    -- Clock process
    clk_process : process 
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Reset
        reset <= '1';
--        step_frequency <= std_logic_vector(to_unsigned(1, 8));
        step_frequency <= 1;
        wait for 10 * clk_period;
        reset <= '0';
        wait for 1000 * clk_period;
        
        -- Test case 1: Set frequency
--        step_frequency <= std_logic_vector(to_unsigned(2, 8));
        step_frequency <= 2;
        wait for 2000 * clk_period;  -- wait to observe the behavior

        -- Test case 2: Change frequency
--        step_frequency <= std_logic_vector(to_unsigned(10, 8));
        step_frequency <= 10;
        wait for 2000 * clk_period;
        
        -- Test case 2: Change frequency
--        step_frequency <= std_logic_vector(to_unsigned(60, 8));
        step_frequency <= 60;
        wait for 2000 * clk_period;
        
        -- Test case 2: Change frequency
--        step_frequency <= std_logic_vector(to_unsigned(100, 8));
        step_frequency <= 100;
        wait for 2000 * clk_period;
        
        -- Test case 2: Change frequency to high
--        step_frequency <= std_logic_vector(to_unsigned(150, 8));
        step_frequency <= 150;
        wait for 2000 * clk_period;
        
        -- Test case 2: Change frequency
--        step_frequency <= std_logic_vector(to_unsigned(255, 8));
        step_frequency <= 255;
        wait for 2000 * clk_period;

        -- Test case 3: Change frequency
--        step_frequency <= std_logic_vector(to_unsigned(1, 8));
        step_frequency <= 1;
        wait for 2000 * clk_period;

        -- Finish simulation
        wait;
    end process;

end tb;
