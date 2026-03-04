module HexSelector #(
    parameter DEVIDER=2
)(
    input clk, rst_n,
    input [31:0] hex_in,
    output logic [3:0] gpio_sel.
    output [7:0] hex_out
);

    logic mclk;

    FrequencyDevider #(.DEVIDER(DEVIDER)) frequency_devider (.clk_in(clk), .rst_n(rst_n), .clk_out(mclk)); 

    logic [3:0] mcnt;

	//Selector
    always_ff @(posedge mclk or negedge rst_n) begin
        if(!KEY[0]) begin
            mcnt <= '0;
        end else begin
            mcnt <= mcnt + 1'b1;
        end
    end
    
    always_comb begin
        case(mcnt)
            3: begin 
                    gpio_sel = 4'b1110;
                    hex_out  = hex_in[7:0];
                end
            2: begin 
                    gpio_sel = 4'b1101; 
                    hex_out  = hex_in[15:8];
                end
            1: begin 
                    gpio_sel = 4'b1011; 
                    hex_out  = hex_in[23:16];
                end
            0: begin 
                    gpio_sel = 4'b0111; 
                    hex_out  = hex_in[31:24];
                end
            default: begin gpio_sel = '0; hex_out <= '0; end
        endcase
    end
endmodule //HexSelector
