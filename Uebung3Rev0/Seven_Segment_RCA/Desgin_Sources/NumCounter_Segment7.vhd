----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2024 11:44:21 PM
-- Design Name: 
-- Module Name: NumCounter_Segment7 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NumCounter_Segment7 is
    Port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic;
        enable_i   : in  std_logic;
        up_ndown_i : in  std_logic;
        BCD        : out unsigned;
        SEG : out std_logic_vector (6 downto 0)
    );
end NumCounter_Segment7;

architecture Behavioral of NumCounter_Segment7 is
    component NumberCounter
        Port (
        clk_i      : in  std_logic;
        rst_i      : in  std_logic;
        enable_i   : in  std_logic;
        up_ndown_i : in  std_logic;
        q_o        : out std_logic_vector(4 downto 0)
        );
    end component;
    
    component BCD_to_7Segment        
        Port ( 
        BCD : in  std_logic_vector (3 downto 0);
        SEG : out std_logic_vector (6 downto 0)
        );
    end component;
    
    signal nc_output: std_logic_vector(4 downto 0);
    signal BCD_input: std_logic_vector(3 downto 0);
begin
    
    NC_instance: NumberCounter
        port map(
            clk_i => clk_i,
            rst_i => rst_i,
            enable_i => enable_i,
            up_ndown_i => up_ndown_i,
            q_o => nc_output
        );
        
    iter_BCD: for i in 0 to 3 generate 
        BCD_input(i) <= nc_output(i);
    end generate iter_BCD;
    
    BCD <= unsigned(BCD_input);
    
    BCD_to_7Segmen_instance: BCD_to_7Segment
        port map(
            BCD => BCD_input,
            SEG => SEG
        );
    
end Behavioral;
