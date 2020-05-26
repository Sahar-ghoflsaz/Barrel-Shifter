library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity BSH_32 is
generic( n: integer := 31 ; s: integer := 4);
port(
	Input: in std_logic_vector(n downto 0);
	Output: out std_logic_vector(n downto 0);
	ctrl:in std_logic_vector( 2 downto 0);
	shift: in std_logic_vector( s downto 0)
);
end BSH_32;

architecture behavioral of BSH_32 is

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
signal temp4 : std_logic_vector(n downto 0);
signal temp12 : std_logic_vector(n downto 0);
signal temp22 : std_logic_vector(n downto 0);
signal temp32 : std_logic_vector(n downto 0);
signal temp42 : std_logic_vector(n downto 0);
signal three : std_logic_vector(n downto 0);
signal two : std_logic_vector(n downto 0);
signal added : std_logic_vector(30 downto 0);

begin

with ctrl select

	added <= temp4(15) & temp4(14) & temp4(13) & temp4(12) & temp4(11) & temp4(10) & temp4(9) & temp4(8) & temp4(7) & temp4(6) & temp3(5) & temp4(4)& temp4(3) & temp4(2) & temp4(1) & temp4(0) & temp3(7) & temp3(6) & temp3(5) & temp3(4) & temp3(3) & temp3(2) & temp3(1) & temp3(0) & temp2(3) & temp2(2) & temp2(1) & temp2(0) & temp1(1) & temp1(0) & input(0) when "000", 
	 	 input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n)& input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) & input(n) when "001", 
	 	 '0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0' when "010", 
		 temp42(n-15) & temp42(n-14) & temp42(n-13) & temp42(n-12) & temp42(n-11) & temp42(n-10) & temp42(n-9) & temp42(n-8) & temp42(n-7) & temp42(n-6) & temp42(n-5) & temp42(n-4) & temp42(n-3) & temp42(n-2) & temp42(n-1) & temp42(n) &temp32(n-7) & temp32(n-6) & temp32(n-5) & temp32(n-4) & temp32(n-3) & temp32(n-2) & temp32(n-1) & temp32(n) & temp22(n-3) & temp22(n-2) & temp22(n-1) & temp22(n) & temp12(n-1) & temp12(n) & input(n) when "011", 
		 '0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0' when others;


	
output <= three when ctrl="000"else
	three when ctrl="001" else
	three when ctrl= "010" else
	two;


	

--------------------ror srl sra----------------------------

level1:
    for i in 0 to n-1 generate
        uut : MUX2X1 port map(Input(i), Input(i+1), shift(0), temp1(i));
    end generate;

uut8 : MUX2X1 port map(Input(n),added(0), shift(0), temp1(n));

level2:
    for i in 0 to n-2 generate
        uut : MUX2X1 port map(temp1(i), temp1(i+2), shift(1), temp2(i));
    end generate;

uut15 : MUX2X1 port map(temp1(n-1), added(1) , shift(1), temp2(n-1));
uut16 : MUX2X1 port map(temp1(n), added(2), shift(1), temp2(n));

level3:
    for i in 0 to n-4 generate
        uut : MUX2X1 port map(temp2(i), temp2(i+4), shift(2), temp3(i));
    end generate;

uut21 : MUX2X1 port map(temp2(n-3), added(3) , shift(2), temp3(n-3));
uut22 : MUX2X1 port map(temp2(n-2), added(4) , shift(2), temp3(n-2));
uut23 : MUX2X1 port map(temp2(n-1), added(5) , shift(2), temp3(n-1));
uut24 : MUX2X1 port map(temp2(n), added(6) , shift(2), temp3(n));

level4:
    for i in 0 to n-8 generate
        uut : MUX2X1 port map(temp3(i), temp3(i+8), shift(3), temp4(i));
    end generate;
uut9 : MUX2X1 port map(temp3(n-7), added(7) , shift(3), temp4(n-7));
uut10 : MUX2X1 port map(temp3(n-6), added(8) , shift(3), temp4(n-6));
uut11 : MUX2X1 port map(temp3(n-5), added(9) , shift(3), temp4(n-5));
uut12 : MUX2X1 port map(temp3(n-4), added(10) , shift(3), temp4(n-4));
uut17 : MUX2X1 port map(temp3(n-3), added(11) , shift(3), temp4(n-3));
uut18 : MUX2X1 port map(temp3(n-2), added(12) , shift(3), temp4(n-2));
uut19 : MUX2X1 port map(temp3(n-1), added(13) , shift(3), temp4(n-1));
uut20 : MUX2X1 port map(temp3(n), added(14) , shift(3), temp4(n));

level5:
    for i in 0 to n-16 generate
        uut : MUX2X1 port map(temp4(i), temp4(i+16), shift(4), three(i));
    end generate;

