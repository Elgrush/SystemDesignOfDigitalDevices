module noise_gen (clk, enable, Q);
    input clk, enable;
    output [23:0] Q;

    logic [2:0] counter;

    always_ff@(posedge clk)
        if (enable)
            counter = counter + 1'b1;
    
    assign Q = {{10{counter[2]}}, counter, 11'd0};

endmodule