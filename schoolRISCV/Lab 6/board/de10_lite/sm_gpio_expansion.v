/*
 * schoolRISCV - small RISC-V CPU
 *
 * Simple GPIO expansion helpers:
 *  - 4-digit multiplexed 7-segment driver
 *  - small wrappers intended for external modules on GPIO headers
 */

module sm_hex_display_4mux
#(
    parameter integer REFRESH_COUNTER_BITS = 16
)
(
    input             clock,
    input             resetn,
    input      [15:0] number,

    output reg [ 6:0] seven_segments,
    output reg        dot,
    output reg [ 3:0] anodes
);

    function [6:0] bcd_to_seg (input [3:0] bcd);
        case (bcd)
            4'h0: bcd_to_seg = 7'b1000000;  // g f e d c b a (active low)
            4'h1: bcd_to_seg = 7'b1111001;
            4'h2: bcd_to_seg = 7'b0100100;
            4'h3: bcd_to_seg = 7'b0110000;
            4'h4: bcd_to_seg = 7'b0011001;
            4'h5: bcd_to_seg = 7'b0010010;
            4'h6: bcd_to_seg = 7'b0000010;
            4'h7: bcd_to_seg = 7'b1111000;
            4'h8: bcd_to_seg = 7'b0000000;
            4'h9: bcd_to_seg = 7'b0011000;
            4'hA: bcd_to_seg = 7'b0001000;
            4'hB: bcd_to_seg = 7'b0000011;
            4'hC: bcd_to_seg = 7'b1000110;
            4'hD: bcd_to_seg = 7'b0100001;
            4'hE: bcd_to_seg = 7'b0000110;
            4'hF: bcd_to_seg = 7'b0001110;
        endcase
    endfunction

    // Board wiring default:
    //   - segments on GPIO[6:0] are ordered as [a b c d e f g] and are active-high
    //   - digit selects are active-low (anodes/cathodes depend on the module)
    function [6:0] seg_gpio_map (input [6:0] seg_g_to_a_active_low);
        begin
            // seg_g_to_a_active_low is [6:0] = g f e d c b a (active-low)
            // Convert to [6:0] = a b c d e f g (active-high)
            seg_gpio_map = ~{ seg_g_to_a_active_low[0],
                              seg_g_to_a_active_low[1],
                              seg_g_to_a_active_low[2],
                              seg_g_to_a_active_low[3],
                              seg_g_to_a_active_low[4],
                              seg_g_to_a_active_low[5],
                              seg_g_to_a_active_low[6] };
        end
    endfunction

    reg [REFRESH_COUNTER_BITS-1:0] refresh;
    wire [1:0] digit_sel = refresh[REFRESH_COUNTER_BITS-1 -: 2];

    always @(posedge clock or negedge resetn) begin
        if (!resetn)
            refresh <= 0;
        else
            refresh <= refresh + 1'b1;
    end

    always @(*) begin
        dot = 1'b0; // keep dot off (active-high)
        anodes = 4'b1111;
        seven_segments = seg_gpio_map(bcd_to_seg(4'h0));

        case (digit_sel)
            2'd0: begin
                anodes = 4'b1110;
                seven_segments = seg_gpio_map(bcd_to_seg(number[ 3: 0]));
            end
            2'd1: begin
                anodes = 4'b1101;
                seven_segments = seg_gpio_map(bcd_to_seg(number[ 7: 4]));
            end
            2'd2: begin
                anodes = 4'b1011;
                seven_segments = seg_gpio_map(bcd_to_seg(number[11: 8]));
            end
            2'd3: begin
                anodes = 4'b0111;
                seven_segments = seg_gpio_map(bcd_to_seg(number[15:12]));
            end
        endcase
    end

endmodule
