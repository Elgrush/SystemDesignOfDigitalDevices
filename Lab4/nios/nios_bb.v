
module nios (
	clk_clk,
	led_out_export,
	reset_reset_n,
	sw_in_export,
	to_hex_readdata);	

	input		clk_clk;
	output	[9:0]	led_out_export;
	input		reset_reset_n;
	input	[9:0]	sw_in_export;
	output	[31:0]	to_hex_readdata;
endmodule
