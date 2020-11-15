module bujindianji2(clk,
	rst_n,
	key_state1,
	key_state2,
	pul,
	dir
    );

input clk;
input rst_n;
input key_state1;
input key_state2;
output reg pul;
output reg dir;

localparam delay_cnt = 25000;
reg [15:0]cnt;
reg state;
reg next_state;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    cnt <= 0;
	else if(key_state1 | key_state2)
        if(cnt == delay_cnt - 1)
	        cnt <= 0;
	    else 
	        cnt <= cnt + 1'b1;
	else 
	    cnt <= 0;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        pul <= 0;	
	else if(cnt > delay_cnt / 2 - 1)
        pul <= 1;	
	else 
	    pul <= 0;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    dir <= 0;
	else if(key_state1)
	    dir <= 0;
	else if(key_state2)
	    dir <= 1;
	else 
	    dir <= dir;

endmodule
