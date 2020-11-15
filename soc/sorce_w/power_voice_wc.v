module power_voice_wc(
    clk,
	rst_n,
	po_data,
	rx_down,
    key_flag,
	en_choice_wc
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output key_flag;
output en_choice_wc;


parameter inst1 = "Q1"; //上厕所指令
reg [15:0]com;
reg key_state;
reg [3:0]count;
reg temp1;
reg temp2;

assign key_flag = temp1 & (~temp2);

assign en_choice_wc = key_state;

//采集上升沿和下降沿所需的两个变量 
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp1 <= 0;
	else 
	    temp1 <= key_state;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    temp2 <= 0;
	else 
	    temp2 <= temp1;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com <= 0;
	else if( rx_down )
	    com <= {com[7:0],po_data};
	else if(count == 9)
	    com <= 0;
	else 
	    com <= com;
		

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state <= 0;
	else if(count == 9)
	    key_state <= 0;
	else if(com == inst1)
	    key_state <= 1;
	else 
	    key_state <= key_state;
			

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        count <= 0;
    else if(key_state)
	    if(count == 9)
		    count <= 0;
		else 
            count <= count + 1'b1; 
    else 
        count <= 0;	
	
	
	
endmodule
