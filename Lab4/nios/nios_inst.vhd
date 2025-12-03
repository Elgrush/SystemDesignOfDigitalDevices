	component nios is
		port (
			clk_clk         : in  std_logic                     := 'X';             -- clk
			led_out_export  : out std_logic_vector(9 downto 0);                     -- export
			reset_reset_n   : in  std_logic                     := 'X';             -- reset_n
			sw_in_export    : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- export
			to_hex_readdata : out std_logic_vector(31 downto 0)                     -- readdata
		);
	end component nios;

	u0 : component nios
		port map (
			clk_clk         => CONNECTED_TO_clk_clk,         --     clk.clk
			led_out_export  => CONNECTED_TO_led_out_export,  -- led_out.export
			reset_reset_n   => CONNECTED_TO_reset_reset_n,   --   reset.reset_n
			sw_in_export    => CONNECTED_TO_sw_in_export,    --   sw_in.export
			to_hex_readdata => CONNECTED_TO_to_hex_readdata  --  to_hex.readdata
		);

