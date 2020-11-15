module top(clk,
	rst_n,
	rx_data,
	rx_data_voice,
	rx_data_ly,
	pul_sj,
	dir_sj,
    pul_sj2,
	dir_sj2,
	pul_ss,
	dir_ss,
	led,
	led1,
	line_tx_gsm,
	line_tx_ly,
	led3,
	pwm1,
	pwm2,
	key_in1,
	key_in2,
	line_tx_bb,
	led_bb,
    eoc,
    dout,
    pwm_tire,
    pwm_tire1,
    in1_left,
    in2_left,
    in1_right,
    in2_right,
    key_flag_me_t,
    key_flag_me_video,
    en_video
	//key_flag
    );

input clk;
input rst_n;
input rx_data;
input rx_data_voice;
input rx_data_ly;
input key_flag_me_video;
output pul_sj;
output dir_sj;	
output pul_sj2;
output dir_sj2;
output pul_ss;
output dir_ss;
output led;
output led1;
output line_tx_gsm;
output line_tx_ly;
output [1:0]led3;
output pwm1;
output pwm2;
input key_in1;
input key_in2;
output line_tx_bb;
output led_bb;
//tires
output eoc;
output [7:0]dout;
output pwm_tire;
output pwm_tire1;
output in1_left;
output in2_left;
output in1_right;
output in2_right;
input key_flag_me_t;
output en_video;

//input key_flag;
	
//wire key_state1;
//wire key_state2;
//wire key_state3;
//wire key_state4;
//wire key_flag1;
//wire key_flag2;
wire clk;
wire rst_n;

//wire [87:0]telephone;
wire [7:0]po_data;  //¥Æø⁄å∆
wire rx_down;
wire [7:0]po_data_voice; // ”Ô“Ù
wire rx_down_voice;
wire [7:0]po_data_ly;  //¿∂—¿Ω” ’
wire rx_down_ly;


//wire key_flag_me_t;
//wire key_flag_me;
assign led = dir_sj;	
assign led1 = dir_ss;

assign  pul_sj2 = pul_sj;
assign	dir_sj2 = dir_sj;

/*uart_ceshi  uart_ceshi_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag),
	.line_tx(rx_data_voice)
    );*/


//tires
top_adc  top_adc_inst(  
       .clk(clk),
       .rst_n(rst_n),
       .eoc(eoc),
       .dout(dout),
       .pwm_tire(pwm_tire),
       .pwm_tire1(pwm_tire1),
       .in1_left(in1_left),
       .in2_left(in2_left),
       .in1_right(in1_right),
       .in2_right(in2_right)
       
);

bujindianji  bujindianji_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.pul_ss(pul_ss),
	.dir_ss(dir_ss),
	.pul_sj(pul_sj),
	.dir_sj(dir_sj)
	
    );	
	
so90  so90_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.pwm1(pwm1),
	.pwm2(pwm2)
    );


video_en  video_en_inst( 
       .clk(clk),
       .rst_n(rst_n),
       .po_data(po_data),
       .rx_down(rx_down),
       .key_state1(en_video)

);
/*bujindianji  bujindianji_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_state1(key_state1),
	.key_state2(key_state2),
	.pul(pul_sj),
	.dir(dir_sj)
    );

bujindianji1  bujindianji1_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_state1(key_state3),
	.key_state2(key_state4),
	.pul(pul_ss),
	.dir(dir_ss)
    );	*/
	
//uart_rx	
uart_rx  uart_rx_inst(
     .clk(clk),
	 .rst_n(rst_n),
	 .rx_data(rx_data),
	 .po_data(po_data),
	 .rx_down(rx_down)
    );	
	
uart_rx_voice  uart_rx_voice_inst(
    .clk(clk),
	.rst_n(rst_n),
	.rx_data(rx_data_voice),
	.po_data(po_data_voice),
	.rx_down(rx_down_voice)
    );
	
uart_rx_ly  uart_rx_ly_inst(
    .clk(clk),
	.rst_n(rst_n),
	.rx_data(rx_data_ly),
	.po_data(po_data_ly),
	.rx_down(rx_down_ly)
    );
	
/*power  power_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
    .key_state1(key_state1),
    .key_state2(key_state2),
	.key_state3(key_state3),
	.key_state4(key_state4)
    );*/
		
//uart_tx
uart_tx_ly  uart_tx_ly_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data_voice(po_data_voice),
	.po_data(po_data),
	.rx_down(rx_down),
	.rx_down_voice(rx_down_voice),
	.line_tx_ly(line_tx_ly),
	.led3(led3)
    );
	
gsm  gsm_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.po_data_ly(po_data_ly),
	.rx_down_ly(rx_down_ly),
	.key_flag_me_t(key_flag_me_t),
    .key_flag_me_video(key_flag_me_video),
	.line_tx(line_tx_gsm)
    );	
	
bb  bb_inst( 
    .clk(clk),
    .rst_n(rst_n),
    .po_data(po_data_voice),
    .rx_down(rx_down_voice),
    .line_tx(line_tx_bb),
    .led(led_bb) 
    );

/*xiaodou  xiaodou_inst(
  .clk(clk),
		 .rst_n(rst_n),
		 .key_in(key_in1),
		 .key_flag(key_flag_me_t),
		 .key_state()
    );*/
/*xiaodou  xiaodou_inst1(
  .clk(clk),
		 .rst_n(rst_n),
		 .key_in(key_in2),
		 .key_flag(key_flag_me_video),
		 .key_state()
    );*/
endmodule
