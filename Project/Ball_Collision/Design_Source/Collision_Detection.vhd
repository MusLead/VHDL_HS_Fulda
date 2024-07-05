----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2024 04:57:59 PM
-- Design Name: 
-- Module Name: Collision_Detection - Behavioral
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

entity Collision_Detection is
    Generic(
            ball_length : integer := 6;
            racket_length : integer := 10;
            racket_height : integer := 30;
            racket_left_space : integer := 20;
            racket_right_space : integer := 610;
            screen_height : integer := 480);
    Port ( clock_i : in STD_LOGIC;
           reset_i : in STD_LOGIC;
           racket_y_pos1_i : in STD_LOGIC_VECTOR (9 downto 0);
           racket_y_pos2_i : in STD_LOGIC_VECTOR (9 downto 0);
           ball_x_i : in STD_LOGIC_VECTOR (9 downto 0);
           ball_y_i : in STD_LOGIC_VECTOR (9 downto 0);
           hit_wall_o : out STD_LOGIC_VECTOR (2 downto 0);
           hit_racket_l_o : out STD_LOGIC_VECTOR (1 downto 0);
           hit_racket_r_o : out STD_LOGIC_VECTOR (1 downto 0));
end Collision_Detection;

architecture Behavioral of Collision_Detection is

begin


end Behavioral;
