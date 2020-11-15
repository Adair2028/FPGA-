module power_bb( 
    clk,
	rst_n,
	po_data,
	rx_down,
	key_flag
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output  key_flag;

parameter inst1 = 16'b1100_1010_1101_0101; 
parameter inst2 = 16'b1011_0101_1011_1101;

reg [15:0]com1;
reg [28:0]cnt;

reg temp1;
reg temp2;
reg key_state;

assign key_flag = temp1 & (~temp2);


always @(posedge clk)
    temp1 <= key_state;
always @(posedge clk)
    temp2 <=  temp1;	


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com1 <= 0;
	else if( rx_down )
	    com1 <= {com1[7:0],po_data};
	else if(cnt == 49999)
        com1 <= 0;
	else 
	    com1 <= com1;

		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state <= 0;
	else if(cnt == 49999)
	    key_state <= 0;
	else if(com1 == inst2)
	    key_state <= 1;
	else 
	    key_state <= key_state;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if(key_state)
        if(cnt == 49999)
            cnt <= 0;
        else 
            cnt <= cnt + 1'b1;
    else 
        cnt <= 0;	
	
endmodule
