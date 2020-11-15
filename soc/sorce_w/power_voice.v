module power_voice( clk,
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
	en_choice
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
output reg en_choice;

parameter inst1 = "K1"; //轮椅模式指令
parameter inst2 = "K0"; //病床模式指令
parameter delay_cnt = 76800; //uart发送两条指令的估计时间
                              //（因为tx只有一条线所以不能同时发）
parameter delay_cnt_1s = 24000000; //1s的延迟
reg [15:0]com1;
reg [15:0]com2;
reg en1;
reg en2;
reg temp1,temp2,temp3,temp4;
reg temp5,temp6,temp7,temp8;
reg key_state1;
reg key_state2;
reg key_state3;
reg key_state4;

reg en_cnt;
reg [17:0]cnt;
reg clk_delay;

reg [25:0]cnt_1s;
reg [3:0]count;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        en_choice <= 0;
	else if(com1 == inst1 || com2 == inst2)
	    en_choice <= 1;
	else if(key_flag6 || key_flag8)
	    en_choice <= 0;
	else 
	    en_choice <= en_choice;
	
/**********************************************************************
        整体思路：由于两个电机要一起动，而uart的tx只有一条线
		所以做一个传输两个指令时间的延迟，还要让电机持续10s
		所以在做个10s的计数器，其余和power_ly没太大区别.
        en_choice的作用是用来区分语音的赋值和蓝牙发送模块的赋值
**********************************************************************/
assign key_flag1 = temp1 & (~temp2);//上升沿     G1
assign key_flag2 = (~temp1 & temp2); // 下降沿   G0
assign key_flag3 = temp3 & (~temp4);//上升沿     H1
assign key_flag4 = (~temp3 & temp4); // 下降沿   H0
assign key_flag7 = temp5 & (~temp6);//上升沿     J1
assign key_flag8 = (~temp5 & temp6); // 下降沿   J0
assign key_flag5 = temp7 & (~temp8);//上升沿     I1
assign key_flag6 = (~temp7 & temp8); // 下降沿   I0


//计数器
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_cnt <= 0;
	else if(cnt == delay_cnt - 1)
	    en_cnt <= 0;
	else if(key_flag1 || key_flag2 || key_flag3 || key_flag4)
	    en_cnt <= 1;
	else 
	    en_cnt <= en_cnt;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    cnt <= 0;
	else if(en_cnt)
        if(cnt == delay_cnt - 1)
		    cnt <= 0;
	    else 
		    cnt <= cnt + 1'b1;
	else 
	    cnt <= 0;
				
//使key_state持续10s的计数器
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    cnt_1s <= 0;
	else if(key_state1 || key_state2)
	    if(cnt_1s == delay_cnt_1s - 1)
	        cnt_1s <= 0;
	    else 
		    cnt_1s <= cnt_1s + 1'b1;
	else 
	    cnt_1s <= 0;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    count <= 0;
	else if(key_state1 || key_state2)
	    if(count == 9)
		    count <= 0;
		else if(cnt_1s == delay_cnt_1s - 1)
		    count <= count + 1'b1;
		else 
		    count <= count;
	else 
	    count <= 0;
		
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
//采集到的指令
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com1 <= 0;
	else if( rx_down )
	    com1 <= {com1[7:0],po_data};
	else if(count == 9)
	    com1 <= 0;
	else 
	    com1 <= com1;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com2 <= 0;
	else if( rx_down )
	    com2 <= {com2[7:0],po_data};
	else if(count == 9)
	    com2 <= 0;
	else 
	    com2 <= com2;

		
//上升使能（靠背）		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state1 <= 0;
	else if(count == 9)
	    key_state1 <= 0;
	else if(com1 == inst1)
	    key_state1 <= 1;
	else 
	    key_state1 <= key_state1;
		
always @(posedge clk)
    if(!rst_n)
	    key_state3 <= 0;
	else if(cnt ==  delay_cnt - 1)
        key_state3 <= key_state1;
	else 
	    key_state3 <= key_state3;

		
//下降使能		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 0;
	else if(count == 9)
	    key_state2 <= 0;
	else if(com2 == inst2)
	    key_state2 <= 1;
	else 
	    key_state2 <= key_state2;
		
always @(posedge clk)
    if(!rst_n)
	    key_state4 <= 0;
	else if(cnt ==  delay_cnt - 1)
        key_state4 <= key_state2;
	else 
	    key_state4 <= key_state4;		
		
endmodule
