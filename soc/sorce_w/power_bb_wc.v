module power_bb_wc( 
       clk,
       rst_n,
       key_flag,
       key_flag1,
       key_flag2     
       );

input clk;
input rst_n;
input key_flag;
output key_flag1;
output key_flag2;

reg state;
reg [28:0]cnt;
reg key_state1;
reg key_state2;

reg temp1,temp2;
reg temp3,temp4;

assign key_flag1 = (~temp1) & temp2;
assign key_flag2 = (~temp3) & temp4;

always @(posedge clk)
    temp1 <= key_state1;
always @(posedge clk)
    temp2 <= temp1;    

always @(posedge clk)
    temp3 <= key_state2;
always @(posedge clk)
    temp4 <= temp3; 


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    state <= 0;
	else if(key_flag)
	    if(state == 1)
	        state <= 0;
	    else 
	        state <= state + 1'b1;
	else 
	    state <= state;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state1 <= 1;
    else if(cnt == 49999)
	    key_state1 <= 1;
	else if(!state)
        if(key_flag)
	        key_state1 <= 0;
        else 
            key_state1 <= key_state1;
	else 
	    key_state1 <= key_state1;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 1;
    else if(cnt == 49999)
	    key_state2 <= 1;
	else if(state)
        if(key_flag)
	        key_state2 <= 0;
        else 
            key_state2 <= key_state2;
	else 
	    key_state2 <= key_state2;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if((!key_state1)  || (!key_state2))
        if(cnt == 49999)
            cnt <= 0;
        else 
            cnt <= cnt + 1'b1;
    else 
        cnt <= 0;	
endmodule
