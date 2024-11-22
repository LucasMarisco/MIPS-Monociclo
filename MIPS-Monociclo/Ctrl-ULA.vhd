LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Ctrl-ULA IS
    PORT (
        ULAOp: in STD_LOGIC_VECTOR(1 DOWNTO 0); -- Sequencia de bits para 
        funct: in STD_LOGIC_VECTOR(5 DOWNTO 0); -- Entradas
		cULA: out STD_LOGIC_VECTOR(2 DOWNTO 0); -- Nao entendi como que funciona
    );
END ENTITY;

ARCHITECTURE arch OF Ctrl-ULA IS

cULA <= "010" when ULAOp = "00" else 
        "110" when ULAOp = "01" else
        "010" when funct = "100000" else -- add
        "110" when funct = "100010" else -- sub
        "000" when funct = "100100" else -- and
        "001" when funct = "100101" else -- or
        "111" when funct = "101010" else -- slt (set on less then)
        "010"; -- coloquei para ele ser uma somador se o OP code for "11" ou se o funct for algo não definido    



--valores tirando da tabela dos Slide 8T.56
--tá um pouco diferente dos que temos de referência, talvez mude alguma coisa no bloco de comando por que
--temos que deixar a ULAOp em 10, no deles parece que não precisa, mas tem que ver como eles fizeram
--podemos fazer usando:      if-then-else               case                when-else
--                          mau otimizado           1 variavel só           perigoso(pq depende da ordem)
--                        mais claro e garantido                            otimizado

-- no nosso caso, se ele passar do 2 primeiros quer dizer que ULAOp é ou "10" ou "11", sendo assim
-- podemos começar a analizar o funct, por isso fomos de when else

BEGIN
		
END ARCHITECTURE arch;