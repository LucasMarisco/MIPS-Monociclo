library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Subtrator_Generico is
    generic (n : positive := 32);
    port (
        a, b: in std_logic_vector (n-1 downto 0);
        s: out std_logic_vector (n-1 downto 0)
    );
end entity;

architecture arch of Subtrator_Generico is
signal sinal: std_logic_vector (n downto 0);
begin

    sinal <= std_logic_vector(signed('0' & a) - signed('0' & b));
    s <= sinal(n-1 downto 0);

end arch;
