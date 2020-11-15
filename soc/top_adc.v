module top_adc(clk,
       rst_n,
       eoc,
       dout,
       pwm_tire,
       pwm_tire1,
       in1_left,
       in2_left,
       in1_right,
       in2_right
       
);

input clk;
input rst_n;
output eoc;
output [7:0]dout;
output pwm_tire;
output pwm_tire1;
output in1_left;
output in2_left;
output in1_right;
output in2_right;
wire clk_1mhz;
wire soc;
wire pd;
wire [2:0]s;
wire [11:0]dout_r;

wire key_state_s;
wire key_state_forward_h;    
wire key_state_forward_l;  
wire key_state_back;       
wire key_state_left;       
wire key_state_right; 
     
assign pwm_tire1 = pwm_tire;
assign dout = dout_r[11:4];

div_time  div_time_inst( 
       .clk(clk),
       .rst_n(rst_n),
       .clk_1mhz(clk_1mhz)
       );

power_adc  power_adc_inst( 
       .clk(clk_1mhz),
       .rst_n(rst_n),
       .eoc(eoc),
       .soc(soc),
       .pd(pd),
       .s(s)
);

adc adc_inst(
    .eoc(eoc), 
    .dout(dout_r), 
    .clk(clk_1mhz), 
    .pd(pd),
    .s(s),
    .soc(soc) 
);


power_pwm  power_pwm_inst(
      .clk(clk_1mhz),
      .rst_n(rst_n),
      .s(s),
      .eoc(eoc),
      .dout(dout),
      .key_state_s(key_state_s),
      .key_state_forward_h(key_state_forward_h),
      .key_state_forward_l(key_state_forward_l),
      .key_state_back_h(key_state_back_h),
      .key_state_back_l(key_state_back_l),
      .key_state_left_h(key_state_left_h),
      .key_state_left_l(key_state_left_l),
      .key_state_right_h(key_state_right_h),
      .key_state_right_l(key_state_right_l)

);

pwm   pwm_inst( 
       .clk(clk),
       .rst_n(rst_n),
       .key_state_s(key_state_s),
       .key_state_forward_h(key_state_forward_h),
       .key_state_forward_l(key_state_forward_l),
       .key_state_back_h(key_state_back_h),
       .key_state_back_l(key_state_back_l),
       .key_state_left_h(key_state_left_h),
       .key_state_left_l(key_state_left_l),
       .key_state_right_h(key_state_right_h),
       .key_state_right_l(key_state_right_l),
       .pwm_tire(pwm_tire)
);



power_in power_in_inst1( 
    .clk(clk),
	.rst_n(rst_n),
    .key_state_up(key_state_forward_h | key_state_forward_l),
    .key_state_down(key_state_back_h | key_state_back_l),
    .key_state_left(key_state_left_h | key_state_left_l),
    .key_state_right(key_state_right_l | key_state_right_h),
	.in1(in1_left),
	.in2(in2_left)
    );


power_in power_in_inst2( 
    .clk(clk),
	.rst_n(rst_n),
    .key_state_up(key_state_forward_h | key_state_forward_l),
    .key_state_down(key_state_back_h | key_state_back_l),
    .key_state_left(key_state_right_l | key_state_right_h),
    .key_state_right(key_state_left_h | key_state_left_l),
	.in1(in1_right),
	.in2(in2_right)
    );
endmodule















