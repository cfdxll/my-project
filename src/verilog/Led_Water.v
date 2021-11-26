`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/02/10 09:06:19
// Design Name: 
// Module Name: Led_Water
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


module Led_Water#(parameter CLK_FREQ  = 'd200_000_000,
             parameter LED_NUM   = 'd8)
  (
  input CLK_i,
  input RSTn_i,
  output reg [LED_NUM-1:0] LED_o
  );
  
//**************************
  reg [31:0] cnt;
  
  always @(posedge CLK_i)
    if(!RSTn_i)
	begin
	  LED_o <= 'd1;
	  cnt   <= 32'd0;
	end
	else
	begin
	  if(cnt == CLK_FREQ)
	  begin
	    cnt <= 32'd0;
		if(LED_o[LED_NUM-1] == 1'b1)
		  LED_o <= 'd1;
		else
		  LED_o <= LED_o<<1;
	  end
	  else
	  begin
	    cnt   <= cnt + 1'b1;
		LED_o <= LED_o;
	  end
	end
endmodule
