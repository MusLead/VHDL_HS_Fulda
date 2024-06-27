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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Step_Motor is
    Port ( half_step_mode : in STD_LOGIC;
           step_enable : in STD_LOGIC;
           direction_cw : in STD_LOGIC;
           output_motor : out STD_LOGIC_VECTOR(3 downto 0);
end Step_Motor;

architecture Behavioral of Step_Motor is
    type direction is (clockwise, counter_clockwise);
    signal direction_state: direction := clockwise;
    signal current_state, next_state: std_logic_vector(3 downto 0) := "0101";
begin

    main_process: process(half_step_mode, step_enable, direction_cw)
    begin
        if enable_i = '1' then
            if directio_state = clockwise then
                case current_state is
                    when "0001" =>
                        next_state <= "0011";
                    when "0011" =>
                        next_state <= "0110";
                    when "0110" =>
                        next_state <= "0100";
                    when "0100" =>
                        next_state <= "1000";
                    when "1000" =>
                        next_state <= "1001";
                    when "1001" =>
                        next_state <= "1010";
                    when "1010" =>
                        next_state <= "0010";
                    when "0010" =>
                        next_state <= "0001";
                    when others =>
                        next_state <= "0101";
                end case;
        else 
            next_state <= current_state;
        end if;
    end process main_process;

    direction_process: process(direction_cw)
    begin
        if direction_cw = '1' then
            direction_state <= clockwise;
        else
            direction_state <= counter_clockwise;
        end if;
    end process direction_process;

    output_register: entity work.D_FlipFlop
        port map (clk_i => clk_i, rst_i => '0', d_i => next_state, q_o => curren_state);

    output_motor <= current_state;
end Behavioral;
