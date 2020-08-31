`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:46:21 06/23/2017 
// Design Name: 
// Module Name:    PWM 
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
 module PWM(
    input clk,
	 input  wire   [2:0] ctr,
	 output reg 	pwm_left_out,				//PWM左轮输出
	 output reg    pwm_right_out,          //PWM右轮输出
	 output reg [3:0] ctr_dir_out      //输出轮子前后转
    );
	 reg  [19:0]  countleft; 
	 reg  [19:0]  countright; 
	 reg [19:0]left;
	 reg [19:0]right;
	 initial
	 begin
	 countleft=20'b0;
	 countright=20'b0;
	 end
	 always@(posedge clk)
	 casex(ctr)
		3'b000:                  //zhengcahng
			begin
			left=20'h124f8;
			right=20'h124f8;
			ctr_dir_out=4'b0101;
			end
		3'b110:                     //turn right  hw
			begin
			left=20'h124f8;
			right=20'h3a98;
			ctr_dir_out=4'b0101;
			end
		3'b111:                     //turn right sharp
			begin
			left=20'h124f8;
			right=20'h88b8;
			ctr_dir_out=4'b0101; 
			end
		3'b101:                     //turn left  hw
			begin
			left=20'h3a98;
			right=20'h124f8;
			ctr_dir_out=4'b0101;
			end
		3'b100:                     //turn left  sharp
			begin
			left=20'h88b8;
			right=20'h124f8;
			ctr_dir_out=4'b0101;
			end
		3'b011:                     //    back
			begin
			left=20'h14c08;
			right=20'h14c08;
			ctr_dir_out=4'b1010;
			end
		3'b010:                     //    bt zhengcahng
			begin
			left=20'h14c08;
			right=20'h14c08;
			ctr_dir_out=4'b0101;
			end
		3'b001:                     //stop
			begin
			left=20'hc350;
			right=20'hc350;
			ctr_dir_out=4'b0000;
			end
		endcase
	always@(posedge clk)
		begin
			countleft=countleft+1;
			if(countleft<=left)
				begin
				pwm_left_out=1;
				end
			else begin
			pwm_left_out=0;
			end
			if(countleft>=20'h186a0)
			begin
			countleft=0;
			end
		end
		
	always@(posedge clk)
		begin
			countright=countright+1;
			if(countright<=right)
				begin
				pwm_right_out=1;
				end
			else begin
			pwm_right_out=0;
			end
			if(countright>=20'h186a0)
			begin
			countright=0;
			end
		end
endmodule
