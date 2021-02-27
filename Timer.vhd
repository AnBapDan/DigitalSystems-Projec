library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Timer is
	port(clk			: in 	std_logic;
		  clk_en		: in  std_logic;
		  start		: in 	std_logic;
		  reset		: in 	std_logic;
		  ledFinal	: out std_logic;		  
		  c0			: out std_logic_vector(3 downto 0):= "1001";
		  c1			: out std_logic_vector(3 downto 0):= "1001";
		  s0			: out std_logic_vector(3 downto 0):= "1001";
		  s1			: out std_logic_vector(3 downto 0):= "0101");
end Timer;

architecture Behavioral of Timer is

	signal s_c0, s_c1 : unsigned(6 downto 0) := "0001001";
	signal s_s0 		: unsigned(6 downto 0) := "0001001";
	signal s_s1 		: unsigned(6 downto 0) := "0000101";
	signal s_countC   : unsigned(6 downto 0) := "1100011";
	signal s_countS   : unsigned(6 downto 0) := "0111011";
	signal s_start 	: std_logic := '0';
	signal f_c0, f_c1, f_s0, f_s1 :unsigned(6 downto 0);
	signal s_freeze, s_ledFinal : std_logic := '0';
	
begin 
	process(clk_en, reset)
	begin
	
		if	(rising_edge(clk_en)) then
			if(start = '0' and s_start = '0' and s_freeze ='0')then							-- alteração do sinal start através da key 
				s_start <= '1';
			elsif(start = '0' and s_start = '1' and s_freeze= '0') then
				s_start <= '0';
			end if;
			
			if(reset = '0' and s_start = '0' and s_freeze = '0') then								-- Reset quando o start/stop está desligado
				s_countC <="1100011";
				s_countS <="0111011";
				s_ledFinal <= '0';
				s_start <= '0';
				s_c0 <= "0001001";
				s_c1 <= "0001001";
				s_s0 <= "0001001";
				s_s1 <= "0000101";
			elsif(reset = '0' and s_ledFinal = '1' and s_freeze = '1') then
				s_ledFinal <= '0';
				s_freeze <= '0';
				s_start <= '0';
				s_countC <="1100011";
				s_countS <="0111011";
				s_c0 <= "0001001";
				s_c1 <= "0001001";
				s_s0 <= "0001001";
				s_s1 <= "0000101";
				

				
			elsif(reset = '1' and s_start = '1') then
				s_c0 <= s_countC rem 10;											-- separação e atribuição dos valores ao display
				s_c1 <= s_countC / 10;
				s_s0 <= s_countS rem 10;
				s_s1 <= s_countS / 10;	
				if (s_countC = "0000000") then
					s_countS <= s_countS - "0000001";
					s_countC <= "1100011";
				else
					s_countC <= s_countC - "0000001";
				end if;	
				
				if	(s_countC = "0000000" and s_countS = "0000000") then	--mudança do sinal start e fixação do display em 00:00		
					s_ledFinal <= '1';
					s_start <= '0';
					s_countC <= "0000000";
					s_countS <= "0000000";
				end if;
			end if;
				
			if(reset = '0' and s_start = '1') then  			 --ativação do sinal freeze
				s_freeze <= not s_freeze;
				if(s_freeze = '1') then
					f_c0 <= s_c0;										 -- fixação dos valores aquando o sinal freeze
					f_c1 <= s_c1;
					f_s0 <= s_s0;
					f_s1 <= s_s1;
				elsif (s_freeze = '0') then
					s_c0 <= s_c0;							 			 -- "descongelamento" do display
					s_c1 <= s_c1;
					s_s0 <= s_s0;
					s_s1 <= s_s1;
				end if;				
			end if;			
		end if;
		
		if(s_freeze = '1') then										--paragem do display (freeze)
			s0 <= std_logic_vector(f_s0(3 downto 0));
			s1 <= std_logic_vector(f_s1(3 downto 0));
			c0	<= std_logic_vector(f_c0(3 downto 0));
			c1	<= std_logic_vector(f_c1(3 downto 0));			
		else
			s0 <= std_logic_vector(s_s0(3 downto 0));
			s1 <= std_logic_vector(s_s1(3 downto 0));
			c0	<= std_logic_vector(s_c0(3 downto 0));
			c1	<= std_logic_vector(s_c1(3 downto 0));
			f_c0 <= s_c0;
			f_c1 <= s_c1;
			f_s0 <= s_s0;
			f_s1 <= s_s1;
		end if;			
	end process;
	ledFinal <= std_logic(s_ledFinal);
end Behavioral;