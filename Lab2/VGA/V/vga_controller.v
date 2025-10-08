module vga_controller(iRST_n,
                      iVGA_CLK,
							 switch,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data);
input iRST_n;
input iVGA_CLK;
input switch;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
wire [18:0] ADDR_mod;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index_1;
wire [23:0] bgr_data_raw_1;
wire [7:0] index_2;
wire [23:0] bgr_data_raw_2;
wire cBLANK_n,cHS,cVS,rst;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));
////
////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end

//assign ADDR_mod = ~switch ? 420000 - ADDR : ADDR;
assign ADDR_mod = ADDR;
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	#(.PATH("../VGA_DATA/img_data_logo.mif")) img_data_inst_1 (
	.address ( ADDR_mod ),
	.clock ( VGA_CLK_n ),
	.q ( index_1 )
	);
//////Color table output
img_index #(.PATH("../VGA_DATA/index_logo.mif"))	img_index_inst_1 (
	.address ( index_1 ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw_1)
	);	
	

//////Color table output
img_index #(.PATH("../VGA_DATA/mifData.mif"))	img_index_inst_2 (
	.address ( ADDR_mod ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw_2)
	);	
//////
//////latch valid data at falling edge;
always@(posedge VGA_CLK_n)
begin
		bgr_data <= ~switch ? bgr_data_raw_1 : bgr_data_raw_2;
end
assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0];
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	
















