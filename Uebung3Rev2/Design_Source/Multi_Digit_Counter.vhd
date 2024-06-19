library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Import numeric_std instead of std_logic_arith and std_logic_unsigned

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

    signal ones_count     : STD_LOGIC_VECTOR(3 downto 0);
    signal tens_count     : STD_LOGIC_VECTOR(3 downto 0);
    signal hundreds_count : STD_LOGIC_VECTOR(3 downto 0);
    signal thousands_count: STD_LOGIC_VECTOR(3 downto 0);
    signal enable_tens    : STD_LOGIC;
    signal enable_hundreds: STD_LOGIC;
    signal enable_thousands: STD_LOGIC;

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

    -- Enable the tens counter when ones counter rolls over (either from 9 to 0 when counting up or from 0 to 9 when counting down)
    tens_process: process(ones_count, up_ndown_i, enable_i)
    begin 
        if (ones_count = "1001" and up_ndown_i = '1' and enable_i = '1') or (ones_count = "0000" and up_ndown_i = '0' and enable_i = '1') 
        then 
             enable_tens <= '1';
        else 
             enable_tens <= '0';
        end if;
    end process tens_process;

    -- Instantiate the tens counter
    tens_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_tens,
            up_ndown_i => up_ndown_i,
            q_o        => tens_count
        );

    -- Enable the hundreds counter when tens counter rolls over (either from 9 to 0 when counting up or from 0 to 9 when counting down)
    hunderds_process: process(tens_count, up_ndown_i, enable_tens)
    begin 
        if (tens_count = "1001" and up_ndown_i = '1' and enable_tens = '1') or (tens_count = "0000" and up_ndown_i = '0' and enable_tens = '1') 
        then 
             enable_hundreds <= '1';
        else 
             enable_hundreds <= '0';
        end if;
    end process hunderds_process;
    
    
    -- Instantiate the hundreds counter
    hundreds_counter: Mod10_Counter_Sync
        port map (
            clk_i      => clk_i,
            rst_i      => rst_i,
            enable_i   => enable_hundreds,
            up_ndown_i => up_ndown_i,
            q_o        => hundreds_count
        );

    -- Enable the thousands counter when hundreds counter rolls over (either from 9 to 0 when counting up or from 0 to 9 when counting down)
    thousands_process: process(hundreds_count, up_ndown_i, enable_hundreds)
    begin 
        if (hundreds_count = "1001" and up_ndown_i = '1' and enable_hundreds = '1') or (hundreds_count = "0000" and up_ndown_i = '0' and enable_hundreds = '1')
        then 
             enable_thousands <= '1';
        else 
             enable_thousands <= '0';
        end if;
    end process thousands_process;

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
