`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:58 06/23/2017 
// Design Name: 
// Module Name:    Top 
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
module Top(
	input  clk,
	//input  reset,
	//outpu wire [2:0]ctr,
	output pwm_left_out,
	output pwm_right_out,
	output [3:0] ctr_dir_out,
	output [2:0] led,
	input  [1:0]hwsignal,
	output [1:0]leds_hw,
	output wire [2:0] led_pwm_ctr,
	output Trig,
	input Echo,
	output En_tag,
	output csb_En_negedge,
	input Rx,
	output Tx,
	output data,
	output seg_slect
    );
	wire 	pwm_left_out;				//PWM左轮输出
	wire   pwm_right_out;          //PWM右轮输出
	wire [3:0] ctr_dir_out;     //输出轮子前后转
	wire [2:0] led;
	wire  [1:0]hwsignal;
	wire [1:0]leds_hw;
	wire [2:0]hw_ctr;
	wire [2:0]ctr;
	wire [2:0]bl_ctr;
	wire csb_En,Trig,Echo,csb_En_negedge;                   //chashengbo
	wire bl_En;
	wire [2:0]csb_ctr;
	//bluetooth
	wire [7:0]seg_slect;
   wire Rx,Tx;
	wire [7:0]data;
	wire [2:0]middctr;
	wire En_tag;
	PWM pwm(.clk(clk),
				.ctr(ctr),
				.pwm_left_out(pwm_left_out),
				.pwm_right_out(pwm_right_out),
				.ctr_dir_out(ctr_dir_out));
	HongWai hw(.clk(clk),
					.ctr(hw_ctr),
					.hwsignal(hwsignal),
					.leds_hw(leds_hw));
	ChaoShengBo csb(.clk(clk),
					.ctr(csb_ctr),
					.En(csb_En),
					.En_negedge(csb_En_negedge),
					.Trig(Trig),
					.Echo(Echo),
					.hwsignal(hwsignal),
					.En_tag(En_tag)
					);
	Bluetooth bt(.clk(clk),
					.Rx(Rx),
					.Tx(Tx),
					.seg_data(data),
					.seg_slect(seg_slect),
					.bl_ctr(bl_ctr),
					.bl_En(bl_En));

		assign middctr=(csb_En|csb_En_negedge)?csb_ctr:hw_ctr;
		assign ctr=bl_En?bl_ctr:middctr;
		assign led_pwm_ctr=csb_ctr;
		assign led=ctr;

endmodule
