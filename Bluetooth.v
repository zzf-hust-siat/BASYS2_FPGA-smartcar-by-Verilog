`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:50:05 06/23/2017 
// Design Name: 
// Module Name:    Bluetooth 
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
module Bluetooth(
    input clk,
	 input Rx,
	 output Tx,
	 output seg_data,
	 output seg_slect,
	 output bl_En,
	 output bl_ctr
    );
	 reg EnRead;
	 reg [19:0]fp;
	 reg [23:0]seg_fp;
	 reg seg_fp_clk;
	 reg [7:0]seg_data;
	 reg [7:0]data;
	 reg [7:0]seg_slect;
	 reg bl_En;
	 reg [2:0]bl_ctr;
	 wire Rx;
	 reg Tx;
	 /////////初始化
	 initial
	 begin
	 fp=20'h0;
	 seg_fp=24'h0;
	 seg_fp_clk=0;
	 data=8'hfe;
	 seg_slect=8'hfe;
	 Tx=0;
	 bl_En=0;
	 bl_ctr=2'b001;
	 end
	 
	 always@(posedge clk)
	 begin
		if(Rx==0)
			begin
				EnRead=1;
			end
		if(EnRead)
			begin
				fp=fp+1;
			end
		case(fp)
		20'h3d09:
			begin
				data[0]=Rx;
			end
		20'h65ba:
			begin
				data[1]=Rx;
			end
		20'h8e6a:
			begin
				data[2]=Rx;
			end
		20'hb71b:
			begin
				data[3]=Rx;
			end
		20'hdfcc:
			begin
				data[4]=Rx;
			end
		20'h1087c:
			begin
				data[5]=Rx;
			end	
		20'h1312d:
			begin
				data[6]=Rx;
			end
		20'h159de:
			begin
				data[7]=Rx;
			end
		20'h1828e:              //到停止位
			begin
				EnRead=0;
				fp=20'h0;
			end
		endcase
	 end
	 // 7 段数码管
	 always@(posedge clk)
	 begin
	 seg_fp=seg_fp+1;
	 if(seg_fp==24'hfffff)
		begin
		seg_fp_clk=0;
		
		end
		if(seg_fp==24'h1e8480)
		begin
		seg_fp_clk=1;
		
		end
	 end
	 always@(posedge seg_fp_clk)
	 begin
	 
	 case(data)
	  8'h0:
		begin
		seg_data=8'b11000000;
		bl_ctr=3'b010;                 //向前
		end
	  8'h1:
		begin
		seg_data=8'b11111001;
		bl_ctr=3'b111;                 //turn right
		end
	  8'h2:
		begin
		seg_data=8'b10100100;
		bl_ctr=3'b011;                 //back
		end
	  8'h3:
		begin
		seg_data=8'b10110000;
		bl_ctr=3'b100;                 //turn left
		end
	  8'h4:
		begin
		seg_data=8'b10011001;
		bl_ctr=3'b001;                //stop
		end
	  8'h5:
		begin
		seg_data=8'b10010010;
		bl_En=1;                      //shoudong
		end
	  8'h6:
		begin
		seg_data=8'b10000010;
		bl_En=0;                       //自动
		end
	  8'h7:
		begin
		seg_data=8'b00000111;
		end
	  8'h8:
		begin
		seg_data=8'b01111111;
		end
	  8'h9:
		begin
		seg_data=8'b01101111;
		end
	 8'hff:
		begin
		seg_data=8'b01110110;
		end
	 8'hfe:
		begin
		seg_data=8'b10001100;
		end
	  endcase
	  
	 end
endmodule

