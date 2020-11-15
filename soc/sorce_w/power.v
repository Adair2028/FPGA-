module power( clk,
	rst_n,
	po_data,
	rx_down,
    key_state1,
    key_state2,
	key_state3,
	key_state4
    );

	input clk;
	input rst_n;
	input [7:0]po_data;
	input rx_down;
	output reg key_state1;
	output reg key_state2;
	output reg key_state3;
	output reg key_state4;

parameter inst1 = "A1"; //����
parameter inst2 = "A0";
parameter inst3 = "B1"; //�½�
parameter inst4 = "B0";
parameter inst7 = "D1"; //����
parameter inst8 = "D0";
parameter inst9 = "E1"; //�½�
parameter inst10 = "E0";

reg [15:0]com1;
reg [15:0]com2;	
reg [15:0]com4;
reg [15:0]com5;
		
//�ɼ�����ָ��
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


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com4 <= 0;
	else if( rx_down )
	    com4 <= {com4[7:0],po_data};
	else 
	    com4 <= com4;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    com5 <= 0;
	else if( rx_down )
	    com5 <= {com5[7:0],po_data};
	else 
	    com5 <= com5;	

//����ʹ��		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state1 <= 0;
	else if(com1 == inst1)
	    key_state1 <= 1;
	else if(com1 == inst2)
	    key_state1 <= 0;
	else 
	    key_state1 <= key_state1;
		
//�½�ʹ��		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state2 <= 0;
	else if(com2 == inst3)
	    key_state2 <= 1;
	else if(com2 == inst4)
	    key_state2 <= 0;
	else 
	    key_state2 <= key_state2;		
//�쳤ʹ��
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state3 <= 0;
	else if(com4 == inst7)
	    key_state3 <= 1;
	else if(com4 == inst8)
	    key_state3 <= 0;
	else 
	    key_state3 <= key_state3;
		
//����ʹ��
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    key_state4 <= 0;
	else if(com5 == inst9)
	    key_state4 <= 1;
	else if(com5 == inst10)
	    key_state4 <= 0;
	else 
	    key_state4 <= key_state4;



		
endmodule
