module video_en( 
       clk,
       rst_n,
       po_data,
       rx_down,
       key_state1

);
input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output reg key_state1;

parameter inst1 = "X1"; //上升
parameter inst2 = "X0";

reg [15:0]com1;
reg [15:0]com2;	

		
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
	    key_state1 <= 0;
	else if(com1 == inst1)
	    key_state1 <= 1;
	else if(com1 == inst2)
	    key_state1 <= 0;
	else 
	    key_state1 <= key_state1;
		
endmodule
