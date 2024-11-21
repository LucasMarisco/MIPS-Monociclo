library ieee;
use ieee.std_logic_1164.all;

entity Multiplexador_generico is
    generic (
        N : positive := 8  -- Largura do vetor (padrão: 8 bits)
    );
    port (
        A, B : in std_logic_vector(N-1 downto 0);  -- Entradas do mux
        SEL  : in std_logic;                       -- Sinal de seleção
        Y    : out std_logic_vector(N-1 downto 0)  -- Saída do mux
    );
end Multiplexador_generico;

architecture arch of Multiplexador_generico is
begin
    process(A, B, SEL)
    begin
        if SEL = '0' then
            Y <= A;  -- Seleciona A quando SEL é 0
        else
            Y <= B;  -- Seleciona B quando SEL é 1
        end if;
    end process;
end arch;

