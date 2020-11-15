module rx_power_ly(clk,
	rst_n,
	po_data,
	rx_down,
	key_flag
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output key_flag;

parameter inst1 = "M1"; 
parameter inst2 = "M0";

reg [15:0]com1;
reg key_state;
reg temp1;
reg temp2;
assign key_flag = temp1 & (~temp2);


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
	    com1 <= 0;
	else if( rx_down )
	    com1 <= {com1[7:0],po_data};
	else 
	    com1 <= com1;

//ÉÏÉýÊ¹ÄÜ		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state <= 0;
	else if(com1 == inst1)
	    key_state <= 1;
	else if(com1 == inst2)
	    key_state <= 0;
	else 
	    key_state <= key_state;
		
endmodule
