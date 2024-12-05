ghdl -a --std=08 Controle.vhd 
ghdl -a --std=08 Ctrl_ULA.vhd 
ghdl -a --std=08 Multiplexador_Generico.vhd 
ghdl -a --std=08 Registrador_Generico.vhd 
ghdl -a --std=08 Banco_de_Registradores.vhd 
ghdl -a --std=08 Somador_Generico.vhd 
ghdl -a --std=08 Subtrator_Generico.vhd 
ghdl -a --std=08 Mem_Dados.vhd 
ghdl -a --std=08 Mem_Instr.vhd 
ghdl -a --std=08 ULA.vhd 
ghdl -a --std=08 Datapath.vhd 
ghdl -a --std=08 MIPS_Monociclo.vhd 

ghdl -a --std=08 TestBench.vhd 
ghdl -e --std=08 TestBench
ghdl -r --std=08 TestBench --vcd=wave.vcd