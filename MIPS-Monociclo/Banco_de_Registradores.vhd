--- temos 32 bits na entrada e 32 bits na saiad
-- ou seja, cada registrador armazena um numeor de 32 bits
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Banco_de_Registradores is
    generic (
        NumBitsEndereco : integer := 5  -- vamos usar 5 bits de Endereço, logo temos 2^5 registradores
        NumBitsDosReg : integer := 32  -- Qual o tamanho do valor que eles tem dentro
    );
    port (
        clk, EscReg : in std_logic; -- Entradas de Controle
        LerDoReg1,LerDoReg2,EscreverNoReg : in std_logic_vector(NumBitsEndereco-1 downto 0); -- Endereço dos Registradores(seriam respectivamente os rs,rt,rd dos slides)
        DadoParaEscrever : in std_logic_vector(NumBitsDosReg-1 downto 0); -- Dado a ser Escrito
        DadoLido1,DadoLido2 : out std_logic_vector(NumBitsEndereco-1 downto 0) -- Saida de Dados(saida dos valores do Registradores Lidos)
    );
end entity;

architecture arch of Banco_de_Registradores is
type MemoriaRam is array (0 to 2**NumBitsEndereco) of std_logic_vector(NumBitsDosReg-1 downto 0);
-- aqui temos uma Lista de 0 até 2^5 registradores de 32 bits cada
-- ou seja, como o enderço tem 5 bits, vamos poder acessar o array usando o endereço como posição do Registrador no Array
signal ram: MemoriaRam;
begin

    leitura:process(LerDoReg1,LerDoReg2) is -- Pergunta
        begin
            DadoLido1 <= ram(to_integer(unsigned(LerDoReg1)));
            DadoLido2 <= ram(to_integer(unsigned(LerDoReg2)));
            -- aqui estamos acessando o array que criamos, como cada posição é um Registrador, basta pegarmos
            -- o valor do LerDoReg1(q é endereço do nosso Reg) e convertermos para um inteiro, mas para evitar
            -- valores negativos temos que transforma-lo em unsigened

    escrita:process(clk) is
        begin
            if rising_edge(clk) then
                if EscReg = '1' then
                    ram(to_integer(unsigned(LerDoReg2))) <= DadoParaEscrever; 
                    -- aqui estamos fazendo a mesma coisa, determinamos qual é o registrador que vamos querer escrever
                    -- e escrevemos nele com o DadoParaEscrever
                end if;
            end if;
        end process;
end arch;