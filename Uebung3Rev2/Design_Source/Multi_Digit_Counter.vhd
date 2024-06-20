library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multi_Digit_Counter is
    Port (
        clk_i      : in STD_LOGIC;
        rst_i      : in STD_LOGIC;
        enable_i   : in STD_LOGIC;
        up_ndown_i : in STD_LOGIC;  -- 1 for count up, 0 for count down
        ones_o     : out STD_LOGIC_VECTOR(3 downto 0);
        tens_o     : out STD_LOGIC_VECTOR(3 downto 0);
        hundreds_o : out STD_LOGIC_VECTOR(3 downto 0);
        thousands_o: out STD_LOGIC_VECTOR(3 downto 0)
    );
end Multi_Digit_Counter;

architecture Behavioral of Multi_Digit_Counter is

    component Mod10_Counter_Sync is
        Port (
            clk_i      : in STD_LOGIC;
            rst_i      : in STD_LOGIC;
            enable_i   : in STD_LOGIC;
            up_ndown_i : in STD_LOGIC; -- 1 for count up, 0 for count down
            q_o        : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component D_FlipFlop is
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC;
            Q   : out STD_LOGIC
        );
    end component;

    signal ones_count     : STD_LOGIC_VECTOR(3 downto 0);
    signal tens_count     : STD_LOGIC_VECTOR(3 downto 0);
    signal hundreds_count : STD_LOGIC_VECTOR(3 downto 0);
    signal thousands_count: STD_LOGIC_VECTOR(3 downto 0);

    signal enable_tens    : STD_LOGIC := '0';
    signal enable_hundreds: STD_LOGIC := '0';
    signal enable_thousands: STD_LOGIC := '0';

    signal ones_rollover  : STD_LOGIC;
    signal tens_rollover  : STD_LOGIC;
    signal hundreds_rollover : STD_LOGIC;

    signal enable_tens_ff     : STD_LOGIC;
    signal enable_hundreds_ff : STD_LOGIC;
    signal enable_thousands_ff: STD_LOGIC;

begin

    -- Instantiate the ones counter
    ones_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_i,
            up_ndown_i => up_ndown_i,
            q_o        => ones_count
        );

    -- Generate rollover signals for the ones counter
    ones_rollover <= '1' when ((ones_count = "1001" and up_ndown_i = '1') or (ones_count = "0000" and up_ndown_i = '0')) and enable_i = '1' else '0';

    -- D flip-flop to synchronize the enable signal for tens counter
    dff_tens: D_FlipFlop
        port map (
            clk => clk_i,
            rst => rst_i,
            D   => ones_rollover,
            Q   => enable_tens_ff
        );

    enable_tens <= enable_tens_ff and enable_i;

    -- Instantiate the tens counter
    tens_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_tens,
            up_ndown_i => up_ndown_i,
            q_o        => tens_count
        );

    -- Generate rollover signals for the tens counter
    tens_rollover <= '1' when ((tens_count = "1001" and up_ndown_i = '1') or (tens_count = "0000" and up_ndown_i = '0')) and enable_tens = '1' else '0';

    -- D flip-flop to synchronize the enable signal for hundreds counter
    dff_hundreds: D_FlipFlop
        port map (
            clk => clk_i,
            rst => rst_i,
            D   => tens_rollover,
            Q   => enable_hundreds_ff
        );

    enable_hundreds <= enable_hundreds_ff and enable_tens;

    -- Instantiate the hundreds counter
    hundreds_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_hundreds,
            up_ndown_i => up_ndown_i,
            q_o        => hundreds_count
        );

    -- Generate rollover signals for the hundreds counter
    hundreds_rollover <= '1' when ((hundreds_count = "1001" and up_ndown_i = '1') or (hundreds_count = "0000" and up_ndown_i = '0')) and enable_hundreds = '1' else '0';

    -- D flip-flop to synchronize the enable signal for thousands counter
    dff_thousands: D_FlipFlop
        port map (
            clk => clk_i,
            rst => rst_i,
            D   => hundreds_rollover,
            Q   => enable_thousands_ff
        );

    enable_thousands <= enable_thousands_ff and enable_hundreds;

    -- Instantiate the thousands counter
    thousands_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_thousands,
            up_ndown_i => up_ndown_i,
            q_o        => thousands_count
        );

    -- Output assignments
    ones_o     <= ones_count;
    tens_o     <= tens_count;
    hundreds_o <= hundreds_count;
    thousands_o<= thousands_count;

end Behavioral;