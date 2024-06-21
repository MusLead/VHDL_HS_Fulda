library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF_tb is
--  Port ( );
end DFF_tb;

architecture Behavioral of DFF_tb is

    component Generic_Register
        generic(
            n : integer := 8
        );
        Port (
            clk   : in STD_LOGIC;
            rst   : in STD_LOGIC;
            D     : in STD_LOGIC_VECTOR(n-1 downto 0);
            Q     : out STD_LOGIC_VECTOR(n-1 downto 0)
        );
    end component;

    -- Test signals
    signal clk : STD_LOGIC := '0';
    signal rst : STD_LOGIC := '0';
    signal D   : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal Q   : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Generic_Register
        generic map (n => 8)
        Port map (
            clk => clk,
            rst => rst,
            D   => D,
            Q   => Q
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 15 ns;
        
        -- Apply Inputs
        D <= "10101010";
        wait for 30 ns;
        D <= "01010101";
        wait for 20 ns;

        -- Complete Simulation
        wait;
    end process;

end Behavioral;
