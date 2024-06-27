----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/27/2024 08:15:56 PM
-- Design Name: 
-- Module Name: tb_Step_Motor - Behavioral
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

----------------------------------------------------------------------------------
-- Testbench for Stepper Motor Control
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_Step_Motor IS
END tb_Step_Motor;

ARCHITECTURE behavior OF tb_Step_Motor IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT Step_Motor
    PORT(
         clk : IN  std_logic;
         half_step_mode : IN  std_logic;
         step_enable : IN  std_logic;
         direction_cw : IN  std_logic;
         output_motor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
   
   --Inputs
   signal clk : std_logic := '0';
   signal half_step_mode : std_logic := '0';
   signal step_enable : std_logic := '0';
   signal direction_cw : std_logic := '0';

   --Outputs
   signal output_motor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN

   -- Instantiate the Unit Under Test (UUT)
   uut: Step_Motor PORT MAP (
          clk => clk,
          half_step_mode => half_step_mode,
          step_enable => step_enable,
          direction_cw => direction_cw,
          output_motor => output_motor
        );

   -- Clock process definitions
   clk_process :process
   begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin        
      -- Initialize Inputs
      half_step_mode <= '0';
      step_enable <= '0';
      direction_cw <= '0';
      wait for 20 ns;  
      
      -- Scenario 1: Clockwise rotation in full-step mode
      step_enable <= '1';  -- Enable stepping
      direction_cw <= '1'; -- Clockwise
      half_step_mode <= '0'; -- Full-step mode
      wait for 80 ns;

      -- Scenario 2: Counterclockwise rotation in half-step mode
      direction_cw <= '0'; -- Counterclockwise
      half_step_mode <= '1'; -- Half-step mode
      wait for 400 ns;

      -- Stop the motor
      step_enable <= '0';
      wait for 40 ns;

      -- Add more scenarios as necessary

      -- Wait for a while and then end simulation
      wait for 100 ns;
      wait;
   end process;

END;

