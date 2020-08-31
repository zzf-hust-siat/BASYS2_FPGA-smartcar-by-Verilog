`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:49:13 06/23/2017 
// Design Name: 
// Module Name:    ChaoShengBo 
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
module ChaoShengBo(
	 input clk,
	 output reg [2:0]ctr,
	 output En,
	 output En_negedge,
	 output reg Trig,
	 input wire Echo,
	 input wire [1:0]hwsignal,
	output En_tag
    );
	 reg [23:0]count;          //bulid chufa signal
	 reg [23:0]timecount;      //high level time
	 reg [23:0]keep_obstacle_time;
	 reg [23:0]keep_no_obstacle_time;    //count no obstacle time
	 reg En;                    //or not have obstacle
	 reg [31:0]turnleft_count;     //turn left time
	 reg [1:0]temp;
	 reg [1:0]Echo_temp;
	 reg En_negedge;
	 
	 reg En_tag;
	 reg tag;
	 reg [31:0]tag_count;     //turn left time
	 reg [31:0]count_total; 
	 reg count_tag;
	 
	 initial
		begin
		count=24'b0;
		timecount=24'b0;
		keep_obstacle_time=24'b0;
		En=0;
		keep_no_obstacle_time=24'b0;
		turnleft_count=32'b0;
		//count_turn_time=20'b0;
		temp=2'b0;
		Echo_temp=2'b0;
		En_negedge=0;
		
		En_tag=0;
		tag=0;
		tag_count=0;
		count_total=0;
		count_tag=0;
		
		end
	  //chan sheng chu fa xin hao
	 always@(posedge clk)
	 begin
	 count=count+1;
	 if(count>=24'h989680)      //sent Trig every 100ms
		begin
		Trig=1'b1;
		end
	if(count==24'h989b30)          //h989b30
		begin
		Trig=1'b0;
		count=24'b0;
		end
	 end
	 //count the distance car and ~
	 always@(posedge clk)
	 begin
	 keep_obstacle_time<=timecount;
	 if(Echo)
		begin
		timecount=timecount+1;
		end
		
	  //keep vlaues of echo
	  Echo_temp[0]<=Echo;
	  Echo_temp[1]<=Echo_temp[0];//h2b156
	  
	  if((Echo_temp==2'b10)&&(keep_obstacle_time>=24'hf4240))
	  begin
	  timecount=24'b0;
	  En=0;
	  end
	  
	  //turn right
	  if((keep_obstacle_time<=24'h35b60)&&(keep_obstacle_time>=24'h2710)&&(Echo_temp==2'b10))
		begin
		timecount=24'b0;
		En=1;
		ctr<=3'b111;
		end
		//turn left
	 temp[0]<=En;
	 temp[1]<=temp[0];
	 if(temp==2'b10)
	 begin
	 En_negedge=1;
	 tag=1;
	 count_tag=1;
	 end
	 
	 if(count_tag==1)
	 begin
	 count_total=count_total+1;
	 end
	 
	 if(En_negedge&(turnleft_count<=32'ha21fe80)&(turnleft_count>32'h42c1d80))
	 begin
	 turnleft_count=turnleft_count+1;
	  ctr<=3'b100;
	 end
	 
	 if(En_negedge&(turnleft_count<=32'h42c1d80))
	 begin
	 turnleft_count=turnleft_count+1;
	  ctr<=3'b000;
	 end
	 
	  if(En_negedge&(turnleft_count<=32'hd1cef00)&(turnleft_count>32'ha21fe80))
	 begin
	 turnleft_count=turnleft_count+1;
	  ctr<=3'b111;
	 end
	 
	 if(turnleft_count>=32'hd1cef00)
	 begin
	 En_negedge=0;
	 turnleft_count=32'b0;
	 end
	 
	 
	 
	 
	 // if hwsignal=2'b10
	 if(tag==1&((hwsignal==2'b10)|(hwsignal==2'b00)))
	 begin
	 En_tag=1;
	 tag_count=tag_count+1;
	 ctr<=3'b110;
	 end
	 if(tag_count>=32'h2faf080)
	 begin
	 En_tag=0;
	 tag_count=0;
	 tag=0;
	 count_total=0;
	 count_tag=0;
	 end
	 if(count_total>=32'h2faf0800)
	 begin
	 En_tag=0;
	 tag_count=0;
	 tag=0;
	 count_total=0;
	 count_tag=0;
	 end
	 
	 
	 end

endmodule
