library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Seven_Segment_Driver is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        ones        : in  STD_LOGIC_VECTOR(3 downto 0);
        tens        : in  STD_LOGIC_VECTOR(3 downto 0);
        hundreds    : in  STD_LOGIC_VECTOR(3 downto 0);
        thousands   : in  STD_LOGIC_VECTOR(3 downto 0);
        SEG         : out STD_LOGIC_VECTOR (6 downto 0);
        digit_sel   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Seven_Segment_Driver;

architecture Behavioral of Seven_Segment_Driver is

    component BCD_to_7Segment is
        Port (
            BCD : in  STD_LOGIC_VECTOR (3 downto 0);
            SEG : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    signal digit_clk     : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal current_digit : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Clock divider for multiplexing the digits
    process(clk, rst)
    begin
        if rst = '1' then
            digit_clk <= "00";
        elsif rising_edge(clk) then
            digit_clk <= digit_clk + 1;
        end if;
    end process;

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
