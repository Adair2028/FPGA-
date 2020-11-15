module power_bb_voice(clk,
	rst_n,
	po_data,
	rx_down,
    key_flag1,
    key_flag2,
    led 
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output key_flag1;
output  key_flag2;
output reg led;

parameter inst1 = "K1"; //轮椅模式指令
parameter inst2 = "K0"; //病床模式指令

reg [15:0]com1;
reg [15:0]com2;
reg [24:0]count;

reg temp1,temp2;
reg temp3,temp4;
reg key_state1;
reg key_state2;

assign key_flag1 = temp1 & (~temp2);

assign key_flag2 = temp3 & (~temp4);

always @(posedge clk)
    temp1 <= key_state1;
always @(posedge clk)
    temp2 <=  temp1;  
  
always @(posedge clk)
    temp3 <= key_state2;
always @(posedge clk)
    temp4 <=  temp3; 



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        count <= 0;
    else if(key_state1 | key_state2)
        if(count == 49999)
            count <= 0;
        else 
            count <= count + 1'b1;
    else 
        count <= 0;
		
//采集到的指令
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com1 <= 0;
	else if( rx_down )
	    com1 <= {com1[7:0],po_data};
	else if(count == 49990)
	    com1 <= 0;
	else 
	    com1 <= com1;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com2 <= 0;
	else if( rx_down )
	    com2 <= {com2[7:0],po_data};
	else if(count == 49990)
	    com2 <= 0;
	else 
	    com2 <= com2;

		
//	
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state1 <= 0;
    else if(count == 49999)
	    key_state1 <= 0;
	else if(com1 == inst1)
	    key_state1 <= 1;
	else 
	    key_state1 <= key_state1;
//			
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 0;
	else if(count == 49999)
	    key_state2 <= 0;
	else if(com2 == inst2)
	    key_state2 <= 1;
	else 
	    key_state2 <= key_state2;
		
	
always @(posedge clk or negedge rst_n) 
    if(!rst_n)
        led <= 0;
    else if(key_flag1)		
        led <= 1;
    else if(key_flag2)
        led <= 0;
    else
        led <= led;
endmodule
