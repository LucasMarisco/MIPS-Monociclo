library IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.std_logic_unsigned.ALL;

entity Somador_Generico is
    generic (
        N : integer := 8  -- Define o número de bits como um parâmetro genérico
    );
    Port (
        A : in  std_logic_vector(N-1 downto 0);  -- Primeiro operando de N bits
        B : in  std_logic_vector(N-1 downto 0);  -- Segundo operando de N bits
        Resultado : out std_logic_vector(N-1 downto 0);  -- Resultado da operação de N bits
        CarryOut : out std_logic -- Overflow
    );
end Somador_Generico;

architecture arch of Somador_Generico is
	 SIGNAL Soma: std_logic_vector(N DOWNTO 0);
		BEGIN
			Soma <= ('0'& A) + ('0' & B); -- Realizacao da soma
			CarryOut <= Soma(N); -- Bit mais significativo da soma sai pelo carryOut 
			Resultado <= Soma(N-1 downto 0); -- Resultado com N bits
end arch;