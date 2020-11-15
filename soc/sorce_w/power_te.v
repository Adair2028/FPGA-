module power_te( clk,
	rst_n,
	po_data,
	rx_down,
	key_flag1,
	key_flag2,
	telephone
    );

	input clk;
	input rst_n;
	input [7:0]po_data;
	input rx_down;
	output  key_flag1;
	output  key_flag2;
	output reg [87:0]telephone;

parameter inst1 = "C1"; //打电话联系人1
parameter inst2 = "C0";
parameter inst3 = "F1"; //打电话拨号
parameter inst4 = "F0";
parameter inst5 = "L1";//打电话联系人2
parameter inst6 = "L0";

reg [15:0]com1;
reg [15:0]com2;
reg en_change;
reg en_choice;
reg [3:0]en_count;
reg en_te0;//通过联系人打电话
reg en_te1;//通过输入号码打电话
reg temp1,temp2,temp3,temp4;
parameter telephone_reg1 = "18237299475";//联系人的电话号码
parameter telephone_reg2 = "18740404399";//联系人的电话号码

assign key_flag1 = (en_choice)?(temp3 & (~temp4)):(temp1 & (~temp2));//上升沿
assign key_flag2 = (en_choice)?(~temp3 & temp4):(~temp1 & temp2); // 下降沿

//用来对key_flag进行选择
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_choice <= 0;
	else if(com2 == inst3)
	    en_choice <= 1;
	else if(com1 == inst1 || com1 == inst5)
	    en_choice <= 0;
	else 
	    en_choice <= en_choice;
		
//电话号			
always@(posedge clk or negedge rst_n)
    if(!rst_n)
	    telephone <= telephone_reg1;
	else if(en_change )//&& (en_count != 11))
	    if(rx_down)
		    telephone <= {telephone[79:0],po_data};
		else 
		    telephone <= telephone;
	else if(com1 == inst5)
	    telephone <= telephone_reg2;
	else 
	    telephone <= telephone_reg1;

//采集上升沿和下降沿所需的两个变量 
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp1 <= 0;
	else 
	    temp1 <= en_te0;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp2 <= 0;
	else 
	    temp2 <= temp1;	


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp3 <= 0;
	else 
	    temp3 <= en_te1;
		
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
		
//打电话所需变量（需要他的上升和下降沿来做拨打和挂断的触发脉冲）		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_te0 <= 0;
	else if(com1 == inst1 || com1 == inst5)
	    en_te0 <= 1;
	else if(com1 == inst2 || com1 == inst6)
	    en_te0 <= 0;
	else 
	    en_te0 <= en_te0;	
		
//通过输入电话号码来打电话
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_change <= 0;
	else if(com2 == inst3)
	    en_change <= 1;
	else if(com2 == inst4)
	    en_change <= 0;
	else 
	    en_change <= en_change;	
		
//计数当计数11说明把新的电话号码存储完成，就可以执行指令了
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        en_count <= 0;
    else if(en_change)
        if(en_count == 11)
		    en_count <= en_count;
		else if(rx_down)
		    en_count <= en_count + 1'b1;
		else 
		    en_count <= en_count;
	else 
	    en_count <= 0;
//打电话使能		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_te1 <= 0;
	else if(en_count == 11)
	    en_te1 <= 1;
	else 
	    en_te1 <= 0;
		
		
		
endmodule

