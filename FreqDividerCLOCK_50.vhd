library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FreqDividerCLOCK_50 is
	generic(k	: positive := 4);
	port(clkIn	: in  std_logic;
		  clkOut : out std_logic);
end FreqDividerCLOCK_50;

architecture Behavioral of FreqDividerCLOCK_50 is
	signal s_counter : natural := 0;
begin
	process(clkIn)
	begin
		if	(rising_edge(clkIn)) then
		s_counter <= s_counter + 1;
			if (s_counter = k - 1) then
				clkOut 	 <= '0';
				s_counter <= 0;
			else
				if (s_counter = k/2 - 1) then
					clkOut <= '1';
				end if;
				s_counter <= s_counter + 1; 
			end if;
		end if;
	end process;
end behavioral;