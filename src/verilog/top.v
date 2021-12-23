`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/11/19 17:00:22
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
  //difference clock, 300MHz(default) 
  input           clk300p  ,  //200MHz
  input           clk300n  ,
  //=============  
  output [7:0] led        ,
  //=============
  input            reset     // Active low
    );
localparam CLK_FREQ      = 'd300_000_000;  // The global clock frequency

//parameter BAUDRATE      = 'd115_200    ;
//parameter I2C_SPEED     = 'd100_000    ;
//parameter DEV_ID        = 7'b1010_100  ;
//parameter PCA_ID        = 7'b1110_100  ;

//parameter T = CLK_FREQ/I2C_SPEED;
localparam LED_NUM       = 'd8          ;  // The number of LEDs on board  
//===========sys clock==========
(* mark_debug = "TRUE" *)  wire [LED_NUM-1:0] LED_o                ;
assign led = LED_o              ;                  
wire sys_clk              ; 
wire sys_clk_bufg         ;

(* mark_debug = "TRUE" *) wire rst_gc_n                      ;
assign rst_gc_n  =  reset    ;
//========================  
IBUFDS IBUFDS_inst_sys_clock(
   .O  (sys_clk   ), // Buffer output
   .I  (clk300p  ), // Diff_p buffer input (connect directly to top-level port)
   .IB (clk300n  ) // Diff_n buffer input (connect directly to top-level port)
);
  
BUFG BUFG_inst_sys_clock (
   .O(sys_clk_bufg), // 1-bit output: Clock output
   .I(sys_clk     )
); 

//==============LED water==============
  Led_Water #(.CLK_FREQ(CLK_FREQ),.LED_NUM(LED_NUM))
  inst_Led_Water (
    .CLK_i   (sys_clk_bufg), //
	.RSTn_i (rst_gc_n       ), //Active low
	.LED_o  (LED_o          )
	);
endmodule
