library ieee;
use ieee.std_logic_1164.all;

entity Registrador_Generico is
    generic (
        N : integer := 8  -- Largura do registrador (padrão: 8 bits)
    );
    port (
        CLK, EN : in std_logic; -- Entradas de Controle
        D : in std_logic_vector(N-1 downto 0); -- Entrada de Dados
        Q : out std_logic_vector(N-1 downto 0) -- Saida de Dados
    );
end Registrador_Generico;

architecture arch of Registrador_Generico is
begin
    process(CLK)
    begin
        if rising_edge(CLK) then -- Se na borda de subida
            if EN = '1' then  -- Enable estiver ativo
                Q <= D; -- O registrador admite a entrada e deixa os dados na saida
            end if;
        end if;
    end process;
end arch;
