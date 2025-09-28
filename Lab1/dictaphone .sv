module dictaphone #(
	parameter MEMORY_SIZE = 4096  // Размер памяти (можно настроить)
)(
	input logic clk,
	input logic reset,
	input logic record_btn,
	input logic stop_record_btn,
	input logic play_btn,
	input logic stop_play_btn,
	input logic [23:0] audio_in_left,
	input logic [23:0] audio_in_right,
	input logic read_ready,
	input logic write_ready,
	output logic playing,
	output logic recording,
	output logic audio_out_left,
	output logic audio_out_right
);
	
	// Параметры памяти
	localparam MEMORY_WIDTH = $clog2(MEMORY_SIZE);

	// Память для записи
	logic [23:0] memory_left [MEMORY_SIZE];
	logic [23:0] memory_right [MEMORY_SIZE];
	
	// Указатели записи/воспроизведения
	logic [MEMORY_WIDTH-1:0] write_pointer;
	logic [MEMORY_WIDTH-1:0] read_pointer;
	logic [MEMORY_WIDTH-1:0] record_length;

	// Состояния конечного автомата
	enum {IDLE, RECORDING_STATE, PLAYING_STATE} state, next_state;
	assign recording = state == RECORDING_STATE;
	assign playing   = state == PLAYING_STATE;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	always_comb begin
		case (state)
			IDLE: begin
				next_state = IDLE;
				if (record_btn && !stop_record_btn) begin
					next_state = RECORDING_STATE;
				end else if (play_btn && !stop_play_btn) begin
					next_state = PLAYING_STATE;
				end
			end
			
			RECORDING_STATE: begin
				next_state = RECORDING_STATE;
				if (stop_record_btn || write_pointer >= (MEMORY_SIZE-1'b1)) begin
					next_state = IDLE;
				end
			end
			
			PLAYING_STATE: begin
				next_state = PLAYING_STATE;
				if (stop_play_btn) begin
					next_state = IDLE;
				end
			end
		endcase
	end
	
	// Конечный автомат управления
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			write_pointer   <= '0;
			read_pointer    <= '0;
			audio_out_left  <= '0;
			audio_out_right <= '0;
		end else begin
			audio_out_left  <= '0;
			audio_out_right <= '0;
			case (state)
				IDLE: begin
					case(next_state)
						RECORDING_STATE: begin
							write_pointer <= '0;
						end
						PLAYING_STATE: begin
							read_pointer <= '0;
						end
						default:;
					endcase
					end
				
				RECORDING_STATE: begin
					if (read_ready && write_pointer < MEMORY_SIZE) begin
						// Запись в память
						memory_left[write_pointer] <= audio_in_left;
						memory_right[write_pointer] <= audio_in_right;
						write_pointer <= write_pointer + 1'b1;
					end
				end
				
				PLAYING_STATE: begin
					if (write_ready && read_pointer < write_pointer) begin
						// Воспроизведение из памяти
						audio_out_left  <= memory_left[read_pointer];
						audio_out_right <= memory_right[read_pointer];
						read_pointer <= read_pointer + 1;
					end else if (read_pointer >= write_pointer) begin
						// Циклическое воспроизведение
						read_pointer <= '0;
					end
				end
			endcase
		end
	end
	
endmodule