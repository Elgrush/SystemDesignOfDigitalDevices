module tb ();
    
    logic clk = 1'b0;
    logic [3:0] key;
    logic [9:0] sw;

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
        #10_000 $finish;
    end

endmodule
