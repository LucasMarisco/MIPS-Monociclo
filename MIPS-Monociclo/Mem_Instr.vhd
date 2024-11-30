library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mem_Instr is
    port (
        Endereco : in std_logic_vector(31 downto 0);  -- Endereço da instrução
        Intrucao_lida : out std_logic_vector(31 downto 0) -- Instrução lida
    );
end entity;

architecture Behavioral of Mem_Instr is
    type ROM is array (0 to 32) of std_logic_vector(31 downto 0);
    -- aqui estamos criando um mémoria de 32 espaços, com cada espaço tendo 32 bits
    -- ou seja, podemos ter 6 instruções, e cada instrução tem 32 bits( ou seja, vamos ter que escrever las na mão)
    -- para aumentar a quantidade de intruções é só fazer

    signal memoria : ROM;
    -- como o MIPS lê de 4 em 4, ele vai acessar a memoria sempre assim(daria pra fazer ele ler aquelas half-word, mas acho não vamos abordar isso)

    signal adress: integer; -- definimos esse signal para facilitar a leitura do código
    begin

        -------------------Coloque aqui as intruções que o MIPS vai fazer-----------
        memoria(0)  <= "00000000000000000000000000000000"; -- NOP
        memoria(4)  <= "00000001000010010101000000100000"; -- ADD $t2, $t0, $t1 (soma os valores do regt0 e t1 e salva no t2)
        memoria(8)  <= "00000001001010000101100000100010"; -- SUB $t3, $t1, $t0
        memoria(12) <= "10001101000010010000000000000100"; -- LW $t1, 4($t0)
        memoria(16) <= "10101101000010010000000000001000"; -- SW $t1, 8($t0)
        memoria(20) <= "00010001000010010000000000010000"; -- BEQ $t0, $t1, 16        
        memoria(24) <= "00000000000000000000000000000000";
        memoria(28) <= "00000000000000000000000000000000";
        memoria(32) <= "00000000000000000000000000000000";
        ----------------------------------------------------------------------------

        adress <= (to_integer(unsigned(Endereco)));
        -- aqui estamos transformando o Endereço em um Unsigned, pois não teremos Endereço negativo
        -- depois convertemos ele para um inteiro, para podermos fazer algo tipo memoria(4), esse 4 é
        -- o inteiro que vai vir dessa conversão por exemplo.
        -- acho que daria para otimizar isso restringindo só até o bit 6, pq com 32 bits, só precisamos de
        -- 6 bits para representar tudo, mas vou deixar os 32 só por precaução
        Intrucao_lida <= memoria(adress);
end Behavioral;