library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity MIPS-Monociclo is
    Port (
        clk : in  std_logic;

        --deixei todos os IN comentados, e só os out pra gente poder acompanhar os valores deles no quartus
        -- do controle
        TRegDst,TDVI,TDVC,TLerMem,TMemParaReg out std_logic;
        TULAOp: out std_logic_vector(1 downto 0);
        TEscMem,TULAFonte,TEscReg, : out std_logic

        -- do datapath
        --clk: in STD_LOGIC;
		--RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
		--Instrucao: in STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao
		TSinal_pro_Controle,TEndereco_Memoria_Instrucao,TEndereco_Memoria_Dados: out STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
		--Dado,Dado_Escrita,Dado_lido_Mem_Dados: in STD_LOGIC_VECTOR(31 downto 0); -- Dados para manipulacao
    );
end entity;

architecture arch of Monociclo is
    Signal RegDst, DVI, DVC, LerMem, MemParaReg: std_logic;
    Signal ULAOp: std_logic_vector(1 downto 0);
    Signal EscMem, ULAFonte, EscReg: std_logic
    Signal RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: STD_LOGIC ; -- Sinais de controle
    Signal Instrucao: STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao
    Signal Sinal_pro_Controle,Endereco_Memoria_Instrucao,Endereco_Memoria_Dados: STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
    Signal Dado,Dado_Escrita,Dado_lido_Mem_Dados: STD_LOGIC_VECTOR(31 downto 0); -- Dados para manipulacao

    Datapath : entity work.Datapath(arch)
        port map(
            clk,
            RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg,
            Instrucao,
            Sinal_pro_Controle,Endereco_Memoria_Instrucao,Endereco_Memoria_Dados,
            Dado,Dado_Escrita,Dado_lido_Mem_Dados
            );

    Controle : entity work.Controle(arch)
        port map(
            Opcode,
            RegDst,DVI,DVC,LerMem,MemParaReg,
            ULAOp,
            EscMem,ULAFonte,EscReg
            );

-- Atribuindo os sinais de controle para podermos ver no quartus e fazer os testes
TRegDst <= RegDst;
TDVI <= DVI
TDVI <= DVI
TLerMem <= LerMem
TMemParaReg <= MemParaReg
TULAOp <= ULAOp
TEscMem <= EscMem
TULAFonte <= ULAFonte
TEscReg <= EscReg
TSinal_pro_Controle <= Sinal_pro_Controle
TEndereco_Memoria_Instrucao <= Endereco_Memoria_Instrucao
TEndereco_Memoria_Dados <= Endereco_Memoria_Dados

-- criei signals com os mesmos nomes das portas dos componentes, se a gente fosse mapea-las diretamente ficaria algo
-- tipo RegDst <= RegDst , pode fazer isso?
-- além disso, deixei os signals de out para fora para ver nas sinais de onda, funciona fazer assim para fazer os teste?


end arch;