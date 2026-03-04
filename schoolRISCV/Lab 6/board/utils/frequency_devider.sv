module FrequencyDevider #(
    parameter DEVIDER=2;
) (
    input clk_in, rst_n,
    output logic clk_out
);

    logic [$clog2(DEVIDER):0] cnt;

    // Frequency splitter
    always_ff @(posedge clk_in or negedge rst_n) begin
        if(!rst_n) begin
            cnt <= '0;
        end else begin
            cnt <= cnt + 1'b1;
            if(clk_out)  begin
                cnt <= '0;
            end
        end
    end

    always_comb begin
        clk_out = (cnt == DEVIDER);
    end
    
endmodule # FrequencyDevider
