--- temos 32 bits na entrada e 32 bits na saiad
-- ou seja, cada registrador armazena um numeor de 32 bits
--
library ieee;
use ieee.std_logic_1164.all;

entity Banco_de_Registradores is
    generic (
        LarguraDosReg : integer := 5  -- Largura do registrador (padrão: 8 bits)
        LarguraDosReg : integer := 5  -- Largura do registrador (padrão: 8 bits)
    );
    port (
        CLK, EN : in std_logic; -- Entradas de Controle
        RegLer1,RegLer2,RegEsc : in std_logic_vector(N-1 downto 0); -- Endereço dos Registradores(seriam respectivamente os rs,rt,rd dos slides)
        DadoParaEscrever : in std_logic_vector(31 downto 0); -- Dado a ser Escrito
        DadoLido1,DadoLido2 : out std_logic_vector(N-1 downto 0) -- Saida de Dados(saida dos valores do Registradores Lidos)
    );
end entity;

component Decod is
    generic (
        N : integer := 5  -- Largura do registrador (padrão: 8 bits)
    );
    port (
        CLK, EN : in std_logic; -- Entradas de Controle
        RegLer1,RegLer2,RegEsc : in std_logic_vector(N-1 downto 0); -- Endereço dos Registradores(seriam respectivamente os rs,rt,rd dos slides)
        DadoParaEscrever : in std_logic_vector(31 downto 0); -- Dado a ser Escrito
        DadoLido1,DadoLido2 : out std_logic_vector(N-1 downto 0) -- Saida de Dados(saida dos valores do Registradores Lidos)
    );
end entity;
architecture arch of Banco_de_Registradores is
type MemoriaRam is array (0 to )



begin



end arch;