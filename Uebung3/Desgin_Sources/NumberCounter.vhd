library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NumberCounter is
    Port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic;
        enable_i   : in  std_logic;
        up_ndown_i : in  std_logic;
        q_o        : out std_logic_vector(4 downto 0)
    );
end NumberCounter;

architecture Behavioral of NumberCounter is
    constant sizeBit : integer := 5;  -- 4 bits to represent numbers 0-9 MSB as negative/non negative  operation
    
    component Ripple_Carry_Addierer
        generic(
            sizeBit:integer := sizeBit
        );
        port(
            sub: in std_logic;
            c_out, overflow: out std_logic;
            a,b: in std_logic_vector(sizeBit - 1 downto 0); 
            S: out std_logic_vector(sizeBit - 1 downto 0)
        );
    end component;
   
    component RSFF
        generic(
            sizeBit: integer := sizeBit
        );
        port(
            s_i : in std_logic_vector(sizeBit - 1 downto 0);
            r_i : in std_logic;
            q_o : out std_logic_vector(sizeBit - 1 downto 0);
            clk_i : in std_logic
        );
    end component;
    
    signal current_end_state: std_logic_vector(sizeBit - 1 downto 0);
    signal current_state, next_state, input_b: std_logic_vector(sizeBit - 1 downto 0); 
    signal c_out, overflow, isSub: std_logic;
begin

    input_proc: process(enable_i)
    begin
        if enable_i = '1' then
            input_b <= "00001";
        else 
            input_b <= (others => '0');
        end if;
    end process input_proc;
    
    isSub <= not up_ndown_i;
    
    counter: Ripple_Carry_Addierer
        generic map(sizeBit => sizeBit)
        port map(
            sub => isSub,
            c_out => c_out,
            a => current_end_state,
            b => input_b,  -- Increment by 1
            S => next_state,
            overflow => overflow
        );
        
    middle_proc: process(next_state, up_ndown_i)
    begin
        if up_ndown_i = '1' and signed(next_state) >= 10 then
            current_state <= (others => '0');
        elsif up_ndown_i = '0' and signed(next_state) < 0 then
            current_state <= "01001";
        else
            current_state <= next_state;
        end if;
    end process middle_proc;
    
    reg: RSFF
        generic map(sizeBit => sizeBit)
        port map(
            s_i => current_state,
            r_i => rst_i,
            q_o => current_end_state,
            clk_i => clk_i
        );
    
    q_o <= current_end_state;
end Behavioral;
