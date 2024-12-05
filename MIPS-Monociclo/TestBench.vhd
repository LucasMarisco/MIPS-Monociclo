library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TestBench is
-- O testbench não tem portas porque é usado apenas para simulação.
end entity;

architecture arch of TestBench is

    signal TRegDst,TDVI,TDVC,TLerMem,TMemParaReg: std_logic;
    signal TULAOp:  std_logic_vector(1 downto 0);
    signal TEscMem,TULAFonte,TEscReg:  std_logic;
    signal TSinal_pro_Controle: STD_LOGIC_VECTOR(5 downto 0);
    signal 

    -- Instancia o módulo a ser testado
    component MIPS_Monociclo is
        Port (
            clk : in  std_logic;

            --deixei todos os IN comentados, e só os out pra gente poder acompanhar os valores deles no quartus
            -- do controle
            TRegDst,TDVI,TDVC,TLerMem,TMemParaReg: out std_logic;
            TULAOp: out std_logic_vector(1 downto 0);
            TEscMem,TULAFonte,TEscReg : out std_logic;
    
            -- do datapath
            --clk: in STD_LOGIC;
            --RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
            TInstrucao: in STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao ++++++++++++++++++++++++++++++++++++++
            TSinal_pro_Controle: out STD_LOGIC_VECTOR(5 downto 0);
            TEndereco_Memoria_Instrucao,TEndereco_Memoria_Dados: out STD_LOGIC_VECTOR(31 downto 0) -- Entrada da memoria de instrucao e de dados
            --Dado,Dado_Escrita,
            --Dado_lido_Mem_Dados: in STD_LOGIC_VECTOR(31 downto 0); -- +++++++++++++++++++++++++++++++++(acho que não rola de forçar essa)
        );
    end component;

begin
    -- Conexão entre o DUT e os sinais do testbench
    DUT: Mem_Instr
        port map (
            clk, 
            TRegDst,TDVI,TDVC,TLerMem,TMemParaReg,
            TULAOp,
            TEscMem,TULAFonte,TEscReg,
            TSinal_pro_Controle,
            TEndereco_Memoria_Instrucao,TEndereco_Memoria_Dados
        );

    -- Processo de teste
    process
    begin
        -- Testa o endereço 0 (espera ADDI $10, $9, 12)
        TInstrucao <= "00100001001010100000000000001100";
        wait for 10 ns;  -- Espera 10 ns para observar o resultado
        assert Intrucao_lida_tb = "00100001001010100000000000001100"
            report "Erro: Endereço 0 não retornou ADDI $10, $9, 12"
            severity error;

        -- Testa o endereço 4 (espera ADDI $13, $10, 5)
        Endereco_tb <= x"00000004";
        wait for 10 ns;
        assert Intrucao_lida_tb = "00100001010011010000000000000101"
            report "Erro: Endereço 4 não retornou ADDI $13, $10, 5"
            severity error;

        -- Testa o endereço 8 (espera LW $14, 4($10))
        Endereco_tb <= x"00000008";
        wait for 10 ns;
        assert Intrucao_lida_tb = "10001101010011100000000000000100"
            report "Erro: Endereço 8 não retornou LW $14, 4($10)"
            severity error;

        -- Testa o endereço 12 (espera SW $15, 8($10))
        Endereco_tb <= x"0000000C";
        wait for 10 ns;
        assert Intrucao_lida_tb = "10101101010011110000000000001000"
            report "Erro: Endereço 12 não retornou SW $15, 8($10)"
            severity error;

        -- Fim do teste
        wait; -- Aguarda indefinidamente para encerrar a simulação
    end process;

end arch;
