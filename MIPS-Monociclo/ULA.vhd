LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ULA IS
    PORT (
        A,B: in STD_LOGIC_VECTOR(31 DOWNTO 0); -- Entradas
		  Controle: in STD_LOGIC_VECTOR(2 DOWNTO 0); -- Sequencia de bits para 
		  Zero: out STD_LOGIC; -- Nao entendi como que funciona
		  Resultado: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY ULA;

ARCHITECTURE arch OF ULA IS
	-- Signals
	SIGNAL Resultado_Soma_Subtracao, Resultado_AND_OR: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL CarryOut_Soma: STD_LOGIC;
BEGIN
	-- Precisa Fazer Dois componentes:
	-- 1 - Somador_Subtrator_Generico
	-- 2 - OR_AND_Generico
	-- O sinal de controle vai controlar um multiplexador que vai escolher um desses dois componentes para realizar a operacao correta
	-- Outro bit do sinal de controle, vai controlar qual vai ser a operacao de cada componente
	
	-- Declaracao dos componentes
	
	
	
	-- É bom perguntar para o professor se a versao simplificada pode afetar na ideia do projeto ou nao
	
	-- Ideia simplificada onde nao exatamente a estrutura sera aplicada
	Somador_Generico: entity work.Somador_Generico(arch)
    port map (A,B,Resultado_Soma, CarryOut_Soma);
	Subtrator_Generico: entity work.Subtrator_Generico(arch)
	 port map (A,B,Resultado_Subtracao);
	 
	with Controle select	
		Resultado <= A and B when "000";
		Resultado <= A or B when "001";
		Resultado <= Resultado_Soma when "010";
		Resultado <= Resultado_Subtracao when "110";
		Resultado <= Resultado_Menor when "111";
		
END ARCHITECTURE arch;