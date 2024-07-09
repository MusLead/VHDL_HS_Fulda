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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Collision_Detection is
        generic (
                ball_length : integer := 6;
                racket_length : integer := 10;
                racket_height : integer := 30;
                racket_left_space : integer := 20;
                racket_right_space : integer := 610;
                screen_height : integer := 480);
        port (
                clock_i : in std_logic;
                reset_i : in std_logic;
                racket_y_pos1_i : in std_logic_vector (9 downto 0);
                racket_y_pos2_i : in std_logic_vector (9 downto 0);
                ball_x_i : in std_logic_vector (9 downto 0);
                ball_y_i : in std_logic_vector (9 downto 0);
                hit_wall_o : out std_logic_vector (2 downto 0);
                hit_racket_l_o : out std_logic_vector (1 downto 0);
                hit_racket_r_o : out std_logic_vector (1 downto 0));
end Collision_Detection;

architecture Behavioral of Collision_Detection is
        constant screen_width : integer := 640;
        constant segment_height : integer := racket_height / 5; -- TODO: test, if this way can be implemented! because of the divider, it might not work properly on the FPGA

        signal hit_wall : std_logic_vector(2 downto 0);
        signal hit_racket_l, hit_racket_r : std_logic_vector(1 downto 0);

        -- This function check_collision checks if two rectangles collide or not. 
        -- Both rectangles are defined by their top-left corner position and dimensions.
        -- The function checks every edge of both rectangles whether they collide with eachother
        -- x1, y1: The coordinates, h1: height,  w1: width of 1. Rectangle
        -- x2, y2: The coordinates, h2: height,  w2: width of 2. Rectangle
        -- return value: true if the rectangles collide, false otherwise
        function check_collision(
                x1 : integer;
                y1 : integer;
                h1 : integer;
                w1 : integer;
                x2 : integer;
                y2 : integer;
                h2 : integer;
                w2 : integer
        ) return boolean is
        begin
                return ((x1 + w1) >= x2) and (x1 <= (x2 + w2)) and ((y1 + h1) >= y2) and (y1 <= (y2 + h2));
        end function;
begin

        -- Collision detection process handles the collision between the ball and the rackets and the walls.
        -- if collision happen either left or right racket then we want to know which segment of the racket was hit.
        -- Switching between segments is done by incrementing the y coordinate with respect to segment_height.
        collision_proc : process (reset_i, ball_x_i, ball_y_i, racket_y_pos1_i, racket_y_pos2_i)
                variable ball_x, ball_y, racket_y1, racket_y2 : integer;
        begin
                ball_x := to_integer(unsigned(ball_x_i));
                ball_y := to_integer(unsigned(ball_y_i));
                racket_y1 := to_integer(unsigned(racket_y_pos1_i));
                racket_y2 := to_integer(unsigned(racket_y_pos2_i));

                if check_collision(racket_left_space, racket_y1, racket_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                        -- left racket collides with ball. 

                        if check_collision(racket_left_space, racket_y1 + (0 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "01"; -- 1. Segment hit
                        elsif check_collision(racket_left_space, racket_y1 + (1 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "10"; -- 2. Segment hit
                        elsif check_collision(racket_left_space, racket_y1 + (2 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "11"; -- 3. Segment hit
                        elsif check_collision(racket_left_space, racket_y1 + (3 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "10"; -- 2. Segment hit
                        elsif check_collision(racket_left_space, racket_y1 + (4 * segment_height), segment_height, racket_length, ball_x, ball_y, ball_length, ball_length) then
                                hit_racket_l <= "01"; -- 1. Segment hit
                        end if;

                        hit_wall <= (others => '0');     -- no collision with wall
                        hit_racket_r <= (others => '0'); -- no collision with right racket

                elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2, racket_height, racket_length) then
                        -- right racket collides with ball

                        if check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (0 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "01"; -- 1. Segment hit
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (1 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "10"; -- 2. Segment hit
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (2 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "11"; -- 3. Segment hit
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (3 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "10"; -- 2. Segment hit
                        elsif check_collision(ball_x, ball_y, ball_length, ball_length, racket_right_space, racket_y2 + (4 * segment_height), segment_height, racket_length) then
                                hit_racket_r <= "01"; -- 1. Segment hit
                        end if;

                        hit_wall <= (others => '0');     -- no collision with wall
                        hit_racket_l <= (others => '0'); -- no collision with left racket
                else
                        -- the ball does not collide with any rackets
                        hit_racket_l <= (others => '0');
                        hit_racket_r <= (others => '0');

                        -- check if the ball collides with wall
                        if ball_x = 0 then
                                hit_wall <= "110"; -- collides with left wall
                        elsif (ball_x + ball_length) >= (screen_width - 1) then
                                hit_wall <= "101"; -- collides with right wall
                        elsif ball_y = 0 then
                                hit_wall <= "010"; -- collides with top wall
                        elsif (ball_y + ball_length) >= (screen_height - 1) then
                                hit_wall <= "011"; -- collides with bottom wall
                        else
                                hit_wall <= (others => '0'); -- no collision
                        end if;

                end if;

        end process collision_proc;

        -- Create Flipflops for registering collision signals 

        -- Flipflop for storing wall collision
        DFF_N_Wall : entity work.D_FlipFlop_NBits
                generic map(N => 3)
                port map(
                        clk => clock_i,
                        rst => reset_i,
                        D => hit_wall,
                        Q => hit_wall_o);

        -- Flipflop for storing left racket collision
        DFF_N_Racket_L : entity work.D_FlipFlop_NBits
                generic map(N => 2)
                port map(
                        clk => clock_i,
                        rst => reset_i,
                        D => hit_racket_l,
                        Q => hit_racket_l_o);

        -- Flipflop for storing right racket collision
        DFF_N_Racket_R : entity work.D_FlipFlop_NBits
                generic map(N => 2)
                port map(
                        clk => clock_i,
                        rst => reset_i,
                        D => hit_racket_r,
                        Q => hit_racket_r_o);
end Behavioral;
