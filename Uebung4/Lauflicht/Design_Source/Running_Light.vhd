----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2024 13:57:20
-- Design Name: 
-- Module Name: Running_Light - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Running_Light is
--  Port ( );
    generic (N: integer := 4);
    port(clk_i,rst_i,enable_i: in std_logic; lights_o: out std_logic_vector(N-1 downto 0));
end Running_Light;

architecture Behavioral of Running_Light is
    component ButtonToggle is 
        port(
           clk : in STD_LOGIC;
           button : in STD_LOGIC;
           led : out STD_LOGIC
        );
    end component;
    
    component D_FlipFlop_NBits is 
        Generic (N : integer);
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC_VECTOR(N-1 downto 0); -- Input D is now an N-bit vector
            Q   : out STD_LOGIC_VECTOR(N-1 downto 0) -- Output Q is also an N-bit vector
        );
    end component;

    type direction is (go_left, go_right);
    signal direction_state: direction := go_left;
    signal current_state, next_state: std_logic_vector(N-1 downto 0);
    signal enable: std_logic := '0';
begin

    enable <= enable_i;


    main_process: process(clk_i, rst_i, enable)
        variable zero_bits : std_logic_vector(N-1 downto 0) := (others => '0'); 
    begin
        if rst_i = '1' then 
            next_state <= (others => '0');
        elsif enable = '1' then
            if current_state = zero_bits then
                next_state(0) <= '1';
            else
                case( direction_state ) is
                    when go_left =>
                        next_state <= std_logic_vector(shift_left(unsigned(current_state), 1));
                    when go_right =>
                        next_state <= std_logic_vector(shift_right(unsigned(current_state), 1));
                end case ;
            end if;
        end if;
    end process main_process;

    direction_process: process(clk_i, rst_i)
    begin
        if next_state(0) = '1' and direction_state = go_right then
            direction_state <= go_left;
        elsif next_state(N-1) = '1' and direction_state = go_left then
            direction_state <= go_right;
        end if;
    end process direction_process;

    output_register: D_FlipFlop_NBits
        generic map (
            N => N
        )
        port map(
            clk => clk_i,
            rst => rst_i,
            D => next_state,
            Q => current_state
        );

    lights_o <= current_state;
end Behavioral;
