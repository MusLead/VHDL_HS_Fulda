library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NumCounter_Segment7_tb is
--  Port ( );
end NumCounter_Segment7_tb;

architecture Behavioral of NumCounter_Segment7_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component NumCounter_Segment7
    Port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic;
        enable_i   : in  std_logic;
        up_ndown_i : in  std_logic;
        BCD        : out  unsigned; 
        SEG : out std_logic_vector (6 downto 0)
        );
    end component;

    -- Inputs
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal enable_i : std_logic := '0';
    signal up_ndown_i : std_logic := '0';

    -- Outputs
    signal BCD : unsigned (3 downto 0);
    signal SEG : std_logic_vector (6 downto 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: NumCounter_Segment7
    Port map (
        clk_i => clk_i,
        rst_i => rst_i,
        enable_i => enable_i,
        up_ndown_i => up_ndown_i,
        BCD => BCD,
        SEG => SEG
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk_i <= '0';
        wait for clk_period/2;
        clk_i <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        
        wait for 10 ns;
        
        -- enable the counter
        enable_i <= '1';
        
        -- count up
        up_ndown_i <= '1';
        wait for 200 ns;
        
        -- count down
        up_ndown_i <= '0';
        wait for 25 ns;
        rst_i <= '1';
        wait for clk_period;
        rst_i <= '0';
        
        wait for 140 ns;
        
        
        
        -- disable the counter
        enable_i <= '0';
        wait for 200 ns;

        -- count up again
        enable_i <= '1';
        up_ndown_i <= '1';
        wait for 200 ns;

        -- stop simulation
        wait;
    end process;

end Behavioral;
