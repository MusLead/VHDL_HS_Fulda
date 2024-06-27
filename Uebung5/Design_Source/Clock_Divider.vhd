library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Clock_Divider is
    port (
        clk_i    : in  std_logic;
        reset    : in  std_logic;
        max_count : in integer;  -- Dynamically set the division factor
        enable_o : out std_logic
    );
end Clock_Divider;

architecture Behavioral of Clock_Divider is
    signal counter : integer := 0;
    signal out_sig : std_logic := '0';
begin
    
    process (clk_i)
    begin
        if rising_edge(clk_i) then
            if reset = '1' then
                counter <= 0;
                out_sig <= '0';  -- Ensure output is low on reset
            elsif counter >= max_count - 1 then
                counter <= 0;
                out_sig <= '1'; 
            else
                counter <= counter + 1;
                out_sig <= '0';
            end if;
        end if;
    end process;

    enable_o <= out_sig;
end Behavioral;
