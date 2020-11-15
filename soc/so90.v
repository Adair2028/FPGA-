module so90( clk,
	rst_n,
	po_data,
	rx_down,
	pwm1,
	pwm2
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output pwm1;
output pwm2;	

wire key_flag1;	
wire key_flag2;

So90_1  So90_1_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag1),
	.pwm(pwm1)
    );
 
So90_2  So90_2_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag2),
	.pwm(pwm2)
    );
	
power_so90  power_so90_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.key_flag1(key_flag1),
	.key_flag2(key_flag2)
    );


endmodule
