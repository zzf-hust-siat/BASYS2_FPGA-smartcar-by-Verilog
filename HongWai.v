`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:48:19 06/23/2017 
// Design Name: 
// Module Name:    HongWai 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module HongWai(
	 input clk,
    output reg [2:0]ctr,
	
	 input wire [1:0]hwsignal,
	 output reg [1:0]leds_hw
    );
	 always@(posedge clk)                 //black 1   white 0
    begin
	
	 leds_hw<=hwsignal;
	 end
	 always@(posedge clk)
		casex(hwsignal)
		2'b00:
			begin
			ctr<=3'b000;
			end
		2'b10:
			begin
			ctr<=3'b101;      //turn left
			end
		2'b01:
			begin
			ctr<=3'b110;
			end
		2'b11:
			begin
			ctr<=3'b000;
			end
		endcase
endmodule
