module debounce(
	input				button_in,
	input				clk_in,
	output logic   button_out
	);
	
	always_latch begin : blockName
		if (clk_in) begin
			button_out <= button_in;
		end
	end
	
endmodule
