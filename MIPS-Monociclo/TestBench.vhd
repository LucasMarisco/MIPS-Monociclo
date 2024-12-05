library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench is
-- O testbench não tem portas porque é usado apenas para simulação.
end entity;

architecture arch of TestBench is

    signal clk: std_logic :='0';
    signal rst: std_logic := '1';
    signal finished: std_logic := '0';
    CONSTANT period : TIME := 20 ns;

begin
    -- Conexão entre o DUT e os sinais do testbench
    DUT: entity work.MIPS_Monociclo(arch)
        port map (
            clk=>clk,
            rst=>rst
        );

    -- geracao clock
    clk <= not clk after period/2 when finished /= '1' else '0';

    process
    begin

        wait for 2*period;

        rst <= '0';

    end process;

    

    -- Processo de teste
    -- process
    -- begin
    --     -- Testa o endereço 0 (espera ADDI $10, $9, 12)
    --     TInstrucao <= "00100001001010100000000000001100";
    --     wait for 10 ns;  -- Espera 10 ns para observar o resultado
    --     assert Intrucao_lida_tb = "00100001001010100000000000001100"
    --         report "Erro: Endereço 0 não retornou ADDI $10, $9, 12"
    --         severity error;

    --     -- Testa o endereço 4 (espera ADDI $13, $10, 5)
    --     Endereco_tb <= x"00000004";
    --     wait for 10 ns;
    --     assert Intrucao_lida_tb = "00100001010011010000000000000101"
    --         report "Erro: Endereço 4 não retornou ADDI $13, $10, 5"
    --         severity error;

    --     -- Testa o endereço 8 (espera LW $14, 4($10))
    --     Endereco_tb <= x"00000008";
    --     wait for 10 ns;
    --     assert Intrucao_lida_tb = "10001101010011100000000000000100"
    --         report "Erro: Endereço 8 não retornou LW $14, 4($10)"
    --         severity error;

    --     -- Testa o endereço 12 (espera SW $15, 8($10))
    --     Endereco_tb <= x"0000000C";
    --     wait for 10 ns;
    --     assert Intrucao_lida_tb = "10101101010011110000000000001000"
    --         report "Erro: Endereço 12 não retornou SW $15, 8($10)"
    --         severity error;

    --     -- Fim do teste
    --     wait; -- Aguarda indefinidamente para encerrar a simulação
    -- end process;

end arch;
