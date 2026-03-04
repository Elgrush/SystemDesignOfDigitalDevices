module Debouncer #(
    parameter DEVIDER=2,
    parameter ARRAY_SIZE=8;
) (
    input clk, rst_n,
    input [$clog2(ARRAY_SIZE)] buttons_in,
    output logic [$clog2(ARRAY_SIZE)] buttons_out
);

    logic mclk;

    FrequencyDevider #(.DEVIDER(DEVIDER)) frequency_devider (.clk_in(clk), .rst_n(rst_n), .clk_out(mclk)); 

    always_ff @(posedge mclk or negedge rst_n) begin
        buttons_out <= buttons_in;
    end

endmodule // Debouncer