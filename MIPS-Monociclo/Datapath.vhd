LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Datapath IS
    PORT (
	 -- Sinais de Controle, Entrada e Saída
			clk: in STD_LOGIC;
			RegDst,DvC,LerMem,MemParaReg,ULAOp,EscMem,ULAFonte,EscReg: in STD_LOGIC ; -- Sinais de controle
			Instrucao: in STD_LOGIC_VECTOR(25 downto 0); -- Saida da memoria de instrucao
			Sinal_pro_Controle,Endereco_Memoria_Instrucao,Endereco_Memoria_Dados: out STD_LOGIC_VECTOR(31 downto 0); -- Entrada da memoria de instrucao e de dados
			Dado,Dado_Escrita: in STD_LOGIC_VECTOR(31 downto 0); -- Dados para manipulacao
    );
END ENTITY;

ARCHITECTURE arch OF Datapath IS
SIGNAL Mux_PC,Saida_PC,Resultado_Somador_Incremento:STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL REG_A_SER_LIDO1,REG_A_SER_LIDO2,MUX_PRO_BR,REG_A_SER_ESCRITO,DADO_DE_ESCRITA(   )     ;

BEGIN
   -- Componentes 
	
	PC : entity work.Registrador_Generico(arch)
			generic map (32)
			port map (clk, '1', Mux_PC, Saida_PC);
			
	Endereco_Memoria_Instrucao <= Saida_PC;		
	Instrucao26 <= Instrucao[25 downto 0];
   Instrucao28 <= Instrucao26 & "00";
	
	-- Sinal para o controle e para o Banco_de_Registradores
	Sinal_pro_Controle <= Instrucao[31 downto 26];
	REG_A_SER_LIDO1 <= Instrucao[25 downto 21]; 
	REG_A_SER_LIDO2 <= Instrucao[20 downto 16];
	MUX_PRO_BR <= Instrucao[15 downto 11];
		
	Mux_para_Banco_Registrador : entity work.Multiplexador_Generico(arch)
		generic map (4)
		port map (REG_A_SER_LIDO2,MUX_PRO_BR,RegDst,REG_A_SER_ESCRITO);	

		
	
	Somador_incremento_PC : entity work.Somador_Generico(arch)
			generic map (32)
			port map (Saida_PC,"00000000000000000000000000000100", Resultado_Somador_Incremento, carryout_inutil);
			
	Instrucao28 & Resultado_Somador_Incremento; 
	
						

		
	Mux_para_ULA : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map (clk, '1', Mux_PC, Saida_PC);	
	--  Ligacao
		
	Mux_dps_memoria_de_dado : entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map (A,B,SEL,Y);
	
	Banco_de_Registradores : entity.work.Banco_de_Registradores(arch)
			generic map (32)
			port map (CLK,EN,D,Q);
	
	Mux_Fonte_PC: entity work.Multiplexador_Generico(arch)
			generic map (32)
			port map (A,B,SEL,Y);
	
	Mux_DVI: entity work.Multiplexador_Generico(arch)
			port map();
	
	Segundo_Somador : entity work.Somador_Generico(arch)
			generic map (32)
			port map (Saida_PC,"00000000000000000000000000000100", Resultado_Somador_Incremento, carryout_inutil);
	
	Ctrl-ULA : entity work.Ctrl-ULA(arch)
			port map(ULAOP,funct,cULA);
	
	ULA : entity work.Ctrl-ULA(arch)
			port map();
			
END ARCHITECTURE arch;

-- PARAMOS NO MUX PARA O BANCO DE REGISTRADORES