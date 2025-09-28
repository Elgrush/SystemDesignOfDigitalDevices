module dictaphone(
	input clk,
	input reset,
	input record_btn,
	input play_btn,
	input [23:0] audio_in_left,
	input [23:0] audio_in_right,
	input read_ready,
	input write_ready,
	output reg [23:0] audio_out_left,
	output reg [23:0] audio_out_right,
	output reg recording,
	output reg playing,
	output memory_full
);
	
	// Параметры памяти
	parameter MEMORY_SIZE = 15000;  // Размер памяти (можно настроить)
	
	// Память для записи
	logic [23:0] memory_left [MEMORY_SIZE];
	logic [23:0] memory_right [MEMORY_SIZE];
	
	// Указатели записи/воспроизведения
	logic [15:0] write_pointer = 0;
	logic [15:0] read_pointer = 0;
	logic [15:0] record_length = 0;
	
	// Состояния конечного автомата
	enum {IDLE, RECORDING_STATE, PLAYING_STATE} state;
	
	// Обнаружение фронтов кнопок
	logic record_btn_prev, play_btn_prev;
	logic record_pulse, play_pulse;
	
	assign record_pulse = record_btn & ~record_btn_prev;
	assign play_pulse = play_btn & ~play_btn_prev;
	assign memory_full = (write_pointer >= MEMORY_SIZE);
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			record_btn_prev <= 0;
			play_btn_prev <= 0;
		end else begin
			record_btn_prev <= record_btn;
			play_btn_prev <= play_btn;
		end
	end
	
	// Конечный автомат управления
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			write_pointer <= '0;
			read_pointer <= '0;
			record_length <= '0;
			recording <= '0;
			playing <= '0;
			audio_out_left <= '0;
			audio_out_right <= '0;
		end else begin
			case (state)
				IDLE: begin
					if (record_pulse && !memory_full) begin
						state <= RECORDING_STATE;
						write_pointer <= '0;
						recording <= '1;
						playing <= '0;
					end else if (play_pulse && record_length > '0) begin
						state <= PLAYING_STATE;
						read_pointer <= '0;
						playing <= '1;
						recording <= '0;
					end
				end
				
				RECORDING_STATE: begin
					if (read_ready && write_pointer < MEMORY_SIZE) begin
						// Запись в память
						memory_left[write_pointer] <= audio_in_left;
						memory_right[write_pointer] <= audio_in_right;
						write_pointer = write_pointer + 1'b1;
						record_length <= write_pointer;
					end
					
					if (!record_btn || memory_full) begin
						state <= IDLE;
						recording <= 0;
					end
				end
				
				PLAYING_STATE: begin
					if (write_ready && read_pointer < record_length) begin
						// Воспроизведение из памяти
						audio_out_left <= memory_left[read_pointer];
						audio_out_right <= memory_right[read_pointer];
						read_pointer <= read_pointer + 1;
					end else if (read_pointer >= record_length) begin
						// Циклическое воспроизведение
						read_pointer <= 0;
					end
					
					if (!play_btn) begin
						state <= IDLE;
						playing <= 0;
					end
				end
			endcase
		end
	end
	
endmodule