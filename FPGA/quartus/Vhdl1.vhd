library ieee;
use ieee.std_logic_1164.all;

entity and_module is
port (ain1 : in std_logic;
		ain2 : in std_logic;
		and_out : out std_logic);
end and_module;

architecture dataflow_model of and_module is
begin
and_out <= (ain1 and ain2);
end dataflow_model;

library ieee;
use ieee.std_logic_1164.all;

entity or_module is
port (oin1 : in std_logic;
oin2 : in std_logic;
or_out : out std_logic);
end or_module;

architecture dataflow_model of or_module is
begin
or_out <= (oin1 or oin2);
end dataflow_model;

library ieee;
use ieee.std_logic_1164.all;

entity first_system is
port (in1 : in std_logic;
		in2 : in std_logic;
		out1 : in std_logic;
		out2 : in std_logic);
end first_system;

architecture dataflow_model of first_system is
signal and_out, or_out : std_logic;

component and_module
port (ain1 : in std_logic;
		ain2 : in std_logic;
		and_out : out std_logic);
end component;

component or_module
port (oin1 : in std_logic;
oin2 : in std_logic;
or_out : out std_logic);
end component;
		
begin
U1: and_module port map(ain1=>in1,ain2 =>in2,and_out =>and_out);
U2: or_module port map(oin1=>in1,oin2=>in2,or_out =>or_out);

out1 <= (in1 and in2) xor (in1 or in2);
out2 <= not in1;
end dataflow_model;