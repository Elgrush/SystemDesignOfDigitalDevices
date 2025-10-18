	component laincore is
		port (
			clk_clk                        : in    std_logic                     := 'X';             -- clk
			key_external_connection_export : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			pll_locked_export              : out   std_logic;                                        -- export
			pll_sdam_clk                   : out   std_logic;                                        -- clk
			ps2_0_external_interface_CLK   : inout std_logic                     := 'X';             -- CLK
			ps2_0_external_interface_DAT   : inout std_logic                     := 'X';             -- DAT
			reset_reset_n                  : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr                : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                  : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n               : out   std_logic;                                        -- cas_n
			sdram_wire_cke                 : out   std_logic;                                        -- cke
			sdram_wire_cs_n                : out   std_logic;                                        -- cs_n
			sdram_wire_dq                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                 : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n               : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                : out   std_logic;                                        -- we_n
			seg7_conduit_end_export        : out   std_logic_vector(47 downto 0);                    -- export
			sw_external_connection_export  : in    std_logic_vector(9 downto 0)  := (others => 'X')  -- export
		);
	end component laincore;

	u0 : component laincore
		port map (
			clk_clk                        => CONNECTED_TO_clk_clk,                        --                      clk.clk
			key_external_connection_export => CONNECTED_TO_key_external_connection_export, --  key_external_connection.export
			pll_locked_export              => CONNECTED_TO_pll_locked_export,              --               pll_locked.export
			pll_sdam_clk                   => CONNECTED_TO_pll_sdam_clk,                   --                 pll_sdam.clk
			ps2_0_external_interface_CLK   => CONNECTED_TO_ps2_0_external_interface_CLK,   -- ps2_0_external_interface.CLK
			ps2_0_external_interface_DAT   => CONNECTED_TO_ps2_0_external_interface_DAT,   --                         .DAT
			reset_reset_n                  => CONNECTED_TO_reset_reset_n,                  --                    reset.reset_n
			sdram_wire_addr                => CONNECTED_TO_sdram_wire_addr,                --               sdram_wire.addr
			sdram_wire_ba                  => CONNECTED_TO_sdram_wire_ba,                  --                         .ba
			sdram_wire_cas_n               => CONNECTED_TO_sdram_wire_cas_n,               --                         .cas_n
			sdram_wire_cke                 => CONNECTED_TO_sdram_wire_cke,                 --                         .cke
			sdram_wire_cs_n                => CONNECTED_TO_sdram_wire_cs_n,                --                         .cs_n
			sdram_wire_dq                  => CONNECTED_TO_sdram_wire_dq,                  --                         .dq
			sdram_wire_dqm                 => CONNECTED_TO_sdram_wire_dqm,                 --                         .dqm
			sdram_wire_ras_n               => CONNECTED_TO_sdram_wire_ras_n,               --                         .ras_n
			sdram_wire_we_n                => CONNECTED_TO_sdram_wire_we_n,                --                         .we_n
			seg7_conduit_end_export        => CONNECTED_TO_seg7_conduit_end_export,        --         seg7_conduit_end.export
			sw_external_connection_export  => CONNECTED_TO_sw_external_connection_export   --   sw_external_connection.export
		);

