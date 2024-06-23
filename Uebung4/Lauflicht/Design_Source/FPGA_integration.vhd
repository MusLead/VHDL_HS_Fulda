----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.06.2024 17:19:29
-- Design Name: 
-- Module Name: FPGA_integration - Behavioral
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

entity FPGA_integration is
    generic( 
        N_Running_Light : integer := 25_000_000;
        N_Button_takt : integer := 1_000
    );
    Port ( 
        clk : in std_logic;
        enable_running_light: in std_logic;
        rst: in std_logic;
        running_lights: out std_logic_vector(7 downto 0)
    );
end FPGA_integration;

architecture Behavioral of FPGA_integration is

    component ButtonToggle is 
        port(
           clk : in STD_LOGIC;
           button : in STD_LOGIC;
           led : out STD_LOGIC
        );
    end component;

    component Running_Light is
        generic (N: integer := 8);
        port(clk_i,rst_i,enable_i: in std_logic; lights_o: out std_logic_vector(N-1 downto 0));
    end component;
    
    component Taktteiler is
        generic (
            N : integer  -- Teilungsfaktor
        );
        port (
            clk_i    : in  std_logic; -- Eingangstakt
            enable_o : out std_logic  -- Ausgabe-Steuersignal
        );
    end component;

    component D_FlipFlop_NBits is 
        Generic (N : integer := 2);
        Port (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            D   : in STD_LOGIC_VECTOR(N-1 downto 0); -- Input D is now an N-bit vector
            Q   : out STD_LOGIC_VECTOR(N-1 downto 0) -- Output Q is also an N-bit vector
        );
    end component;

    signal rst_n_enable_in, rst_n_enable_out: std_logic_vector(1 downto 0);
    signal enable_running_light_taktteiler, button_takt: std_logic;
    signal enable_out: std_logic;
begin



    Taktteiler_instance: Taktteiler
        generic map (
            N => N_Running_Light
        )
        port map(
            clk_i => clk,
            enable_o => enable_running_light_taktteiler
        );
    
    -- rst_n_enable_in(0) <= rst;
    -- rst_n_enable_in(1) <= enable_running_light; 

    -- D_FlipFlop_NBits_instance: D_FlipFlop_NBits
    --     port map(
    --         clk => clk,
    --         rst => rst,
    --         D => rst_n_enable_in,
    --         Q => rst_n_enable_out
    --     );
    
    Taktteiler_instance_button: Taktteiler
        generic map(
            N => N_Button_takt
            )
        port map(
            clk_i => clk,
            enable_o => button_takt
        );
    
    button_instance: ButtonToggle
        port map(
            clk => button_takt,
            button => enable_running_light,
            led => enable_out
        );
        
    Running_Light_instance: Running_Light
        port map(
            clk_i => enable_running_light_taktteiler,
            rst_i => rst,
            enable_i => enable_out,
            lights_o => running_lights
        );

end Behavioral;
