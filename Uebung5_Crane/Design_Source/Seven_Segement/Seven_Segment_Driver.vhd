library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Seven_Segment_Driver is
    Port (
        clk         : in  STD_LOGIC;
        input_int   : in  integer range 1 to 255;
        SEG         : out STD_LOGIC_VECTOR(6 downto 0);
        digit_sel   : out STD_LOGIC_VECTOR(7 downto 0)
    );
end Seven_Segment_Driver;

architecture Behavioral of Seven_Segment_Driver is
    constant sizeBit_digit_clk : integer := 2;
    type state_type is (ones_state, tens_state, hundreds_state);
    signal curr_state, next_state : state_type;
    signal current_digit,ones,tens,hundreds : STD_LOGIC_VECTOR(3 downto 0);
    signal SEG_connect : STD_LOGIC_VECTOR(6 downto 0);
begin

    -- alocate the input_int to the different digits
    ones <= std_logic_vector(to_unsigned(input_int mod 10, 4));
    tens <= std_logic_vector(to_unsigned((input_int/10) mod 10, 4));
    hundreds <= std_logic_vector(to_unsigned((input_int/100) mod 10, 4));

    -- Process for D-FlipFlop of type steate_type
    DFF_instance: process(clk)
    begin
        if rising_edge(clk) then
            curr_state <= next_state;
        end if;
    end process DFF_instance;

    -- Multiplexing logic for digit selection
    -- LOG 29.06.2024: just because the curr_state is not defined in the sensitivity list, 
    -- the simulation will not change the state
    process(ones, tens, hundreds, curr_state)
    begin
        case curr_state is
            when ones_state =>
                next_state <= tens_state;
                current_digit <= tens;
                digit_sel <= "11111110"; -- Activate first digit
            when tens_state =>
                next_state <= hundreds_state;
                current_digit <= hundreds;
                digit_sel <= "11111101"; -- Activate second digit
            when hundreds_state =>
                next_state <= ones_state;
                current_digit <= ones;
                digit_sel <= "11111011"; -- Activate third digit
        end case;
    end process;

    -- Instantiate BCD to 7-segment converter
    bcd_to_7segment_inst: entity work.BCD_to_7Segment
        port map (
            BCD => current_digit,
            SEG => SEG_connect
        );

    DFF_N_SEG : entity work.D_FlipFlop_NBits
        generic map (
            N => 7
        )
        port map (
            D => SEG_connect,
            rst => '0', 
            clk => clk,
            Q => SEG
        );


end Behavioral;
