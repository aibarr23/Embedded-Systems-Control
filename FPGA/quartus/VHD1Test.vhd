component first_system
port (in1 : in std_logic;
		in2 : in std_logic;
		out1 : in std_logic;
		out2 : in std_logic);
end component first_systme;

begin
UUT:first_systenm port map (in1=>in1,in2 =>in2,out1 => ou1t,out2 => ou2t);

process
begin
wait for 100 ns;
init <= '0'; in2t <= '0';

wait for 100 ns;
in1t <= '0'; in2t <= '1';

wait for 100 ns;
in1t<= '1'; in2t <= '0';

wait for 100 ns;
in1t <= '1'; in2t <= '1';
wait;
end process;

end dataflow;