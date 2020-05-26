library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity BSH_16 is
generic( n: integer := 16 ; s: integer := 4);
port(
	Input: in std_logic_vector(n downto 0);
	Output: out std_logic_vector(n downto 0);
	ctrl:in std_logic_vector( 2 downto 0);
	shift: in std_logic_vector( s downto 0)
);
end BSH_16;

architecture behavioral of BSH_16 is

component MUX2X1 is
port(
	A: in std_logic;
	B: in std_logic;
	S: in std_logic;
	Output: out std_logic
);
end component; 

signal temp1 : std_logic_vector(n downto 0);
signal temp2 : std_logic_vector(n downto 0);
signal temp3 : std_logic_vector(n downto 0);
signal temp12 : std_logic_vector(n downto 0);
signal temp22 : std_logic_vector(n downto 0);
signal temp32 : std_logic_vector(n downto 0);
signal three : std_logic_vector(n downto 0);
signal two : std_logic_vector(n downto 0);
signal added : std_logic_vector(14 downto 0);

begin

with ctrl select

	added <= temp3(7) & temp3(6) & temp3(5) & temp3(4) & temp3(3) & temp3(2) & temp3(1) & temp3(0) & temp2(3) & temp2(2) & temp2(1) & temp2(0) & temp1(1) & temp1(0) & input(0) when "000", 
	 	 input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n)& input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) when "001", 
	 	 '0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0' when "010", 
		 temp32(n-7) & temp32(n-6) & temp32(n-5) & temp32(n-4) & temp32(n-3) & temp32(n-2) & temp32(n-1) & temp32(n) & temp22(n-3) & temp22(n-2) & temp22(n-1) & temp22(n) & temp12(n-1) & temp12(n) & input(n) when "011", 
		 '0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'  when others;


	
output <= three when ctrl="000"else
	three when ctrl="001" else
	three when ctrl= "010" else
	two;


	

--------------------ror srl sra----------------------------

level1:
    for i in 0 to n-1 generate
        uut : MUX2X1 port map(Input(i), Input(i+1), shift(0), temp1(i));
    end generate;


--uut1 : MUX2X1 port map(Input(0), Input(1), shift(0), temp1(0));
--uut2 : MUX2X1 port map(Input(1), Input(2), shift(0), temp1(1));
--uut3 : MUX2X1 port map(Input(2), Input(3), shift(0), temp1(2));
--uut4 : MUX2X1 port map(Input(3), Input(4), shift(0), temp1(3));
--uut5 : MUX2X1 port map(Input(4), Input(5), shift(0), temp1(4));
--uut6 : MUX2X1 port map(Input(5), Input(6), shift(0), temp1(5));
--uut7 : MUX2X1 port map(Input(6), Input(7), shift(0), temp1(6));
uut8 : MUX2X1 port map(Input(n),added(0), shift(0), temp1(n));

level2:
    for i in 0 to n-2 generate
        uut : MUX2X1 port map(temp1(i), temp1(i+2), shift(1), temp2(i));
    end generate;

--uut9 : MUX2X1 port map(temp1(0), temp1(2), shift(1), temp2(0));
--uut10 : MUX2X1 port map(temp1(1), temp1(3), shift(1), temp2(1));
--uut11 : MUX2X1 port map(temp1(2), temp1(4), shift(1), temp2(2));
--uut12 : MUX2X1 port map(temp1(3), temp1(5), shift(1), temp2(3));
--uut13 : MUX2X1 port map(temp1(4), temp1(6), shift(1), temp2(4));
--uut14 : MUX2X1 port map(temp1(5), temp1(7), shift(1), temp2(5));
uut15 : MUX2X1 port map(temp1(n-1), added(1) , shift(1), temp2(n-1));
uut16 : MUX2X1 port map(temp1(n), added(2), shift(1), temp2(n));

level3:
    for i in 0 to n-4 generate
        uut : MUX2X1 port map(temp2(i), temp2(i+4), shift(2), temp3(i));
    end generate;

--uut17 : MUX2X1 port map(temp2(0), temp2(4), shift(2), Output(0));
--uut18 : MUX2X1 port map(temp2(1), temp2(5), shift(2), Output(1));
--uut19 : MUX2X1 port map(temp2(2), temp2(6), shift(2), Output(2));
--uut20 : MUX2X1 port map(temp2(3), temp2(7), shift(2), Output(3));
uut21 : MUX2X1 port map(temp2(n-3), added(3) , shift(2), temp3(n-3));
uut22 : MUX2X1 port map(temp2(n-2), added(4) , shift(2), temp3(n-2));
uut23 : MUX2X1 port map(temp2(n-1), added(5) , shift(2), temp3(n-1));
uut24 : MUX2X1 port map(temp2(n), added(6) , shift(2), temp3(n));

level4:
    for i in 0 to n-8 generate
        uut : MUX2X1 port map(temp3(i), temp3(i+8), shift(3), three(i));
    end generate;

