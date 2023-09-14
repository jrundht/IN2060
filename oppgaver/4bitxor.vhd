library IEEE;
use IEEE.STD_LOGIC_1164.all;
--4bitxor
entity bitxor is port(
	a: in STD_LOGIC_VECTOR(3 downto 0);
	y: out STD_LOGIC);
end;
 architecture synth of bitxor is
 begin
y <= a(3) xor a(2) xor a(1) xor a(0);
end;
