module debounce(
	input				button_in,
	input				clk_in,
	output logic   button_out
	);
	
	always_latch begin : blockName
		button_out <= button_in;
	end
	
endmodule
