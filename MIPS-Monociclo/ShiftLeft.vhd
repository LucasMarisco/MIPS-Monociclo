-- Se precisar

library ieee;
use ieee.std_logic_1164.all;
use iee.numeric_std.ALL; 

entity ShiftLeft is
    generic (
        N : integer := 8; -- Largura padrão do vetor de entrada
        bit_extra : boolean := true -- Define se os bits extras serão mantidos
    );
    port (
        A  : in std_logic_vector(N - 1 downto 0); -- Vetor de entrada
        B : out std_logic_vector -- Vetor de saída (tamanho variável)
    );
end ShiftLeft;

architecture arch of ShiftLeft is
    -- Definir o tamanho do vetor de saída com base no parâmetro genérico
    constant saida : integer := 
        (bit_extra) ? (N + 2) : N; -- Calcula o tamanho da saída com base em bit_extra

begin
    process(A)
    variable temp : std_logic_vector(saida - 1 downto 0); -- Vetor temporário para manipulação dos dados
    begin
        -- Inicializa o vetor temporário com zeros
        temp := (others => '0');

        -- Realiza o shift left de 2 posições com concatenação
        temp := A & "00"; -- Desloca o vetor de entrada à esquerda em 2 posições

        -- Ajusta o tamanho do vetor de saída baseado no parâmetro genérico
        if bit_extra then
            B <= temp; -- Mantém os bits extras na saída
        else
            B <= temp(N - 1 downto 0); -- Descarta os bits extras e mantém apenas o tamanho original
        end if;
    end process;
end arch;