uut40 : MUX2X1 port map(temp4(n-15), added(15) , shift(4), three(n-15));
uut41 : MUX2X1 port map(temp4(n-14), added(16) , shift(4), three(n-14));
uut42 : MUX2X1 port map(temp4(n-13), added(17) , shift(4), three(n-13));
uut43 : MUX2X1 port map(temp4(n-12), added(18) , shift(4), three(n-12));
uut44 : MUX2X1 port map(temp4(n-11), added(19) , shift(4), three(n-11));
uut45 : MUX2X1 port map(temp4(n-10), added(20) , shift(4), three(n-10));
uut46 : MUX2X1 port map(temp4(n-9), added(21) , shift(4), three(n-9));
uut47 : MUX2X1 port map(temp4(n-8), added(22) , shift(4), three(n-8));
uut48 : MUX2X1 port map(temp4(n-7), added(23) , shift(4), three(n-7));
uut49 : MUX2X1 port map(temp4(n-6), added(24) , shift(4), three(n-6));
uut50 : MUX2X1 port map(temp4(n-5), added(25) , shift(4), three(n-5));
uut51 : MUX2X1 port map(temp4(n-4), added(26) , shift(4), three(n-4));
uut52 : MUX2X1 port map(temp4(n-3), added(27) , shift(4), three(n-3));
uut53 : MUX2X1 port map(temp4(n-2), added(28) , shift(4), three(n-2));
uut54 : MUX2X1 port map(temp4(n-1), added(29) , shift(4), three(n-1));
uut55 : MUX2X1 port map(temp4(n), added(30) , shift(4), three(n));

-----------------------rol sll-----------------
	
level12:
    for i in 1 to n generate
        uut : MUX2X1 port map(Input(i), Input(i-1), shift(0), temp12(i));
    end generate;


uut25 : MUX2X1 port map(Input(0),added(0), shift(0), temp12(0));

level22:
    for i in 2 to n generate
        uut : MUX2X1 port map(temp12(i), temp12(i-2), shift(1), temp22(i));
    end generate;


uut26 : MUX2X1 port map(temp12(1), added(1) , shift(1), temp22(1));
uut27 : MUX2X1 port map(temp12(0), added(2), shift(1), temp22(0));

level32:
    for i in 4 to n generate
        uut : MUX2X1 port map(temp22(i), temp22(i-4), shift(2), temp32(i));
    end generate;

uut28 : MUX2X1 port map(temp22(3), added(3) , shift(2), temp32(3));
uut29 : MUX2X1 port map(temp22(2), added(4) , shift(2), temp32(2));
uut30 : MUX2X1 port map(temp22(1), added(5) , shift(2), temp32(1));
uut31 : MUX2X1 port map(temp22(0), added(6) , shift(2), temp32(0));

level42:
    for i in 8 to n generate
        uut : MUX2X1 port map(temp32(i), temp32(i-8), shift(3), temp42(i));
    end generate;

uut32 : MUX2X1 port map(temp32(7), added(7) , shift(3), temp42(7));
uut33 : MUX2X1 port map(temp32(6), added(8) , shift(3), temp42(6));
uut34 : MUX2X1 port map(temp32(5), added(9) , shift(3), temp42(5));
uut35 : MUX2X1 port map(temp32(4), added(10) , shift(3), temp42(4));
uut36 : MUX2X1 port map(temp32(3), added(11) , shift(3), temp42(3));
uut37 : MUX2X1 port map(temp32(2), added(12) , shift(3), temp42(2));
uut38 : MUX2X1 port map(temp32(1), added(13) , shift(3), temp42(1));
uut39 : MUX2X1 port map(temp32(0), added(14) , shift(3), temp42(0));

level52:
    for i in 16 to n generate
        uut : MUX2X1 port map(temp42(i), temp42(i-16), shift(4), two(i));
    end generate;

uut56 : MUX2X1 port map(temp42(15), added(15) , shift(4), two(15));
uut57 : MUX2X1 port map(temp42(14), added(16) , shift(4), two(14));
uut58 : MUX2X1 port map(temp42(13), added(17) , shift(4), two(13));
uut59 : MUX2X1 port map(temp42(12), added(18) , shift(4), two(12));
uut60 : MUX2X1 port map(temp42(11), added(19) , shift(4), two(11));
uut61 : MUX2X1 port map(temp42(10), added(20) , shift(4), two(10));
uut62 : MUX2X1 port map(temp42(9), added(21) , shift(4), two(9));
uut63 : MUX2X1 port map(temp42(8), added(22) , shift(4), two(8));
uut64 : MUX2X1 port map(temp42(7), added(23) , shift(4), two(7));
uut65 : MUX2X1 port map(temp42(6), added(24) , shift(4), two(6));
uut66 : MUX2X1 port map(temp42(5), added(25) , shift(4), two(5));
uut67 : MUX2X1 port map(temp42(4), added(26) , shift(4), two(4));
uut68 : MUX2X1 port map(temp42(3), added(27) , shift(4), two(3));
uut69 : MUX2X1 port map(temp42(2), added(28) , shift(4), two(2));
uut70 : MUX2X1 port map(temp42(1), added(29) , shift(4), two(1));
uut71 : MUX2X1 port map(temp42(0), added(30) , shift(4), two(0));

end;
