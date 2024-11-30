LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Datapath IS
    PORT (
	 -- Sinais de Controle, Entrada e Saída
			clk: in STD_LOGIC;
			RegDst,DvI,DvC,LerMem,MemParaReg,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
			ULAOp : in STD_LOGIC_VECTOR(1 DOWNTO 0) ;
			Instrucao: in STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao
			Sinal_pro_Controle: out STD_LOGIC_VECTOR(5 downto 0);
			Endereco_Memoria_Instrucao,Endereco_Memoria_Dados,Dado_a_ser_escrito: out STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
			Dado,Dado_Escrita,Dado_lido_Mem_Dados: in STD_LOGIC_VECTOR(31 downto 0) -- Dados para manipulacao
            -- não usamos o Dado_Escrita, dar uma olhada nisso 
    );
END ENTITY;

ARCHITECTURE arch OF Datapath IS
SIGNAL CarryOut, Zero, FontePC : STD_LOGIC;
SIGNAL cULA : STD_LOGIC_VECTOR(2 downto 0);
SIGNAL M1: STD_LOGIC_VECTOR (4 downto 0);
SIGNAL Instr : STD_LOGIC_VECTOR (25 downto 0);
SIGNAL sPC,ES,A,B,M2,Endereco_Dados,M3,S1,D1,D2,S2,M4,M5: STD_LOGIC_VECTOR (31 downto 0);
BEGIN
   -- Componentes e ligacoes
	-- LOGICA REFERENTE AO PC
	
	PC : entity work.Registrador_Generico(arch)
			generic map (32)
			port map (clk, '1', M5, sPC);
				   -- clk,  en,  d,  q

    Endereco_Memoria_Instrucao <= sPC;
	--parte onde ocorre a quebra do sinal de 32 bits lá
    Sinal_pro_Controle <= Instrucao(31 downto 26);
	Instr <= Instrucao(25 DOWNTO 0);

    -- ver se é nessa ordem que faz a concatenação
    D1 <= Instr & "00" & S1(31 downto 28); -- já fazendo o deslocamento a esquerda e a concatenação com o PC+4(31-28)(Nosso S1)
	
	Somador1 : entity work.Somador_Generico(arch)
			generic map (32)
			port map (sPC,"00000000000000000000000000000100", S1, CarryOut);

    D2 <= ES(29 downto 0) & "00"; -- cortamos os mais significativos e adicionamos "00" para fazer o shiftleft
			
	Somador2 : entity work.Somador_Generico(arch)
			generic map (32)
			port map (S1, D2, S2, CarryOut);
	
	MUX4 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(S1,S2,FontePC,M4);
			
	FontePC <= DvC and Zero;
	
	MUX5 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(D1,M4,DVI,M5);
	
	-- LOGICA REFERENTE AOS BANCO DE REGISTRADORES E A ULA
	
	Banco_Reg : entity work.Banco_de_Registradores(arch)
			generic map (5,32) -- pode fazer assim?(pq temos 2 generics, aí)
            -- NumBitsEndereco e NumBitsDosReg
			port map (clk,EscReg,Instr(25 downto 21), Instr(20 downto 16), M1, M3, A, B);
            --        clk,EscReg,     LerDoReg1,      LerDoReg2,  EscreverNoReg,DadoParaEscrever,DadoLido1,DadoLido2
			--							5				5				5		   32				32			32			
	Dado_a_ser_escrito <= B; -- vamos enviar esse sinal para a memoria de Dados

	MUX1 : entity work.Multiplexador_Generico(arch)
		generic map (5)
		port map (Instr(20 downto 16), Instr(15 downto 11),RegDst,M1);	

	-- veer se é assim que é pra fazer a extensão de sinal(ver se é nessa ordem no caso)				
	ES <= Instr(15 downto 0) & "0000000000000000"; -- ficamos com um sinal de 32 bits
	
	-- Lembra de mudar o nome da ULA para underline "-" -> "_"
	
	Ctrl_ULA : entity work.Ctrl_ULA(arch)
		port map(ULAOp, Instr(5 downto 0),cULA);
	
	MUX2 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(B,ES,ULAFonte,M2);
	
    --Olhar com cuidado aqui pq estamos fazendo a troca de informações com o Mem_Dados que não está em VHDL,
    --ver se podemos fazer isso dessa forma
	ULA : entity work.ULA(arch)
			port map (A, M2, cULA, Zero, Endereco_Dados);	
	
	Endereco_Memoria_Dados <= Endereco_Dados;
	
	MUX3: entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(Dado_lido_Mem_Dados, Endereco_Dados, MemParaReg,M3);
			
END ARCHITECTURE arch;