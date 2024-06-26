library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity System_Integration is
    Generic (
        N_Counter : integer := 31_250_000; -- 125 MHz / 2 Hz = 62.5M per one period and divided by two!
        N_Display : integer := 100_000; -- 125 MHz / 625 Hz = 200_000 per one period and divided by two!
        N_Running_Light : integer := 12_500_000); -- 125 MHz / 5 Hz = 25M per one period and divided by two!
    Port (
        clk                          : in  STD_LOGIC;
        rst                          : in  STD_LOGIC;
        enable_MDC     _MDC          : in  STD_LOGIC;
        enable_running_light: in  STD_LOGIC;
        enable_running_light: in  STD_LOGIC;
        up_ndown                     : in  STD_LOGIC;
        SEG                          : out STD_LOGIC_VECTOR(6 downto 0);
        digit_sel                    : out STD_LOGIC_VECTOR(7 downto 0);
        running_lights         : out STD_LOGIC_VECTOR(7 downto 0);
        point               : out STD_LOGIC
    );
end System_Integration;

architecture Behavioral of System_Integration is
    constant lightsNumber: integer := 8;
    -- Signals for counter outputs and clock division
    signal ones, tens, hundreds, thousands: STD_LOGIC_VECTOR(3 downto 0);
    signal clk_counter, clk_display, clk_running_light : STD_LOGIC;
    signal rl_s: STD_LOGIC_VECTOR(7 downto 0);
    signal enable_rl: STD_LOGIC;
begin

    point <= '1'; -- turn off the point
    -- Instantiate Clock Divider for Multi_Digit_Counter
    clock_divider_counter: entity work.Taktteiler
        generic map (N => N_Counter)  
        port map (
            clk_i    => clk,
            enable_o => clk_counter
        );

    -- Multi-Digit Counter
    MDC: entity work.Multi_Digit_Counter
        port map (
            clk_i      => clk_counter,
            rst_i      => rst,
            enable_i   => enable_MDC,
            up_ndown_i => up_ndown,
            ones_o     => ones,
            tens_o     => tens,
            hundreds_o => hundreds,
            thousands_o=> thousands
        );

    -- Instantiate Clock Divider for Seven_Segment_Driver
    clock_divider_display: entity work.Taktteiler
        generic map (N => N_Display)  
        port map (
            clk_i    => clk,
            enable_o => clk_display
        );

    -- Seven Segment Display Driver
    SSD: entity work.Seven_Segment_Driver
        port map (
            clk         => clk_display,
            ones        => ones,
            tens        => tens,
            hundreds    => hundreds,
            thousands   => thousands,
            SEG         => SEG,
            digit_sel   => digit_sel
        );

    clock_divider_running_light: entity work.Taktteiler
        generic map (N => N_Running_Light)  
        port map (
            clk_i    => clk,
            enable_o => clk_running_light
        );

    
    button_instance: entity work.ButtonToggle
        port map(
            clk => clk_display,
            button => enable_running_light,
            led => enable_rl
        );

    -- enable_rl <= enable_running_light;
    
    RL: entity work.Running_Light
        generic map (N => 8)
        port map (
            clk_i         => clk_running_light,
            rst_i         => rst,
            enable_i      => enable_rl,
            lights_o      => running_lights
        );

end Behavioral;

