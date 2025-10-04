module part1 (CLOCK_50, CLOCK2_50, KEY, FPGA_I2C_SCLK, FPGA_I2C_SDAT, AUD_XCK, 
		        AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT, SW, LEDR);

	input CLOCK_50, CLOCK2_50;
	input [3:0] KEY;
	output FPGA_I2C_SCLK;
	inout FPGA_I2C_SDAT;
	output AUD_XCK;
	input AUD_DACLRCK, AUD_ADCLRCK, AUD_BCLK;
	input AUD_ADCDAT;
	input [9:0] SW;
	output AUD_DACDAT;
	output [9:0] LEDR;
	
	// Основные сигналы аудио
	logic read_ready, write_ready, read, write;
	logic [23:0] readdata_left, readdata_right;
	logic [23:0] writedata_left, writedata_right;
	
	// Сигналы управления
	wire reset = ~KEY[0];
	wire switch_channel = SW[0];
	wire noise_enable = SW[1];
	wire record_button = SW[2];
	wire stop_record_button = SW[3];
	wire play_button = SW[4];
	wire stop_play_button = SW[5];
	wire noise_enable_sw = SW[9];
	assign LEDR[0] = switch_channel;
	assign LEDR[1] = noise_enable;
	assign LEDR[2] = playing;
	assign LEDR[3] = recording;
	assign LEDR[6] = record_button;
	assign LEDR[7] = stop_record_button;
	assign LEDR[8] = play_button;
	assign LEDR[9] = stop_play_button;
	// Сигналы диктофона
	logic [23:0] noise;
	logic [23:0] recorded_left, recorded_right;
	logic recording, playing;
	
	noise_gen ng(AUD_BCLK,noise_enable_sw, noise);
	
	reg [23:0] left_out;
	reg [23:0] right_out;
	
	
	always_comb begin
		if (playing) begin
			// Режим воспроизведения записи
			left_out = recorded_left;
			right_out = recorded_right;
		end else if (recording) begin
			// Режим записи - выводим входной сигнал
			left_out = readdata_left;
			right_out = readdata_right;
		end else begin
			// Обычный режим с эффектами
			
			if (switch_channel) begin
				left_out = noise_enable ? (readdata_left | noise) : readdata_left;
				right_out = noise_enable ? (readdata_right | noise) : readdata_right;
			end else begin
				right_out = noise_enable ? (readdata_left | noise) : readdata_left;
				left_out = noise_enable ? (readdata_right | noise) : readdata_right;
			end
		end
	end
	
	
	
	
	assign writedata_left =  left_out;
	assign writedata_right = right_out;
	assign read = read_ready;
	assign write = write_ready;
	
	logic dict_clk;
	
	FrequencySplitter #(.N(1)) fs(.clk_in(FPGA_I2C_SCLK), .clk_out(dict_clk), .rst_n(!reset));

	dictaphone #(.MEMORY_SIZE(80000)
	) dictaphone_unit(
		.clk(AUD_BCLK),
		.reset(reset),
		.record_btn(record_button),
		.stop_record_btn(stop_record_button),
		.play_btn(play_button),
		.stop_play_btn(stop_play_button),
		.audio_in_left(readdata_left),
		.audio_in_right(readdata_right),
		.read_ready(read_ready),
		.write_ready(write_ready),
		.audio_out_left(recorded_left),
		.audio_out_right(recorded_right),
		.recording(recording),
		.playing(playing),
		.audio_out_of_memory(LEDR[4]),
	);
	
	clock_generator my_clock_gen(
		// inputs
		CLOCK_50,
		reset,

		// outputs
		AUD_XCK
	);

	audio_and_video_config cfg(
		// Inputs
		CLOCK_50,
		reset,

		// Bidirectionals
		FPGA_I2C_SDAT,
		FPGA_I2C_SCLK
	);

	audio_codec codec(
		// Inputs
		CLOCK_50,
		reset,

		read,	write,
		writedata_left, writedata_right,

		AUD_ADCDAT,

		// Bidirectionals
		AUD_BCLK,
		AUD_ADCLRCK,
		AUD_DACLRCK,

		// Outputs
		read_ready, write_ready,
		readdata_left, readdata_right,
		AUD_DACDAT
	);

endmodule


