`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:48:59 10/21/2020 
// Design Name: 
// Module Name:    tx 
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
module tx1(
input clk,
input button_out,
input button_negedge,
input rst_n,

output reg [7:0] data_1,
output reg send_en_1

    );
 
localparam cnt_end='d100_000;	//设置大于10倍波特率的一字节发送的速度
	reg [27:0] cnt_1;
	reg [10:0] count_1;
   reg flag;
   reg [31:0]cnt;
   reg bt;
   
   
	always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
   flag<=1'b0;
   else if(!button_out)
   flag<=1'b1;
   else
   flag<=flag;
 end
 always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
      begin
       cnt<='d0;
     
      end
   else if((count_1=='d4)||(count_1=='d14)||(cnt=='d49_999_999)||(count_1=='d25))  begin
       cnt<='d0;
       
   end
 
   else if(flag)  begin
   cnt<=cnt+'d1;
   
   end
 end
 
  always@(posedge clk or negedge rst_n)
 begin
   if(!rst_n)
      begin
       
       bt<=0;
      end
   else if((count_1=='d14)||(count_1=='d4)||(count_1=='d25))
       bt<=0;
   else if(cnt=='d49_999_999)  begin
       bt<=1;
       
   end
 
   else   begin
    bt<=bt;
   
   end
 end
 
		always@(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
		begin
			cnt_1<= 1'b0;
			data_1<= 1'b0;
			send_en_1 <= 1'b0;
         count_1<='d0;
		end
	else if(cnt_1 == cnt_end)//当计数到最大值时
		begin
		if(flag)//当按键时发送第一个指令
		begin
			cnt_1 <= 1'b0;
		     //开始发送数据，cnt_1进行清0
         
        
	    case(count_1)
			0:		begin data_1 <="A"; count_1<='d1; send_en_1<= 1'b1; end
			1: 	begin data_1 <="T"; count_1<='d2; send_en_1<= 1'b1; end
			2: 	begin data_1 <="+"; count_1<='d3; send_en_1<= 1'b1; end
         3:    begin data_1 <="T"; count_1<='d4; send_en_1<= 1'b1; end
         4:    begin data_1 <=8'b0000_1101;count_1<='d5; send_en_1<= 1'b1; end
        
         5:    begin 
               data_1 <="\n";
               send_en_1<= 1'b1;
               count_1<='d6; 
               end
         6:   begin
               if(bt)
               count_1<='d7; 
               else
               begin
               send_en_1<= 1'b0;
               count_1<=count_1; end
                 
               end
               
         7:    begin data_1 <="A"; count_1<='d8; send_en_1<= 1'b1;end
         8:    begin data_1 <="T"; count_1<='d9; send_en_1<= 1'b1;end
         9:    begin data_1 <="+"; count_1<='d10;send_en_1<= 1'b1;end
        10:    begin data_1 <="S"; count_1<='d11;send_en_1<= 1'b1;end
        11:    begin data_1 <="P"; count_1<='d12;send_en_1<= 1'b1;end
        12:    begin data_1 <="O"; count_1<='d13;send_en_1<= 1'b1;end
        13:    begin data_1 <="2"; count_1<='d14;send_en_1<= 1'b1;end
        14:    begin data_1 <=8'b0000_1101;count_1<='d15;send_en_1<= 1'b1;end
        15:    begin 
               data_1 <="\n";
               send_en_1<= 1'b1;
               count_1<='d16; 
               end
        16:    begin   
               if(bt)
               count_1<='d17;
               else               
                begin
               send_en_1<= 1'b0;
               count_1<=count_1; end
                 
               end
               
               
               
        17:    begin data_1 <="A"; count_1<='d18; send_en_1<= 1'b1;end
        18:    begin data_1 <="T"; count_1<='d19; send_en_1<= 1'b1;end
        19:    begin data_1 <="+"; count_1<='d20; send_en_1<= 1'b1;end
        20:    begin data_1 <="H"; count_1<='d21; send_en_1<= 1'b1;end
        21:    begin data_1 <="E"; count_1<='d22; send_en_1<= 1'b1;end
        22:    begin data_1 <="A"; count_1<='d23; send_en_1<= 1'b1;end
        23:    begin data_1 <="R"; count_1<='d24; send_en_1<= 1'b1;end
        24:    begin data_1 <="T"; count_1<='d25; send_en_1<= 1'b1;end
        25:    begin data_1 <=8'b0000_1101;count_1<='d26; send_en_1<= 1'b1;end  //1010
        26:    begin 
               data_1 <= 8'b0000_1010;
               send_en_1<= 1'b1;
               count_1<='d27; 
               end
        27:    begin   
               if(bt)
               count_1<='d0;
               else               
                begin
               send_en_1<= 1'b0;
               count_1<=count_1; end
                 
               end      
               
               
               
     



     
         
			
			default:begin data_1<=8'b0000_0000; send_en_1 <= 1'b0; end 
			endcase
		  end    
        else
          begin
          send_en_1 <= 1'b0; 
          count_1<=count_1;
          end
                  
                             
      end            
		else
			begin
			cnt_1<= cnt_1+1'b1;//没有到一字节的发送最大值，发送使能"0"，继续计数
			send_en_1 <= 1'b0;
			end
	end
   endmodule
