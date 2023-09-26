library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity tb_CLA_top is
end entity tb_CLA_top;

architecture behavioral of tb_CLA_top is

component CLA_top is
generic(width : positive := 32);
port(
 a, b : in std_logic_vector(width-1 downto 0);
 cin  : in std_logic;
 sum  : out std_logic_vector(width-1 downto 0);
 cout : out std_logic);
end component;

-- Tilordning av startverdi ved deklarasjon gjøres med :=
signal tb_a, tb_b : std_logic_vector(31 downto 0) := (others => '0');
signal tb_cin     : std_logic := '0';

-- outputs bør ikke få en startverdi i testbenken, da det kan maskere feil.
signal tb_s    : std_logic_vector(31 downto 0);
signal tb_cout : std_logic;

begin
-- instansiering:
DUT: CLA_top -- Merkelappen DUT betyr «device under test» som er en av mange
port map( -- vanlige betegnelser på simuleringsobjektet.
	a => tb_a, -- Mappinger gjøres med =>, til forskjell fra tilordninger som
	b => tb_b, -- bruker <= eller :=
	cin => tb_cin, -- Mappinger kan ses på en ren sammenkobling av ledninger
	sum => tb_s, -- Vi mapper alltid testenhetens porter til testbenkens signaler
	cout => tb_cout -- Siste informasjon før parantes-slutt har ikke ',' eller ';'
);
-- I testbenker kan vi ha prosesser uten sensitivitetsliste..
-- i slike prosesser kan vi angi tid med «wait» statements, og
-- vi kan sette signaler flere ganger etter hverandre uten å gi konflikter.
-- NB: Prosessen vil trigges om og om igjen om vi ikke hindrer det.
process
begin
	wait for 10 ns;
	-- Test 0
	tb_a <= std_logic_vector(to_unsigned(1,32)); 
	tb_b <= std_logic_vector(to_unsigned(2,32)); tb_cin <= '0'; wait for 10 ns;
  	assert (tb_s = std_logic_vector(to_unsigned(3,32)) and tb_cout = '0') 
	report "Failure, test 0 : Expected sum = " & to_string(to_unsigned(3,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 1
	tb_a <= std_logic_vector(to_unsigned(5,32)); 
	tb_b <= std_logic_vector(to_unsigned(6,32)); tb_cin <= '1'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(12,32)) and tb_cout = '0') 
	report "Failure, test 1 : Expected sum = " & to_string(to_unsigned(12,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 2 
	tb_a <= std_logic_vector(to_unsigned(2000000000,32)); 
	tb_b <= std_logic_vector(to_unsigned(100000000,32)); tb_cin <= '0'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(2100000000,32)) and tb_cout = '0') 
	report "Failure, test 2 : Expected sum = " & to_string(to_unsigned(2100000000,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 3 )
	tb_a <= std_logic_vector(to_unsigned(111,32)); 
	tb_b <= std_logic_vector(to_unsigned(222,32)); tb_cin <= '0'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(333,32)) and tb_cout = '0') 
	report "Failure, test 3 : Expected sum = " & to_string(to_unsigned(333,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & std_logic'image(tb_cout) severity failure;

	-- Test 4
	tb_a <= std_logic_vector(to_unsigned(555,32)); 
	tb_b <= std_logic_vector(to_unsigned(444,32)); tb_cin <= '0'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(999,32)) and tb_cout = '0') 
	report "Failure, test 4 : Expected sum = " & to_string(to_unsigned(999,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 5
	tb_a <= std_logic_vector(to_unsigned(15,32)); 
	tb_b <= std_logic_vector(to_unsigned(25,32)); tb_cin <= '1'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(41,32)) and tb_cout = '0') 
	report "Failure, test 5 : Expected sum = " & to_string(to_unsigned(41,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 6
	tb_a <= std_logic_vector(to_unsigned(1200,32)); 
	tb_b <= std_logic_vector(to_unsigned(800,32)); tb_cin <= '0'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(2000,32)) and tb_cout = '0') 
	report "Failure, test 6 : Expected sum = " & to_string(to_unsigned(2000,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 7
	tb_a <= std_logic_vector(to_unsigned(500,32)); 
	tb_b <= std_logic_vector(to_unsigned(1500,32)); tb_cin <= '1'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(2001,32)) and tb_cout = '0') 
	report "Failure, test 7 : Expected sum = " & to_string(to_unsigned(2001,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test 8
	tb_a <= std_logic_vector(to_unsigned(1300,32)); 
	tb_b <= std_logic_vector(to_unsigned(700,32)); tb_cin <= '0'; wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(2000,32)) and tb_cout = '0') 
	report "Failure, test 8 : Expected sum = " & to_string(to_unsigned(2000,32)) & ", got " & to_string(unsigned(tb_s)) 
		& ". Expected cout = '0', got " & to_string(tb_cout) severity failure;

	-- Test MSB 
	tb_a <= std_logic_vector(to_unsigned(2147483647,32));
	tb_b <= std_logic_vector(to_signed(-2147483647,32));  
	tb_cin <= '0';
	wait for 10 ns;
	assert (tb_s = std_logic_vector(to_unsigned(0,32)) and tb_cout = '1')
	report "Failure, MSB Only Test : Expected sum = " & to_string(to_unsigned(0,32)) & ", got " & to_string(unsigned(tb_s))
	& ". Expected cout = '1', got " & to_string(tb_cout) severity failure;

	-- Test Overflow 
	tb_a <= "11111111111111111111111111111111";  -- 4294967295 in binary
	tb_b <= std_logic_vector(to_unsigned(1,32));
	tb_cin <= '0';
	wait for 10 ns;
	assert (tb_s = "00000000000000000000000000000000" and tb_cout = '1')
	report "Failure, Overflow Test : Expected sum = " & to_string(to_unsigned(0,32)) & ", got " & to_string(unsigned(tb_s))
	& ". Expected cout = '1', got " & to_string(tb_cout) severity failure;

	-- Test Overflow igjen
	tb_a <= std_logic_vector(to_signed(15,32)); 
	tb_b <= std_logic_vector(to_signed(-15,32));
	tb_cin <= '0';
	wait for 10 ns;
	assert (tb_s = std_logic_vector(to_signed(0,32)) and tb_cout = '1')
	report "Failure, General Test with MSB : Expected sum = " & to_string(to_unsigned(0,32)) & ", got " & to_string(unsigned(tb_s))
	& ". Expected cout = '1', got " & to_string(tb_cout) severity failure;

	report("CLA_top - Alt stemmer!") severity note;
	std.env.stop; -- stopper simuleringen
	end process;
end architecture behavioral;