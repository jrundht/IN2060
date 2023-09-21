library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity minority is
 port(a, b, c: in STD_LOGIC;
      y:       out STD_LOGIC);
end;

architecture synth of minority is
begin
 y <= ((not a and not b) or (not b and not c)) 
	or (not a and not c) ;
end;