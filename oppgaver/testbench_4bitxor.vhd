library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Exercise 4.5
entity testbench_4bitxor is --no inputs or outputs
end;

architecture sim of testbench_4bitxor is
 component bitxor
  port( a: in STD_LOGIC_VECTOR(3 downto 0);
        y: out STD_LOGIC);
  end component;
  signal a: STD_LOGIC_VECTOR(3 downto 0);
  signal y: STD_LOGIC;
begin 
-- instantiate DUT (device under test)
dut: bitxor port map(a, y);

--apply inputs one at a time
--checking results

process begin 
 report "Starting simulation";
 a(3) <= '0'; a(2) <= '0'; a(1) <= '0'; a(0) <= '0'; wait for 10 ns;--0
  assert y = '0' report "000000000 failed.";
 a(3) <= '0'; a(2) <= '0'; a(1) <= '0'; a(0) <= '1'; wait for 10 ns;--1
  assert y = '1' report "000000001 failed.";
 a(3) <= '0'; a(2) <= '0'; a(1) <= '1'; a(0) <= '0'; wait for 10 ns;--2
  assert y = '1' report "000000010 failed.";
 a(3) <= '0'; a(2) <= '0'; a(1) <= '1'; a(0) <= '1'; wait for 10 ns;--3
  assert y = '0' report "000000011 failed.";
 a(3) <= '0'; a(2) <= '1'; a(1) <= '0'; a(0) <= '0'; wait for 10 ns;--4
  assert y = '1' report "000000100 failed.";
 a(3) <= '0'; a(2) <= '1'; a(1) <= '0'; a(0) <= '1'; wait for 10 ns;--5
  assert y = '0' report "000000101 failed.";
 a(3) <= '0'; a(2) <= '1'; a(1) <= '1'; a(0) <= '0'; wait for 10 ns;--6
  assert y = '0' report "00000110 failed.";
 a(3) <= '0'; a(2) <= '1'; a(1) <= '1'; a(0) <= '1'; wait for 10 ns;--7
  assert y = '1' report "00000111 failed.";
 a(3) <= '1'; a(2) <= '0'; a(1) <= '0'; a(0) <= '0'; wait for 10 ns;--8
  assert y = '1' report "00001000 failed.";
 a(3) <= '1'; a(2) <= '0'; a(1) <= '0'; a(0) <= '1'; wait for 10 ns;--9
  assert y = '0' report "00001001 failed.";
 a(3) <= '1'; a(2) <= '0'; a(1) <= '1'; a(0) <= '0'; wait for 10 ns;--10
  assert y = '0' report "00001010 failed.";
 a(3) <= '1'; a(2) <= '0'; a(1) <= '1'; a(0) <= '1'; wait for 10 ns;--11
  assert y = '1' report "00001011 failed.";
 a(3) <= '1'; a(2) <= '1'; a(1) <= '0'; a(0) <= '0'; wait for 10 ns;--12
  assert y = '0' report "00001100 failed.";
 a(3) <= '1'; a(2) <= '1'; a(1) <= '0'; a(0) <= '1'; wait for 10 ns;--13
  assert y = '1' report "00001101 failed.";
 a(3) <= '1'; a(2) <= '1'; a(1) <= '1'; a(0) <= '0'; wait for 10 ns;--14
  assert y = '1' report "00001110 failed.";
 a(3) <= '1'; a(2) <= '1'; a(1) <= '1'; a(0) <= '1'; wait for 10 ns;--15
  assert y = '0' report "00001111 failed.";
 wait; --wait forever
 end process;
end;