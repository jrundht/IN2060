library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CLA_block is
port(
 a, b : in std_logic_vector(3 downto 0);
 cin  : in std_logic;
 s    : out std_logic_vector(3 downto 0);
 cout : out std_logic);
end entity CLA_block;

architecture mixed of CLA_block is

component fulladder
 port(
    a, b, cin: in  STD_LOGIC;
      cout, s: out STD_LOGIC
 );
end component;

signal p, g:     std_logic_vector(3 downto 0);
signal c:        std_logic_vector(4 downto 0);
signal p30, g30: STD_LOGIC;

begin
  g(0) <= a(0) and b(0); g(1) <= a(1) and b(1);
  g(2) <= a(2) and b(2); g(3) <= a(3) and b(3);

  p(0) <= a(0) or b(0); p(1) <= a(1) or b(1);
  p(2) <= a(2) or b(2); p(3) <= a(3) or b(3);
 
  p30 <= and p;
  g30 <= (((((p(1) and g(0)) or g(1)) and p(2)) or g(2)) and p(3)) or g(3);

  c(0) <= cin;
  c(1) <= g(0) or (p(0) and cin);
  c(2) <= g(1) or (p(1) and c(1));
  c(3) <= g(2) or (p(2) and c(2));
  c(4) <= g(3) or (p(3) and c(3));

  cout <= ((((((p(1) and g(0)) or g(1)) and p(2)) or g(2)) and p(3)) or g(3)) or ((and p) and cin); -- = c(4)
  --cout <= c(4);

  FA1: fulladder port map(a(0), b(0), c(0), s(0));
  FA2: fulladder port map(a(1), b(1), c(1), s(1));
  FA3: fulladder port map(a(2), b(2), c(2), s(2));
  FA4: fulladder port map(a(3), b(3), c(3), s(3));
end mixed;