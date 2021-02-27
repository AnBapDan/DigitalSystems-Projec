-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"
-- CREATED		"Tue Apr 09 13:06:24 2019"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY TimerProject IS 
	PORT
	(
		CLOCK_50 :  IN  STD_LOGIC;
		KEY :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		HEX0 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX1 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX3 :  OUT  STD_LOGIC_VECTOR(6 DOWNTO 0);
		LEDR :  OUT  STD_LOGIC_VECTOR(0 TO 0)
	);
END TimerProject;

ARCHITECTURE bdf_type OF TimerProject IS 

COMPONENT debounceunit
GENERIC (inPolarity : STD_LOGIC;
			kHzClkFreq : INTEGER;
			mSecMinInWidth : INTEGER;
			outPolarity : STD_LOGIC
			);
	PORT(refClk : IN STD_LOGIC;
		 dirtyIn : IN STD_LOGIC;
		 pulsedOut : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT timer
	PORT(clk : IN STD_LOGIC;
		 clk_en : IN STD_LOGIC;
		 start : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 ledFinal : OUT STD_LOGIC;
		 c0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 c1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 s0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 s1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT bin7segdecoder
	PORT(enable : IN STD_LOGIC;
		 binInput : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 decOut_n : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END COMPONENT;

COMPONENT freqdividerclock_50
GENERIC (k : INTEGER
			);
	PORT(clkIn : IN STD_LOGIC;
		 clkOut : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_11 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_8 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_10 :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 
SYNTHESIZED_WIRE_11 <= '1';



b2v_inst10 : debounceunit
GENERIC MAP(inPolarity => '0',
			kHzClkFreq => 50000,
			mSecMinInWidth => 100,
			outPolarity => '1'
			)
PORT MAP(refClk => CLOCK_50,
		 dirtyIn => KEY(0),
		 pulsedOut => SYNTHESIZED_WIRE_2);


b2v_inst11 : timer
PORT MAP(clk => CLOCK_50,
		 clk_en => SYNTHESIZED_WIRE_0,
		 start => SYNTHESIZED_WIRE_1,
		 reset => SYNTHESIZED_WIRE_2,
		 ledFinal => LEDR(0),
		 c0 => SYNTHESIZED_WIRE_4,
		 c1 => SYNTHESIZED_WIRE_6,
		 s0 => SYNTHESIZED_WIRE_8,
		 s1 => SYNTHESIZED_WIRE_10);


b2v_inst2 : bin7segdecoder
PORT MAP(enable => SYNTHESIZED_WIRE_11,
		 binInput => SYNTHESIZED_WIRE_4,
		 decOut_n => HEX0);


b2v_inst3 : bin7segdecoder
PORT MAP(enable => SYNTHESIZED_WIRE_11,
		 binInput => SYNTHESIZED_WIRE_6,
		 decOut_n => HEX1);


b2v_inst4 : bin7segdecoder
PORT MAP(enable => SYNTHESIZED_WIRE_11,
		 binInput => SYNTHESIZED_WIRE_8,
		 decOut_n => HEX2);


b2v_inst5 : bin7segdecoder
PORT MAP(enable => SYNTHESIZED_WIRE_11,
		 binInput => SYNTHESIZED_WIRE_10,
		 decOut_n => HEX3);



b2v_inst8 : freqdividerclock_50
GENERIC MAP(k => 500000
			)
PORT MAP(clkIn => CLOCK_50,
		 clkOut => SYNTHESIZED_WIRE_0);


b2v_inst9 : debounceunit
GENERIC MAP(inPolarity => '0',
			kHzClkFreq => 50000,
			mSecMinInWidth => 100,
			outPolarity => '1'
			)
PORT MAP(refClk => CLOCK_50,
		 dirtyIn => KEY(1),
		 pulsedOut => SYNTHESIZED_WIRE_1);


END bdf_type;