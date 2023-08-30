library IEEE; -- bibliotek
        use IEEE.STD_LOGIC_1164.all; -- pakke

entity halfadder is
        port(
                a,b : in std_logic; -- inputs
                s : out std_logic; -- sum
                c : out std_logic -- carry
        );
end entity halfadder;

architecture dataflow of halfadder is
begin
        s <= a xor b; -- lagt til ;
        c <= a and b;
end architecture dataflow;

