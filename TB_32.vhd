library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity test_32 is
end test_32;
architecture one of test_32 is
 component BSH_32 is
generic( n: integer := 31 ; s: integer := 4);
port(
	Input: in std_logic_vector(n downto 0);
	Output: out std_logic_vector(n downto 0);
	ctrl:in std_logic_vector( 2 downto 0);
	shift: in std_logic_vector( s downto 0)
);
 end component;
--constant signal s: integer 0 range to 32:=;
signal input: std_logic_vector(31 downto 0):= "10111110011010111011111001101011";-- "10001100001101101111000000101010";
signal output: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";--"10000000001111111111000000111010";
signal shift: std_logic_vector(4 downto 0) := "00000";
signal ctrl: std_logic_vector(2 downto 0) := "000";
--signal m: std_logic_vector(3 downto 0) ;
--//signal temp1 std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
--signal temp2 std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

begin

 uut: BSH_32
 port map(Input => input,
Output => output,
ctrl=>ctrl,
shift=>shift
);

-- test vector generator
 process
 begin


shift <= "00000";
wait for 10 ns;
shift <= "00001";
wait for 10 ns;
shift <= "00010";
wait for 10 ns;
shift <= "00011";
wait for 10 ns;
shift <= "00100";
wait for 10 ns;
shift <= "00101";
wait for 10 ns;
shift <= "00110";
wait for 10 ns;
shift <= "00111";
wait for 10 ns;
shift <= "01000";
wait for 10 ns;
shift <= "01001";
wait for 10 ns;
shift <= "01010";
wait for 10 ns;
shift <= "01011";
wait for 10 ns;
shift <= "01100";
wait for 10 ns;
shift <= "01101";
wait for 10 ns;
shift <= "01110";
wait for 10 ns;
shift <= "01111";
wait for 10 ns;
shift <= "10000";
wait for 10 ns;
shift <= "10001";
wait for 10 ns;
shift <= "10010";
wait for 10 ns;
shift <= "10011";
wait for 10 ns;
shift <= "10100";
wait for 10 ns;
shift <= "10101";
wait for 10 ns;
shift <= "10110";
wait for 10 ns;
shift <= "10111";
wait for 10 ns;
shift <= "11000";
wait for 10 ns;
shift <= "11001";
wait for 10 ns;
shift <= "11010";
wait for 10 ns;
shift <= "11011";
wait for 10 ns;
shift <= "11100";
wait for 10 ns;
shift <= "11101";
wait for 10 ns;
shift <= "11110";
wait for 10 ns;
shift <= "11111";
wait for 10 ns;
if(ctrl = "100") then 
	ctrl<="000";
else 
	ctrl<=ctrl+1;
end if;
 end process;
-- verifier
-- process
-- variable error_status: boolean;
-- begin
--wait on m;
---wait for 5 ns;
--if(A = "01000000000000000000000000000000" and B="01000000000000000000000000000001") then
--if( (m="0000" and S= "10000000000000000000000000000001" and c='0' and ovf='1') or
-- (m="0001" and S= "10000000000000000000000000000001" and c='0') or
-- ( m="0010" and S= "11111111111111111111111111111111" and c='1' and ovf='0' and z='0') or
-- ( m="0011" and S= "11111111111111111111111111111111" and c='1') or
 --(m="0100" and S= "00000000000000000000000000000001") or
-- ( m="0101" and S= "0000000000000000000000000000001" ) or
-- ( m="0110" and S= "01000000000000000000000000000000" ) or
 --( m="0111" and S= "01000000000000000000000000000001") or
--(m="1000" and S=   "10111111111111111111111111111110" )or
 --(m="1001" and S= "00000000000000000000000000000001" )) then
--error_status := false;
--else
--error_status := true;--
--end if;

-- error reporting
 --assert not error_status
 --report "test failed."
 --severity note;
--end if;
--if(A = "01000000000000000000000000000001" and B="01000000000000000000000000000001") then
--if(( m="0000" and S= "10000000000000000000000000000010" and c='0' and ovf='1') or
 --(m="0001" and S= "10000000000000000000000000000010" and c='0') or
 --( m="0010" and S= "0000000000000000000000000000000" and c='0' and ovf='0' and z='1') or
-- ( m="0011" and S= "0000000000000000000000000000000" and c='0') or
-- (m="0100" and S= "00000000000000000000000000000000") or
-- ( m="0101" and S= "0000000000000000000000000000000" ) or
-- ( m="0110" and S= "01000000000000000000000000000000" ) or
-- ( m="0111" and S= "01000000000000000000000000000010") or
--(m="1000" and S=   "10111111111111111111111111111101" )or
--( m="1001" and S= "00000000000000000000000000000010" )) then
--error_status := false;
--else
--error_status := true;
--end if;
 --error reporting
 --assert not error_status
 --report "test failed."
-- severity note;
--end if;
 --end process;
end one;
