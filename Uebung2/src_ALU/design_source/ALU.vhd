----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2024 07:52:48 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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

entity ALU is 
--  Port ( );
    generic(
        sizeBit : integer := 4
    );
    port(
        codex: in std_logic_vector(2 downto 0);
        flag: out std_logic_vector(3 downto 0);
        a,b: in std_logic_vector(sizeBit - 1 downto 0); 
        O: out std_logic_vector(sizeBit - 1 downto 0);
        C: out std_logic
    );
end ALU;

architecture Behavioral of ALU is

    component Ripple_Carry_Addierer is 
        generic(
            sizeBit: integer := sizeBit
        );
        port(
            sub: in std_logic;
            c_out,overflow: out std_logic;
            a,b: in std_logic_vector(sizeBit - 1 downto 0); 
            S: out std_logic_vector(sizeBit - 1 downto 0)
        );
    end component; 

    component halbaddierer is
        port(
            a,b: in std_logic;
            S,Co: out std_logic
        );
    end component;
    
    component ParityChecker is 
        generic(
            sizeBit : integer := sizeBit
        );
        port(
            a: in std_logic_vector(sizeBit - 1 downto 0); 
            isEven: out std_logic
        );
    end component;
    
    component ZeroChecker is 
        generic(
            sizeBit : integer := sizeBit
        );
        port(
            a: in std_logic_vector(sizeBit - 1 downto 0); 
            isZero: out std_logic
        );
    end component;
    
    signal thisParity, thisZero: std_logic;
    signal thisOverflowAdd, thisOverflowCarrySub, c_add: std_logic;
    signal thisOverflowSub, thisOverflowCarryAdd, c_sub : std_logic;
    signal thisOutput: std_logic_vector(sizeBit - 1 downto 0);
    signal thisFlag: std_logic_vector(3 downto 0);
    signal thisResAdd, thisResSub, thisResXOR, 
        thisResOR, thisResNOR, thisResAND, 
        thisResNAND, thisResNOT: std_logic_vector(sizeBit - 1 downto 0); 
begin
   
    add_arithmatic: Ripple_Carry_Addierer
        port map(
            sub => '0',
            a => a,
            b => b,
            S => thisResAdd,
            c_out => c_add, 
            overflow => thisOverflowAdd
        );
        
    sub_arithmatic: Ripple_Carry_Addierer
        port map(
            sub => '1',
            a => a,
            b => b,
            S => thisResSub,
            c_out => c_sub,
            overflow => thisOverflowSub
        );
    
    xor_instance: for i in 0 to sizeBit - 1 generate
        thisResXOR(i) <= a(i) xor b(i);
    end generate;
    
    and_instance: for i in 0 to sizeBit - 1 generate
        thisResAND(i) <= a(i) and b(i);
    end generate;
    
    or_instance: for i in 0 to sizeBit - 1 generate
        thisResOR(i) <= a(i) or b(i);
    end generate;

    nor_instance: for i in 0 to sizeBit - 1 generate
        thisResNOR(i) <= not (a(i) or b(i));
    end generate;

    nand_instance: for i in 0 to sizeBit - 1 generate
        thisResNAND(i) <= not (a(i) and b(i));
    end generate;

    not_instance: for i in 0 to sizeBit - 1 generate
        thisResNOT(i) <= not a(i);
    end generate;
    
    with codex select
        thisOutput <= thisResAdd when  "000",
            thisResSub when    "001",
            thisResXOR when    "100",
            thisResOR when     "010",
            thisResAND when    "011",
            thisResNOR when    "101",
            thisResNAND when   "110",
            thisResNOT when    "111",
            (others => '0') when others;
    
    with codex select
        C <= c_add when "000",
             c_sub when "001",
             '0' when others;
     
    O <= thisOutput;
    
    parity_check: ParityChecker 
        port map(
            a => thisOutput,
            isEven => thisParity
        );
     
     zero_check: ZeroChecker
        port map(
            a => thisOutput,
            isZero => thisZero
        );
    
    
    thisOverflowCarryAdd <= c_add or thisOverflowAdd;
    thisOverflowCarrySub <= c_sub or thisOverflowSub;
    
    with codex select
       flag(0) <= thisOverflowCarryAdd when "000",
                  thisOverflowCarrySub when "001",
                  '0' when others;
             
     flag(1) <= thisZero;
     flag(2) <= thisOutput(sizeBit - 1);
     flag(3) <= thisParity; 
         
         
         
end Behavioral;
