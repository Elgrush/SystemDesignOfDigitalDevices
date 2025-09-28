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
	wire read_ready, write_ready, read, write;
	wire [23:0] readdata_left, readdata_right;
	wire [23:0] writedata_left, writedata_right;
	
	// Сигналы управления
	wire reset = ~KEY[0];
	wire switch_channel = 0;
	wire noise_enable = ~KEY[1];
	wire record_button = ~KEY[2];
	wire play_button = ~KEY[3];
	wire noise_enable_sw = SW[9];
	//assign LEDR[0] = switch_channel;
	assign LEDR[1] = noise_enable;
	assign LEDR[2] = record_button;
	assign LEDR[4] = playing;
	assign LEDR[5] = recording;
	assign LEDR[6] = play_button;
	assign LEDR[7] = noise_enable_sw;
	// Сигналы диктофона
	wire [23:0] noise;
	wire [23:0] recorded_left, recorded_right;
	wire recording, playing;
	wire memory_full = LEDR[9];
	
	noise_gen ng(CLOCK_50,noise_enable_sw, noise);
	
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

	dictaphone dictaphone_unit(
		.clk(FPGA_I2C_SCLK),
		.reset(reset),
		.record_btn(record_button),
		.play_btn(play_button),
		.audio_in_left(readdata_left),
		.audio_in_right(readdata_right),
		.read_ready(read_ready),
		.write_ready(write_ready),
		.audio_out_left(recorded_left),
		.audio_out_right(recorded_right),
		.recording(recording),
		.playing(playing),
		.memory_full(memory_full),
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


