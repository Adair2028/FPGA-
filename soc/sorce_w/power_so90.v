module power_so90( clk,
	rst_n,
	po_data,
	rx_down,
	key_flag1,
	key_flag2
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output  key_flag1;
output  key_flag2;

parameter inst1 = "N1"; //
parameter inst2 = "N0";

parameter inst3 = "P1"; //
parameter inst4 = "P0";
	 
reg [15:0]com1;
reg [15:0]com2;
reg temp1,temp2;
reg temp3,temp4;
reg key_state1;
reg key_state2;

assign key_flag1 = temp1 & (~temp2);//上升沿

assign key_flag2 = temp3 & (~temp4);//上升沿

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

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 0;
	else if(com2 == inst3)
	    key_state2 <= 1;
	else if(com2 == inst4)
	    key_state2 <= 0;
	else 
	    key_state2 <= key_state2;		
endmodule
