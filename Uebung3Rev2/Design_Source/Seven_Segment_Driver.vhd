library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Seven_Segment_Driver is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC; -- TODO: do we really need this rst? or we can  just throw it out?
        ones        : in  STD_LOGIC_VECTOR(3 downto 0);
        tens        : in  STD_LOGIC_VECTOR(3 downto 0);
        hundreds    : in  STD_LOGIC_VECTOR(3 downto 0);
        thousands   : in  STD_LOGIC_VECTOR(3 downto 0);
        SEG         : out STD_LOGIC_VECTOR(6 downto 0);
        digit_sel   : out STD_LOGIC_VECTOR(3 downto 0)
    );
end Seven_Segment_Driver;

architecture Behavioral of Seven_Segment_Driver is

    component BCD_to_7Segment is
        Port (
            BCD : in  STD_LOGIC_VECTOR(3 downto 0);
            SEG : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    -- Declare D_FlipFlop_NBits component
    component D_FlipFlop_NBits
        Generic (N : natural := 2);
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC_VECTOR(1 downto 0);
            Q   : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal digit_clk     : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal next_digit_clk: STD_LOGIC_VECTOR(1 downto 0);
    signal current_digit : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instance of D_FlipFlop for managing digit_clk
    digit_clk_ff: D_FlipFlop_NBits
        generic map (N => 2)
        port map (
            clk => clk,
            rst => rst,
            D   => next_digit_clk,
            Q   => digit_clk
        );

    -- Logic to determine the next state of digit_clk
    next_digit_clk <= digit_clk + 1;

    -- Multiplexing logic for digit selection
    process(digit_clk, ones, tens, hundreds, thousands)
    begin
        case digit_clk is
            when "00" =>
                current_digit <= ones;
                digit_sel <= "1110"; -- Activate first digit
            when "01" =>
                current_digit <= tens;
                digit_sel <= "1101"; -- Activate second digit
            when "10" =>
                current_digit <= hundreds;
                digit_sel <= "1011"; -- Activate third digit
            when others =>
                current_digit <= thousands;
                digit_sel <= "0111"; -- Activate fourth digit
        end case;
    end process;

    -- Instantiate BCD to 7-segment converter
    bcd_to_7segment_inst: BCD_to_7Segment
        port map (
            BCD => current_digit,
            SEG => SEG
        );

end Behavioral;
