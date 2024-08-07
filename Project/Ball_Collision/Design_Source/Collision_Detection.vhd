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
-- How to avoid unwanted latch: https://youtu.be/o0Dv-Kr99ac?si=RR8U3OkxQ7RaDIPL
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

        -- Define a record to represent a rectangle
        type rectangle is record
                x : integer;
                y : integer;
                width : integer;
                height : integer;
        end record;

        -- This function check_collision checks if two rectangles collide or not. 
        -- Both rectangles are defined by their top-left corner position and dimensions.
        -- The function checks every edge of both rectangles whether they collide with eachother
        -- return value: true if the rectangles collide, false otherwise
        function check_collision(
                rect1 : rectangle;
                rect2 : rectangle
        ) return boolean is
        begin
                return ((rect1.x + rect1.width) >= rect2.x) and 
                        (rect1.x <= (rect2.x + rect2.width)) and 
                        ((rect1.y + rect1.height) >= rect2.y) and 
                        (rect1.y <= (rect2.y + rect2.height));
        end function;
begin

        -- Collision detection process handles the collision between the ball and the rackets and the walls.
        -- if collision happen either left or right racket then we want to know which segment of the racket was hit.
        -- Switching between segments is done by incrementing the y coordinate with respect to segment_height.
        collision_proc : process (reset_i, ball_x_i, ball_y_i, racket_y_pos1_i, racket_y_pos2_i)
                variable ball, racket_l, racket_r, segment : rectangle;
        begin
                -- Initialize the variables

                ball := (x => to_integer(unsigned(ball_x_i)),
                         y => to_integer(unsigned(ball_y_i)),
                         width => ball_length,
                         height => ball_length);

                racket_l := (x => racket_left_space,
                             y => to_integer(unsigned(racket_y_pos1_i)),
                             width => racket_length,
                             height => racket_height);

                racket_r := (x => racket_right_space,
                             y => to_integer(unsigned(racket_y_pos2_i)),
                             width => racket_length,
                             height => racket_height);

                -- Check if the ball collides with the rackets
                if check_collision(racket_l, ball) then  -- left racket collides with ball. 
                
                        hit_racket_l <= (others => '0'); -- this line to remove an unwanted latch

                        -- check which segment of the racket was hit
                        for i in 0 to 4 loop
                                segment := (x => racket_left_space, 
                                            y => racket_l.y + (i * segment_height), 
                                            width => racket_length, 
                                            height => segment_height);

                                if check_collision(segment, ball) then
                                        case i is
                                                when 0 => hit_racket_l <= "01"; -- 1. Segment hit
                                                when 1 => hit_racket_l <= "10"; -- 2. Segment hit
                                                when 2 => hit_racket_l <= "11"; -- 3. Segment hit
                                                when 3 => hit_racket_l <= "10"; -- 2. Segment hit
                                                when 4 => hit_racket_l <= "01"; -- 1. Segment hit
                                                when others => null;
                                        end case;
                                        exit; -- break the loop
                                end if;
                        end loop;

                        hit_wall <= (others => '0');     -- no collision with wall
                        hit_racket_r <= (others => '0'); -- no collision with right racket

                elsif check_collision(ball, racket_r) then  -- right racket collides with ball
                       
                        hit_racket_r <= (others => '0'); -- this line to remove an unwanted latch
                        
                        -- check which segment of the racket was hit
                        for i in 0 to 4 loop
                                segment := (x => racket_right_space, 
                                            y => racket_r.y + (i * segment_height), 
                                            width => racket_length, 
                                            height => segment_height);

                                if check_collision(ball, segment) then
                                        case i is
                                                when 0 => hit_racket_r <= "01"; -- 1. Segment hit
                                                when 1 => hit_racket_r <= "10"; -- 2. Segment hit
                                                when 2 => hit_racket_r <= "11"; -- 3. Segment hit
                                                when 3 => hit_racket_r <= "10"; -- 2. Segment hit
                                                when 4 => hit_racket_r <= "01"; -- 1. Segment hit
                                                when others => null;
                                        end case;
                                        exit; -- break the loop
                                end if;
                        end loop;

                        hit_wall <= (others => '0');     -- no collision with wall
                        hit_racket_l <= (others => '0'); -- no collision with left racket
                        
                else
                        -- the ball does not collide with any rackets
                        hit_racket_l <= (others => '0');
                        hit_racket_r <= (others => '0');
                        hit_wall <= (others => '0');
                        
                        -- check if the ball collides with wall
                        if (ball.x < (racket_l.x + 10)) then
                                hit_wall <= "110"; -- collides with left wall
                        elsif (ball.x + ball.width) > (racket_r.x) then
                                hit_wall <= "101"; -- collides with right wall
                        elsif ball.y <= 0 then
                                hit_wall <= "010"; -- collides with top wall
                        elsif (ball.y + ball.height) >= (screen_height - 1) then
                                hit_wall <= "001"; -- collides with bottom wall
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
