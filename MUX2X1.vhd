library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MUX2X1 is
port(
	A: in std_logic;
	B: in std_logic;
	S: in std_logic;
	Output: out std_logic
);
end MUX2X1;

architecture behavioral of MUX2X1 is


begin

process(A,B,S)
begin
	if(s='0') then
		Output<=A;
	else 
		Output<=B;
	end if;
end process;
end;
