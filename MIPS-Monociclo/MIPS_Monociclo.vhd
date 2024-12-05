library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity MIPS_Monociclo is
    Port (
        clk, rst : in  std_logic


        --deixei todos os IN comentados, e só os out pra gente poder acompanhar os valores deles no quartus
        -- do controle
        -- TRegDst,TDVI,TDVC,TLerMem,TMemParaReg: out std_logic;
        -- TULAOp: out std_logic_vector(1 downto 0);
        -- TEscMem,TULAFonte,TEscReg : out std_logic;

        -- do datapath
        --clk: in STD_LOGIC;
		--RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
		-- TInstrucao: in STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao ++++++++++++++++++++++++++++++++++++++
		-- TSinal_pro_Controle: out STD_LOGIC_VECTOR(5 downto 0);
		-- TEndereco_Memoria_Instrucao,TEndereco_Memoria_Dados: out STD_LOGIC_VECTOR(31 downto 0) -- Entrada da memoria de instrucao e de dados
		--Dado,Dado_Escrita,
        -- Dado_lido_Mem_Dados: in STD_LOGIC_VECTOR(31 downto 0) -- +++++++++++++++++++++++++++++++++
    );
end entity;

architecture arch of MIPS_Monociclo is
    Signal RegDst, DVI, DvC, LerMem, MemParaReg: std_logic;
    Signal ULAOp: std_logic_vector(1 downto 0);
    Signal EscMem, ULAFonte, EscReg: std_logic;
    Signal Instrucao: STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao
    Signal Sinal_pro_Controle: STD_LOGIC_VECTOR(5 downto 0);
	Signal Endereco_Memoria_Instrucao,Endereco_Memoria_Dados,Dado_a_ser_escrito: STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
    Signal Dado,Dado_Escrita,Dado_lido_Mem_Dados: STD_LOGIC_VECTOR(31 downto 0); -- Dados para manipulacao

    begin

        Datapath : entity work.Datapath(arch)
            port map(
                clk, rst,
                RegDst,DvI,DvC,LerMem,MemParaReg,EscMem,ULAFonte,EscReg,
                ULAOp,
                Instrucao, -- tá como IN no MIPS_MONOCICLO, tem o signal intrução mas tô ignoradando ele por hora
                Sinal_pro_Controle,
                Endereco_Memoria_Instrucao,Endereco_Memoria_Dados,Dado_a_ser_escrito,
                Dado,Dado_Escrita,Dado_lido_Mem_Dados
                );

        Controle : entity work.Controle(arch)
            port map(
                Sinal_pro_Controle,
                RegDst,DVI,DVC,LerMem,MemParaReg,
                ULAOp,
                EscMem,ULAFonte,EscReg
                );



        Memoria_de_Intrucao : entity work.Mem_Instr(Behavioral)
        port map(
           Endereco_Memoria_Instrucao, -- esse signal faz a ligação entre o Datapath e a Memoria 
           Instrucao -- esse signal "manda" a instrucao da memoria para o Datapath
           );

        Memoria_de_Dados : entity work.Mem_Dados(Behavioral)
        port map(
            clk,
           Endereco_Memoria_Dados, -- *
            Dado_a_ser_escrito, -- *
           EscMem,
            LerMem ,
            Dado_lido_Mem_Dados -- *
            -- * são os signals que podem dar algum problema, pq estão fazendo a manipulação entre o datapath e as memorias
            -- aí pode ser que fazer isso fora do datapath esteja dando erro, mas temos que ver
        );
      

-- Atribuindo os sinais de controle para podermos ver no quartus e fazer os testes
-- TRegDst <= RegDst;
-- TDVI <= DVI;
-- TLerMem <= LerMem;
-- TMemParaReg <= MemParaReg;
-- TULAOp <= ULAOp;
-- TEscMem <= EscMem;
-- TULAFonte <= ULAFonte;
-- TEscReg <= EscReg;
-- TSinal_pro_Controle <= Sinal_pro_Controle;
-- TEndereco_Memoria_Instrucao <= Endereco_Memoria_Instrucao;
-- TEndereco_Memoria_Dados <= Endereco_Memoria_Dados;

-- criei signals com os mesmos nomes das portas dos componentes, se a gente fosse mapea-las diretamente ficaria algo
-- tipo RegDst <= RegDst , pode fazer isso?
-- além disso, deixei os signals de out para fora para ver nas sinais de onda, funciona fazer assim para fazer os teste?
end arch;