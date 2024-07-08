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
use IEEE.NUMERIC_STD.ALL;

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
        constant screen_width : integer := 640;
        constant segment_height : integer := racket_height / 5; -- TODO: test, if this way can be implemented!

        signal hit_wall : std_logic_vector(2 downto 0);
        signal hit_racket_l, hit_racket_r : std_logic_vector(1 downto 0);

        function check_collision (x1 : integer; y1 : integer; h1 : integer; w1 : integer; x2 : integer; y2 : integer; h2 : integer ; w2 : integer) return boolean is
        begin
                return ((x1 + w1) >= x2) and (x1 <= (x2 + w2)) and ((y1 + h1) >= y2) and (y1 <= (y2 + h2));
        end function;
begin

        collision_proc : process(reset_i, ball_x_i, ball_y_i, racket_y_pos1_i, racket_y_pos2_i)
                variable ball_x, ball_y, racket_y1, racket_y2 : integer;
        begin
                ball_x    := to_integer(unsigned(ball_x_i));
                ball_y    := to_integer(unsigned(ball_y_i));
                racket_y1 := to_integer(unsigned(racket_y_pos1_i));
                racket_y2 := to_integer(unsigned(racket_y_pos2_i));
                        
                if check_collision(racket_left_space, racket_y1, racket_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                        -- left racket collides with ball 

                        if check_collision(racket_left_space, racket_y1 + (0 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "01"; -- 1. Segment
                        elsif check_collision(racket_left_space, racket_y1 + (1 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "10"; --
                        elsif check_collision(racket_left_space, racket_y1 + (2 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "11"; --
                        elsif check_collision(racket_left_space, racket_y1 + (3 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "10"; --
                        elsif check_collision(racket_left_space, racket_y1 + (4 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "01"; --
                        end if;

                        hit_wall <= (others => '0');
                        hit_racket_r <= (others => '0');
                
                elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2, racket_height, racket_length) then
                        -- right racket collides with ball

                        if check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (0 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "01"; --
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (1 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "10"; --
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (2 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "11"; --
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (3 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "10"; --
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (4 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "01"; --
                        end if;

                        hit_wall <= (others => '0');
                        hit_racket_l <= (others => '0');
                else
                        -- the ball does not collide with any rackets
                        hit_racket_l <= (others => '0');
                        hit_racket_r <= (others => '0');
                        
                        -- check if the ball collides with wall
                        if ball_x = 0 then 
                                hit_wall <= "110"; -- collides with left wall
                        elsif (ball_x + ball_length) >= (screen_width - 1) then
                                hit_wall <= "101"; --
                        elsif ball_y = 0 then 
                                hit_wall <= "010"; --
                        elsif (ball_y + ball_length) >= (screen_height - 1) then 
                                hit_wall <= "011"; --
                        else 
                                hit_wall <= (others => '0'); -- no collision
                        end if;     

                end if;

        end process collision_proc;

        DFF_N_Wall : entity work.D_FlipFlop_NBits
                generic map (N => 3)
                port map (clk => clock_i,
                          rst => reset_i,
                          D => hit_wall,
                          Q => hit_wall_o);
        
        DFF_N_Racket_L : entity work.D_FlipFlop_NBits
                generic map (N => 2)
                port map (clk => clock_i,
                          rst => reset_i,
                          D => hit_racket_l,
                          Q => hit_racket_l_o);
        
        DFF_N_Racket_R : entity work.D_FlipFlop_NBits
                generic map (N => 2)
                port map (clk => clock_i,
                          rst => reset_i,
                          D => hit_racket_r,
                          Q => hit_racket_r_o);
end Behavioral;
