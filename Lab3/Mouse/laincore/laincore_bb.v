
module laincore (
	clk_clk,
	key_external_connection_export,
	pll_locked_export,
	pll_sdam_clk,
	ps2_0_external_interface_CLK,
	ps2_0_external_interface_DAT,
	reset_reset_n,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	seg7_conduit_end_export,
	sw_external_connection_export,
	pio_0_external_connection_export);	

	input		clk_clk;
	input	[3:0]	key_external_connection_export;
	output		pll_locked_export;
	output		pll_sdam_clk;
	inout		ps2_0_external_interface_CLK;
	inout		ps2_0_external_interface_DAT;
	input		reset_reset_n;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	output	[47:0]	seg7_conduit_end_export;
	input	[9:0]	sw_external_connection_export;
	output	[9:0]	pio_0_external_connection_export;
endmodule
