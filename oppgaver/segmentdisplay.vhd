library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity segmentdisplay is
 port( A: in STD_LOGIC_VECTOR(3 downto 0);
       y: out STD_LOGIC_VECTOR(6 downto 0));
end;
