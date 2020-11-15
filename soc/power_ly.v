module power_ly(clk,
	rst_n,
	po_data,
	rx_down,
	key_flag1,
	key_flag2,
	key_flag3,
	key_flag4,
	key_flag5,
	key_flag6,
	key_flag7,
	key_flag8,
	key_flag9
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output  key_flag1;
output  key_flag2;
output  key_flag3;
output  key_flag4;
output  key_flag5;
output  key_flag6;
output  key_flag7;
output  key_flag8;
output  key_flag9;


parameter inst1 = "G1"; //靠背蓝牙上升
parameter inst2 = "G0";
parameter inst3 = "H1"; //靠背蓝牙下降
parameter inst4 = "H0";

parameter inst5 = "I1"; //靠腿蓝牙上升
parameter inst6 = "I0";
parameter inst7 = "J1"; //靠腿蓝牙下降
parameter inst8 = "J0";

parameter inst9 = "O1"; //串口的上的舵机
parameter inst10 = "O0";
/*********** 整体思路通过四个触发信号来进行4个不同指令的发   *************/
/*********** 送，以达到床板两个步进电机（各两个指令）的驱动  *************/
	 
reg [15:0]com1;
reg [15:0]com2;
reg [15:0]com3;
reg [15:0]com4;
reg [15:0]com5;
reg temp1,temp2,temp3,temp4;
reg temp5,temp6,temp7,temp8,temp9,temp10;
reg key_state1;
reg key_state2;
reg key_state3;
reg key_state4;
reg key_state5;

assign key_flag1 = temp1 & (~temp2);//上升沿
assign key_flag2 = (~temp1 & temp2); // 下降沿
assign key_flag3 = temp3 & (~temp4);//上升沿
assign key_flag4 = (~temp3 & temp4); // 下降沿
assign key_flag5 = temp5 & (~temp6);//上升沿
assign key_flag6 = (~temp5 & temp6); // 下降沿
assign key_flag7 = temp7 & (~temp8);//上升沿
assign key_flag8 = (~temp7 & temp8); // 下降沿
assign key_flag9 = temp9 & (~temp10);//上升沿
//assign key_flag10 = (~temp9 & temp10); // 下降沿
//采集上升沿和下降沿所需的两个变量 
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp1 <= 0;
	else 
	    temp1 <= key_state1;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp2 <= 0;
	else 
	    temp2 <= temp1;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp3 <= 0;
	else 
	    temp3 <= key_state2;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp4 <= 0;
	else 
	    temp4 <= temp3;
				
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp5 <= 0;
	else 
	    temp5 <= key_state3;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp6 <= 0;
	else 
	    temp6 <= temp5;
		
		
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp7 <= 0;
	else 
	    temp7 <= key_state4;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp8 <= 0;
	else 
	    temp8 <= temp7;	

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp9 <= 0;
	else 
	    temp9 <= key_state5;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp10 <= 0;
	else 
	    temp10 <= temp9;		
//采集到的指令
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com1 <= 0;
	else if( rx_down )
	    com1 <= {com1[7:0],po_data};
	else 
	    com1 <= com1;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com2 <= 0;
	else if( rx_down )
	    com2 <= {com2[7:0],po_data};
	else 
	    com2 <= com2;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com3 <= 0;
	else if( rx_down )
	    com3 <= {com3[7:0],po_data};
	else 
	    com3 <= com3;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com4 <= 0;
	else if( rx_down )
	    com4 <= {com4[7:0],po_data};
	else 
	    com4 <= com4;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com5 <= 0;
	else if( rx_down )
	    com5 <= {com5[7:0],po_data};
	else 
	    com5 <= com5;
		
//上升使能（靠背）		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state1 <= 0;
	else if(com1 == inst1)
	    key_state1 <= 1;
	else if(com1 == inst2)
	    key_state1 <= 0;
	else 
	    key_state1 <= key_state1;
		
//下降使能		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 0;
	else if(com2 == inst3)
	    key_state2 <= 1;
	else if(com2 == inst4)
	    key_state2 <= 0;
	else 
	    key_state2 <= key_state2;		
//上升使能（靠腿）
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state3 <= 0;
	else if(com3 == inst5)
	    key_state3 <= 1;
	else if(com3 == inst6)
	    key_state3 <= 0;
	else 
	    key_state3 <= key_state3;
//下降使能		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state4 <= 0;
	else if(com4 == inst7)
	    key_state4 <= 1;
	else if(com4 == inst8)
	    key_state4 <= 0;
	else 
	    key_state4 <= key_state4;
		
//串口屏舵机
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state5 <= 0;
	else if(com5 == inst9)
	    key_state5 <= 1;
	else if(com5 == inst10)
	    key_state5 <= 0;
	else 
	    key_state5 <= key_state5;
endmodule
