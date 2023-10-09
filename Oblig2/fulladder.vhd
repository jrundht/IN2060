library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity fulladder is 
 port(a, b, cin: in  STD_LOGIC;
      cout, s:   out STD_LOGIC);
end ;

architecture synth of fulladder is 
begin
 cout <= ((a xor b) and cin) or (a and b);
 s <= (a xor b) xor cin;
end;