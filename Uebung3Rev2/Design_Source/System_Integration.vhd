library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity System_Integration is
    Port (
        clk        : in  STD_LOGIC;
        rst        : in  STD_LOGIC;
        enable     : in  STD_LOGIC;
        up_ndown   : in  STD_LOGIC;
        SEG        : out STD_LOGIC_VECTOR(6 downto 0);
        digit_sel  : out STD_LOGIC_VECTOR(3 downto 0)
    );
end System_Integration;

architecture Behavioral of System_Integration is
    -- Signals for counter outputs and clock division
    signal ones, tens, hundreds, thousands: STD_LOGIC_VECTOR(3 downto 0);
    signal enable_counter, enable_display : STD_LOGIC;
begin

    -- Instantiate Clock Divider for Multi_Digit_Counter
    clock_divider_counter: entity work.Taktteiler
        generic map (N => 10)  -- Example division factor
        port map (
            clk_i    => clk,
            enable_o => enable_counter
        );

    -- Multi-Digit Counter
    MDC: entity work.Multi_Digit_Counter
        port map (
            clk_i      => enable_counter,
            rst_i      => rst,
            enable_i   => enable,
            up_ndown_i => up_ndown,
            ones_o     => ones,
            hundreds_o => hundreds,
            thousands_o=> thousands
        );

    -- Instantiate Clock Divider for Seven_Segment_Driver
    clock_divider_display: entity work.Taktteiler
        generic map (N => 100)  -- Example division factor for display refresh
        port map (
            clk_i    => clk,
            enable_o => enable_display
        );

    -- Seven Segment Display Driver
    SSD: entity work.Seven_Segment_Driver
        port map (
            clk         => enable_display,
            rst         => rst,
            ones        => ones,
            tens        => tens,
            hundreds    => hundreds,
            thousands   => thousands,
            SEG         => SEG,
            digit_sel   => digit_sel
        );

end Behavioral;
