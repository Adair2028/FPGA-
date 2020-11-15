module uart_tx_ly(clk,
	rst_n,
	po_data_voice,
	po_data,
	rx_down,
	rx_down_voice,
	line_tx_ly,
	led3
    );

input clk;
input rst_n;
input [7:0]po_data_voice;
input [7:0]po_data;
input rx_down;
input rx_down_voice;
output reg line_tx_ly;	
output reg [1:0]led3;

wire key_flag1;//uart发送指令的标志位
wire key_flag2;
wire key_flag3;
wire key_flag4;
wire key_flag5;
wire key_flag6;
wire key_flag7;
wire key_flag8;	
wire key_flag9;	

wire key_flag1_ly;//蓝牙模块的标志位输出
wire key_flag2_ly;
wire key_flag3_ly;
wire key_flag4_ly;
wire key_flag5_ly;
wire key_flag6_ly;
wire key_flag7_ly;
wire key_flag8_ly;
wire key_flag9_ly;

wire key_flag1_voice;//语音模块的标志位输出
wire key_flag2_voice;
wire key_flag3_voice;
wire key_flag4_voice;
wire key_flag5_voice;
wire key_flag6_voice;
wire key_flag7_voice;
wire key_flag8_voice;
wire key_flag9_voice;

wire line_tx1_ly;  //uart——tx的输出
wire line_tx2_ly;
wire line_tx3_ly;
wire line_tx4_ly;
wire line_tx5_ly;
wire line_tx6_ly;
wire line_tx7_ly;
wire line_tx8_ly;
wire line_tx9_ly;

reg [3:0]state;
wire en_choice; //语音和蓝牙的选择使能
wire en_choice_wc;

assign key_flag1 = (en_choice)?key_flag1_voice:key_flag1_ly;
assign key_flag2 = (en_choice)?key_flag2_voice:key_flag2_ly;
assign key_flag3 = (en_choice)?key_flag3_voice:key_flag3_ly;
assign key_flag4 = (en_choice)?key_flag4_voice:key_flag4_ly;
assign key_flag5 = (en_choice)?key_flag5_voice:key_flag5_ly;
assign key_flag6 = (en_choice)?key_flag6_voice:key_flag6_ly;
assign key_flag7 = (en_choice)?key_flag7_voice:key_flag7_ly;
assign key_flag8 = (en_choice)?key_flag8_voice:key_flag8_ly;
assign key_flag9 = (en_choice_wc)?key_flag9_voice:key_flag9_ly;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    state <= 0;
	else if(key_flag1)
	    state <= 0;
	else if(key_flag2)
	    state <= 1;
	else if(key_flag3)
	    state <= 2;
	else if(key_flag4)
	    state <= 3;
	else if(key_flag5)
	    state <= 4;
	else if(key_flag6)
	    state <= 5;
	else if(key_flag7)
	    state <= 6;
	else if(key_flag8)
	    state <= 7;
	else if(key_flag9)
	    state <= 8;
	else 
	    state <= state;
	    
always @(posedge clk)
    case(state)
	0:line_tx_ly <= line_tx1_ly;
	1:line_tx_ly <= line_tx2_ly;
	2:line_tx_ly <= line_tx3_ly;
	3:line_tx_ly <= line_tx4_ly;
	4:line_tx_ly <= line_tx5_ly;
	5:line_tx_ly <= line_tx6_ly;
	6:line_tx_ly <= line_tx7_ly;
	7:line_tx_ly <= line_tx8_ly;
	8:line_tx_ly <= line_tx9_ly;
	default:;
	endcase	

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        led3 <= 0;
    else if(key_flag1_ly)	
        led3 <= 0;
    else if(key_flag2_ly)
	    led3 <= 2'b01;
	else if(key_flag3_ly)
	    led3 <= 2'b10;
	else if(key_flag4_ly)
	    led3 <= 2'b11;
	else 
	    led3 <= led3;

		
power_ly  power_ly_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.key_flag1(key_flag1_ly),
	.key_flag2(key_flag2_ly),
	.key_flag3(key_flag3_ly),
	.key_flag4(key_flag4_ly),
	.key_flag5(key_flag5_ly),
	.key_flag6(key_flag6_ly),
	.key_flag7(key_flag7_ly),
	.key_flag8(key_flag8_ly),
	.key_flag9(key_flag9_ly)
    );

power_voice  power_voice_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data_voice),
	.rx_down(rx_down_voice),
	.key_flag1(key_flag1_voice),
	.key_flag2(key_flag2_voice),
	.key_flag3(key_flag3_voice),
	.key_flag4(key_flag4_voice),
	.key_flag5(key_flag5_voice),
	.key_flag6(key_flag6_voice),
	.key_flag7(key_flag7_voice),
	.key_flag8(key_flag8_voice),
	.en_choice(en_choice)
    );	
	

power_voice_wc  power_voice_wc_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data_voice),
	.rx_down(rx_down_voice),
    .key_flag(key_flag9_voice),
	.en_choice_wc(en_choice_wc)
    );	
	
uart_tx_ly1  uart_tx_ly1_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag1),
	.line_tx(line_tx1_ly)
    );
	
	
uart_tx_ly2  uart_tx_ly2_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag2),
	.line_tx(line_tx2_ly)
    );
	
	
uart_tx_ly3  uart_tx_ly3_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag3),
	.line_tx(line_tx3_ly)
    );
	
uart_tx_ly4  uart_tx_ly4_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag4),
	.line_tx(line_tx4_ly)
    );

uart_tx_ly5  uart_tx_ly5_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag5),
	.line_tx(line_tx5_ly)
    );

uart_tx_ly6  uart_tx_ly6_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag6),
	.line_tx(line_tx6_ly)
    );

uart_tx_ly7  uart_tx_ly7_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag7),
	.line_tx(line_tx7_ly)
    );

uart_tx_ly8  uart_tx_ly8_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag8),
	.line_tx(line_tx8_ly)
    );
	
uart_tx_ly9  uart_tx_ly9_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag9),
	.line_tx(line_tx9_ly)
    );		
endmodule
