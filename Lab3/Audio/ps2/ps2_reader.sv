module ps2_reader(
    input  logic clk,
    input  logic rst_n,
    inout  logic external_clk,
    inout  logic external_data,
    output logic data_valid,
    output 
);
    typedef enum logic [1:0] { STOP, IDLE, DATA, PARITY } STATE;

    STATE current_state, next_state;

    logic parity_state;
    logic [23:0] data;
    logic [$clog2($bits(data))-1:0] data_pointer;

    always_ff @(posedge clk or negedge rst_n) begin : STATE_MACHINE
        if(!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk or negedge rst_n) begin : PARITY_CHECK
        if(!rst_n) begin
            parity_state <= '0;
        end else begin
            case (current_state)
                DATA: begin
                    parity_state <= parity_state ^ external_data;
                end
                default: begin
                    parity_state <= '0;
                end
            endcase
        end
    end

    always_comb begin : NEXT_STATE_GENERATOR
        next_state = current_state;
        case (current_state)
            STOP: begin
                //
            end
            IDLE: begin
                if(!external_data) begin
                    next_state = DATA;
                end
            end
            
        endcase
    end

endmodule