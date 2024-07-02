----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/29/2024 03:20:12 AM
-- Design Name: 
-- Module Name: SM_Freq_Determiner - Behavioral
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

entity Crane_Control is
    Generic (
        clk_frequency_in_hz : integer := 125_000_000 -- Default frequency of 125 MHz
    );
    Port ( 
        direction_cw : in STD_LOGIC;
        stop_input : in STD_LOGIC;
        clk : in STD_LOGIC;
        step_enable : out STD_LOGIC;
        step_frequency : out integer range 1 to 255
    );
end Crane_Control;

architecture Behavioral of Crane_Control is
    signal curr_steps, next_steps: integer range 0 to 161 := 0; -- 161 curr_steps for 180 degrees
    signal curr_frq, next_frq: integer range 1 to 255 := 40;
    signal stop_curr, stop_next, stop_next_res: STD_LOGIC := '0';
    signal step_enable_signal: STD_LOGIC;
begin

    -- TODO: CHECK again if the stop signal needs flip flop or not
    main_process: process(step_enable_signal, curr_steps, direction_cw, curr_frq, curr_steps)
    begin
        if step_enable_signal = '1' then
            if (curr_steps = 161 and direction_cw = '1') or 
                (curr_steps = 0 and direction_cw = '0') then
                
                -- stop the motor if the steps are at the limit
                stop_next <= '1';
            
            else

                stop_next <= '0';
                
                -- adjust steps based on the direction
                if direction_cw = '1' then
                    next_steps <= curr_steps + 1;
                else
                    next_steps <= curr_steps - 1;
                end if;
                
                -- adjust frequency based on the steps
                if (curr_steps >= 81 and direction_cw = '1') or 
                    (curr_steps <= 81 and direction_cw = '0') then
                    next_frq <= curr_frq - 2;
                else
                    next_frq <= curr_frq + 2;
                end if;

            end if;
        else 
        
            if not ((curr_steps = 161 and direction_cw = '1') or 
                (curr_steps = 0 and direction_cw = '0')) then
                stop_next <= '0';
            end if; 
            
            next_steps <= curr_steps;
            next_frq <= curr_frq;

        end if; 
    end process;

    -- DFF for integer value
    output_instance: process(clk)
    begin
        if rising_edge(clk) then
            curr_frq <= next_frq;
            curr_steps <= next_steps;
        end if;
    end process output_instance;
    
    stop_next_res <= stop_next or stop_input;
    
    DFF_stop: entity work.D_FlipFlop 
        Port map (
            clk => clk,
            rst => '0',
            D  => stop_next_res,
            Q   => stop_curr
        );
    
    SC_instance: entity work.Speed_Control
        generic map(
            clk_frequency_in_hz => clk_frequency_in_hz
        )
        port map(
            clk => clk,
            reset => stop_curr,
            step_frequency => curr_frq,
            step_enable => step_enable_signal
        );

    step_enable <= step_enable_signal;
    step_frequency <= curr_frq;
    

end Behavioral;
