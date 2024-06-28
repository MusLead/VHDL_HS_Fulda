----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/27/2024 01:53:01 AM
-- Design Name: 
-- Module Name: Step_Motor - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Step_Motor is
    port (
        clk : in std_logic;
        half_step_mode : in std_logic;
        step_enable : in std_logic;
        direction_cw : in std_logic;
        output_motor : out std_logic_vector(3 downto 0)
    );
end Step_Motor;

architecture Behavioral of Step_Motor is
    type direction is (clockwise, counter_clockwise);
    signal directio_state : direction;
    signal current_state, next_state : std_logic_vector(3 downto 0) := "0101";

begin

    main_process : process (half_step_mode, directio_state, current_state, step_enable)
    begin
        if step_enable = '1' then
            case current_state is
                when "0101" =>
                    if directio_state = clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0001";
                        else
                            next_state <= "1001";
                        end if;
                    elsif directio_state = counter_clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0100";
                        else
                            next_state <= "0110";
                        end if;
                    end if;
                when "0001" =>
                    if directio_state = clockwise then
                        next_state <= "1001";
                    elsif directio_state = counter_clockwise then
                        next_state <= "0101";
                    end if;
                when "1001" =>
                    if directio_state = clockwise then
                        if half_step_mode = '1' then
                            next_state <= "1000";
                        else
                            next_state <= "1010";
                        end if;
                    elsif directio_state = counter_clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0001";
                        else
                            next_state <= "0101";
                        end if;
                    end if;
                when "1000" =>
                    if directio_state = clockwise then
                        next_state <= "1010";
                    elsif directio_state = counter_clockwise then
                        next_state <= "1001";
                    end if;
                when "1010" =>
                    if directio_state = clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0010";
                        else
                            next_state <= "0110";
                        end if;
                    elsif directio_state = counter_clockwise then
                        if half_step_mode = '1' then
                            next_state <= "1000";
                        else
                            next_state <= "1001";
                        end if;
                    end if;
                when "0010" =>
                    if directio_state = clockwise then
                        next_state <= "0110";
                    elsif directio_state = counter_clockwise then
                        next_state <= "1010";
                    end if;
                when "0110" =>
                    if directio_state = clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0100";
                        else
                            next_state <= "0101";
                        end if;
                    elsif directio_state = counter_clockwise then
                        if half_step_mode = '1' then
                            next_state <= "0010";
                        else
                            next_state <= "1010";
                        end if;
                    end if;
                when "0100" =>
                    if directio_state = clockwise then
                        next_state <= "0101";
                    elsif directio_state = counter_clockwise then
                        next_state <= "0110";
                    end if;
                when others => 
                    -- i.e. the current_state is  "0000" because of the D_FlipFlop.
                    -- therefore set into 0101 always!
                    next_state <= "0101";
            end case;
        else
            next_state <= current_state;
        end if;
    end process main_process;

    direction_process : process (direction_cw)
    begin
        if direction_cw = '1' then
            directio_state <= clockwise;
        else
            directio_state <= counter_clockwise;
        end if;
    end process direction_process;

    output_register : entity work.D_FlipFlop_NBits
        generic map(N =>  4)
        port map(clk => clk, rst => '0', D => next_state, Q => current_state);

    output_motor <= current_state;

end Behavioral;
