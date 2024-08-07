----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/07/2024 01:42:09 AM
-- Design Name: 
-- Module Name: tb_Collision_Detection - Behavioral
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

entity tb_Collision_Detection is
--  Port ( );
end tb_Collision_Detection;

architecture Behavioral of tb_Collision_Detection is
    -- Constants for the testbench
    constant ball_length : integer := 6;
    constant racket_length : integer := 10;
    constant racket_height : integer := 30;
    constant racket_left_space : integer := 20;
    constant racket_right_space : integer := 610;
    constant screen_height : integer := 480;
    constant screen_width : integer := 640;

    -- Signals for the DUT (Device Under Test)
    signal reset_i : std_logic := '0';
    signal racket_y_pos1_i : std_logic_vector(9 downto 0) := (others => '0');
    signal racket_y_pos2_i : std_logic_vector(9 downto 0) := (others => '0');
    signal ball_x_i : std_logic_vector(9 downto 0) := (others => '0');
    signal ball_y_i : std_logic_vector(9 downto 0) := (others => '0');
    signal hit_wall_o : std_logic_vector(2 downto 0);
    signal hit_racket_l_o : std_logic_vector(1 downto 0);
    signal hit_racket_r_o : std_logic_vector(1 downto 0);

    -- Clock generation
    constant clock_period : time := 10 ns;
    signal clock : std_logic := '0';
begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.Collision_Detection
        generic map (
            ball_length => ball_length,
            racket_length => racket_length,
            racket_height => racket_height,
            racket_left_space => racket_left_space,
            racket_right_space => racket_right_space,
            screen_height => screen_height
        )
        port map (
            clock_i => clock,
            reset_i => reset_i,
            racket_y_pos1_i => racket_y_pos1_i,
            racket_y_pos2_i => racket_y_pos2_i,
            ball_x_i => ball_x_i,
            ball_y_i => ball_y_i,
            hit_wall_o => hit_wall_o,
            hit_racket_l_o => hit_racket_l_o,
            hit_racket_r_o => hit_racket_r_o
        );

    -- Clock process
    clock_process :process
    begin
        clock <= '0';
        wait for clock_period/2;
        clock <= '1';
        wait for clock_period/2;
    end process clock_process;

    -- Test process
    test_process : process
    begin
        -- Initialize Inputs
        reset_i <= '1';
        wait for clock_period;
        reset_i <= '0';
        wait for clock_period;

        -- Test collision with left racket
        ball_x_i <= std_logic_vector(to_unsigned(racket_left_space, 10));
        ball_y_i <= std_logic_vector(to_unsigned(15, 10));
        racket_y_pos1_i <= std_logic_vector(to_unsigned(10, 10));
        wait for clock_period;
        assert (hit_racket_l_o = "01") report "Collision with left racket top segment not detected" severity error;

        -- Test collision with right racket
        ball_x_i <= std_logic_vector(to_unsigned(racket_right_space, 10));
        ball_y_i <= std_logic_vector(to_unsigned(27, 10));
        racket_y_pos2_i <= std_logic_vector(to_unsigned(20, 10));
        wait for clock_period;
        assert (hit_racket_r_o = "10") report "Collision with right racket second segment not detected" severity error;

        -- Test collision with top wall
        ball_x_i <= std_logic_vector(to_unsigned(320, 10));
        ball_y_i <= std_logic_vector(to_unsigned(0, 10));
        wait for clock_period;
        assert (hit_wall_o = "010") report "Collision with top wall not detected" severity error;

        -- Test collision with bottom wall
        ball_x_i <= std_logic_vector(to_unsigned(320, 10));
        ball_y_i <= std_logic_vector(to_unsigned(screen_height - ball_length, 10));
        wait for clock_period;
        assert (hit_wall_o = "001") report "Collision with bottom wall not detected" severity error;

        -- Test collision with left wall
        ball_x_i <= std_logic_vector(to_unsigned(0, 10));
        ball_y_i <= std_logic_vector(to_unsigned(240, 10));
        wait for clock_period * 2;
        assert (hit_wall_o = "110") report "Collision with left wall not detected" severity error;

        -- Test collision with right wall
        ball_x_i <= std_logic_vector(to_unsigned(screen_width - ball_length, 10));
        ball_y_i <= std_logic_vector(to_unsigned(240, 10));
        wait for clock_period * 2;
        assert (hit_wall_o = "101") report "Collision with right wall not detected" severity error;

        -- Test no collision
        ball_x_i <= std_logic_vector(to_unsigned(320, 10));
        ball_y_i <= std_logic_vector(to_unsigned(240, 10));
        wait for clock_period;
        assert (hit_wall_o = "000" and hit_racket_l_o = "00" and hit_racket_r_o = "00") report "Incorrect collision detected" severity error;

        wait;
    end process test_process;

end Behavioral;