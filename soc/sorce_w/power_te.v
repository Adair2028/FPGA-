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

parameter inst1 = "C1"; //��绰��ϵ��1
parameter inst2 = "C0";
parameter inst3 = "F1"; //��绰����
parameter inst4 = "F0";
parameter inst5 = "L1";//��绰��ϵ��2
parameter inst6 = "L0";

reg [15:0]com1;
reg [15:0]com2;
reg en_change;
reg en_choice;
reg [3:0]en_count;
reg en_te0;//ͨ����ϵ�˴�绰
reg en_te1;//ͨ����������绰
reg temp1,temp2,temp3,temp4;
parameter telephone_reg1 = "18237299475";//��ϵ�˵ĵ绰����
parameter telephone_reg2 = "18740404399";//��ϵ�˵ĵ绰����

assign key_flag1 = (en_choice)?(temp3 & (~temp4)):(temp1 & (~temp2));//������
assign key_flag2 = (en_choice)?(~temp3 & temp4):(~temp1 & temp2); // �½���

//������key_flag����ѡ��
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_choice <= 0;
	else if(com2 == inst3)
	    en_choice <= 1;
	else if(com1 == inst1 || com1 == inst5)
	    en_choice <= 0;
	else 
	    en_choice <= en_choice;
		
//�绰��			
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

//�ɼ������غ��½���������������� 
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
		
//��绰�����������Ҫ�����������½�����������͹ҶϵĴ������壩		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_te0 <= 0;
	else if(com1 == inst1 || com1 == inst5)
	    en_te0 <= 1;
	else if(com1 == inst2 || com1 == inst6)
	    en_te0 <= 0;
	else 
	    en_te0 <= en_te0;	
		
//ͨ������绰��������绰
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_change <= 0;
	else if(com2 == inst3)
	    en_change <= 1;
	else if(com2 == inst4)
	    en_change <= 0;
	else 
	    en_change <= en_change;	
		
//����������11˵�����µĵ绰����洢��ɣ��Ϳ���ִ��ָ����
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
//��绰ʹ��		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_te1 <= 0;
	else if(en_count == 11)
	    en_te1 <= 1;
	else 
	    en_te1 <= 0;
		
		
		
endmodule

