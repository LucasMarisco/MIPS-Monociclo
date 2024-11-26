LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Datapath IS
    PORT (
	 -- Sinais de Controle, Entrada e Saída
			clk: in STD_LOGIC;
			RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
			Instrucao: in STD_LOGIC_VECTOR(31 downto 0); -- Saida da memoria de instrucao
			Sinal_pro_Controle,Endereco_Memoria_Instrucao,Endereco_Memoria_Dados: out STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
			Dado,Dado_Escrita: in STD_LOGIC_VECTOR(31 downto 0); -- Dados para manipulacao
    );
END ENTITY;

ARCHITECTURE arch OF Datapath IS
SIGNAL CarryOut, Zero : STD_LOGIC;
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
	
	Somador1 : entity work.Somador_Generico(arch)
			generic map (32)
			port map (sPC,"00000000000000000000000000000100", S1, CarryOut);
			
	Somador2 : entity work.Somador_Generico(arch)
			generic map (32)
			port map (S1, D2, S2, CarryOut);
	
	MUX4 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(S1,S2,FontePC,M4);
			
	FontePC <= DvC and Zero;
	
	MUX5 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(M4,D1,DVI,M5);

	--defini o sinal Instr aqui, n sei se tá definido em outro lugar
	Instr <= Instrucao[25 DOWNTO 0];
	-- ver se é nessa ordem que a gente faz a concatenação
	D1 <= Instr & "00" & S1[31 downto 28]; -- já fazendo o deslocamento a esquerda
	D2 <= ES[29 downto 0] & "00";
	
	-- LOGICA REFERENTE AOS BANCO DE REGISTRADORES E A ULA
	
	Sinal_pro_Controle <= Instrucao[31 downto 26];
	
	Banco_Reg : entity.work.Banco_de_Registradores(arch)
			generic map (32)
			port map (Instr[25 downto 21], Instr[20 downto 16], M1, M3, A, B);
	
	MUX1 : entity work.Multiplexador_Generico(arch)
		generic map (4)
		port map (Instr[20 downto 16], Instr[15 downto 11],RegDst,M1);	

	-- inverti a ordem(veer se é assim que é pra fazer a extensão de sinal)					
	ES <= Instr[15 downto 0] & "0000000000000000";
	
	-- Lembra de mudar o nome da ULA para underline "-" -> "_"
	
	Ctrl_ULA : entity work.Ctrl_ULA(arch)
		port map(ULAOp, Instr[5 downto 0],cULA);
	
	MUX2 : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(B,ES,ULAFonte,M2);
			
	ULA : entity work.ULA(arch)
			port map (A, M2, cULA, Zero, Endereco_Dados);	
	
	Endereco_Memoria_Dados <= Endereco_Dados;
	
	MUX3: entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map(Endereco_Dados, Dado, MemParaReg,M3);
			
END ARCHITECTURE arch;