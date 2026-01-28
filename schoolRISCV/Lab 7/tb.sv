module tb ();
    
    logic clk       = '0;
    logic [3:0] key = '0;
    logic [9:0] sw  = '0;

    logic      [6:0]  HEX0;
    logic      [6:0]  HEX1;
    logic      [6:0]  HEX2;
    logic      [6:0]  HEX3;
    logic      [6:0]  HEX4;
    logic      [6:0]  HEX5;

    de1_soc dut (
        .CLOCK_50(clk),
        .SW(sw),
        .KEY(key),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .HEX4(HEX4),
        .HEX5(HEX5)
    );

    always #1 clk = !clk;

    initial begin
        sw[8:5]   = 4'h0;    // divide
    end

    initial begin
        #6 key[0] = 1'b1;  // reset
    end

    initial begin
        #1_000 $finish;
    end

endmodule
