LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Ctrl-ULA IS
    PORT (
        A,B: in STD_LOGIC_VECTOR(31 DOWNTO 0); -- Entradas
		  Controle: in STD_LOGIC_VECTOR(2 DOWNTO 0); -- Sequencia de bits para 
		  Zero: out STD_LOGIC; -- Nao entendi como que funciona
		  Resultado: out STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch OF Ctrl-ULA IS
	-- Signals
	SIGNAL Resultado_Soma_Subtracao, Resultado_AND_OR: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL CarryOut_Soma: STD_LOGIC;
BEGIN
		
END ARCHITECTURE arch;