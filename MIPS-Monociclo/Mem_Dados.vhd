library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem_Dados is
    port (
        clk : in std_logic; -- Clock
        Endereco : in std_logic_vector(31 downto 0); -- Endereço de leitura/escrita
        Dado_a_ser_escrito : in std_logic_vector(31 downto 0); -- Dados para escrita
        EscMem : in std_logic; -- Habilita escrita
        LerMem : in std_logic; -- Habilita leitura
        Dado_lido : out std_logic_vector(31 downto 0) -- Dados lidos
    );
end entity;

architecture Behavioral of Mem_Dados is
    type RAM is array (0 to 127) of std_logic_vector(31 downto 0);
    -- como o MIPS lê instruções de 4 em 4, temos 128/4 = 32 espaços disponives
    signal memoria : RAM;
    -- sinal para manipularmos a memoria criada, inicializamos ela com zeros, aí caso a gente tente acessar um espaço nada escrito
    -- não teremos problemas(tirei do final, mas é assim   := (others => (others => '0')))
    signal adress: integer; -- definimos esse signal para facilitar a leitura do código
    begin
			
		  adress <= (to_integer(unsigned(Endereco)));	
        process(clk)
        begin
            if rising_edge(clk) then
                if EscMem = '1' then
                   
                    memoria(adress) <= Dado_a_ser_escrito; -- escrevemos na memória 
                    -- lembre que o adress é sempre um multipli de 4!
                end if;
            end if;
        end process;

        process(Endereco,LerMem)
        begin
            if LerMem = '1' then
                Dado_lido <= memoria(adress);
            else 
                Dado_lido <= (others => '0'); -- caso o Endereço mude de valor, mas o LerMem está desativado, só retornamos zero na saida
            end if;
            -- isso já é bom pq aí caso tentemos acessar uma parte da memoria que não tem valor acho q não vai dar problema...
        -- mas se tiver dando ruim podemos tentar zerar as outras posições na memoria(as que não são multiplos de 4)
        end process;
       
end Behavioral;