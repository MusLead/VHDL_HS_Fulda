library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ButtonToggle is
    Port ( clk : in STD_LOGIC;
           button : in STD_LOGIC;
           led : out STD_LOGIC);
end ButtonToggle;

architecture Behavioral of ButtonToggle is
    component D_FlipFlop is
        Port (
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC
        );
    end component;
        
    signal led_state : STD_LOGIC := '0';
    signal button_last : STD_LOGIC := '0';
begin

    button_instance: D_FlipFlop 
        port map(
            clk => clk,
            rst => '0'
            D => button,
            Q => button_last
        );

    process(button, button_last)
    begin
        if button = '1' and button_last = '0' then
            led_state <= not led_state;
        end if;
    end process;

    led <= led_state;

end Behavioral;