--uut17 : MUX2X1 port map(temp2(0), temp2(4), shift(2), Output(0));
--uut18 : MUX2X1 port map(temp2(1), temp2(5), shift(2), Output(1));
--uut19 : MUX2X1 port map(temp2(2), temp2(6), shift(2), Output(2));
--uut20 : MUX2X1 port map(temp2(3), temp2(7), shift(2), Output(3));
uut9 : MUX2X1 port map(temp3(n-7), added(7) , shift(3), three(n-7));
uut10 : MUX2X1 port map(temp3(n-6), added(8) , shift(3), three(n-6));
uut11 : MUX2X1 port map(temp3(n-5), added(9) , shift(3), three(n-5));
uut12 : MUX2X1 port map(temp3(n-4), added(10) , shift(3), three(n-4));
uut17 : MUX2X1 port map(temp3(n-3), added(11) , shift(3), three(n-3));
uut18 : MUX2X1 port map(temp3(n-2), added(12) , shift(3), three(n-2));
uut19 : MUX2X1 port map(temp3(n-1), added(13) , shift(3), three(n-1));
uut20 : MUX2X1 port map(temp3(n), added(14) , shift(3), three(n));

-----------------------rol sll-----------------
	
level12:
    for i in 1 to n generate
        uut : MUX2X1 port map(Input(i), Input(i-1), shift(0), temp12(i));
    end generate;


--uut1 : MUX2X1 port map(Input(0), Input(1), shift(0), temp1(0));
--uut2 : MUX2X1 port map(Input(1), Input(2), shift(0), temp1(1));
--uut3 : MUX2X1 port map(Input(2), Input(3), shift(0), temp1(2));
--uut4 : MUX2X1 port map(Input(3), Input(4), shift(0), temp1(3));
--uut5 : MUX2X1 port map(Input(4), Input(5), shift(0), temp1(4));
--uut6 : MUX2X1 port map(Input(5), Input(6), shift(0), temp1(5));
--uut7 : MUX2X1 port map(Input(6), Input(7), shift(0), temp1(6));
--------------------------
uut25 : MUX2X1 port map(Input(0),added(0), shift(0), temp12(0));

level22:
    for i in 2 to n generate
        uut : MUX2X1 port map(temp12(i), temp12(i-2), shift(1), temp22(i));
    end generate;

--uut9 : MUX2X1 port map(temp1(0), temp1(2), shift(1), temp2(0));
--uut10 : MUX2X1 port map(temp1(1), temp1(3), shift(1), temp2(1));
--uut11 : MUX2X1 port map(temp1(2), temp1(4), shift(1), temp2(2));
--uut12 : MUX2X1 port map(temp1(3), temp1(5), shift(1), temp2(3));
--uut13 : MUX2X1 port map(temp1(4), temp1(6), shift(1), temp2(4));
--uut14 : MUX2X1 port map(temp1(5), temp1(7), shift(1), temp2(5))00;
--------------------------
uut26 : MUX2X1 port map(temp12(1), added(1) , shift(1), temp22(1));
uut27 : MUX2X1 port map(temp12(0), added(2), shift(1), temp22(0));

level32:
    for i in 4 to n generate
        uut : MUX2X1 port map(temp22(i), temp22(i-4), shift(2), temp32(i));
    end generate;

--uut17 : MUX2X1 port map(temp2(0), temp2(4), shift(2), c(0));
--uut18 : MUX2X1 port map(temp2(1), temp2(5), shift(2), Output(1));
--uut19 : MUX2X1 port map(temp2(2), temp2(6), shift(2), Output(2));
--uut20 : MUX2X1 port map(temp2(3), temp2(7), shift(2), Output(3));
------------------------------------------------------------
uut28 : MUX2X1 port map(temp22(3), added(3) , shift(2), temp32(3));
uut29 : MUX2X1 port map(temp22(2), added(4) , shift(2), temp32(2));
uut30 : MUX2X1 port map(temp22(1), added(5) , shift(2), temp32(1));
uut31 : MUX2X1 port map(temp22(0), added(6) , shift(2), temp32(0));
--uut28 : MUX2X1 port map(temp22(3), added(3) , shift(2), two(3));

level42:
    for i in 8 to n generate
        uut : MUX2X1 port map(temp32(i), temp32(i-8), shift(3), two(i));
    end generate;

--uut17 : MUX2X1 port map(temp2(0), temp2(4), shift(2), c(0));
--uut18 : MUX2X1 port map(temp2(1), temp2(5), shift(2), Output(1));
--uut19 : MUX2X1 port map(temp2(2), temp2(6), shift(2), Output(2));
--uut20 : MUX2X1 port map(temp2(3), temp2(7), shift(2), Output(3));
------------------------------------------------------------
uut32 : MUX2X1 port map(temp32(7), added(7) , shift(3), two(7));
uut33 : MUX2X1 port map(temp32(6), added(8) , shift(3), two(6));
uut34 : MUX2X1 port map(temp32(5), added(9) , shift(3), two(5));
uut35 : MUX2X1 port map(temp32(4), added(10) , shift(3), two(4));
uut36 : MUX2X1 port map(temp32(3), added(11) , shift(3), two(3));
uut37 : MUX2X1 port map(temp32(2), added(12) , shift(3), two(2));
uut38 : MUX2X1 port map(temp32(1), added(13) , shift(3), two(1));
uut39 : MUX2X1 port map(temp32(0), added(14) , shift(3), two(0));

end;