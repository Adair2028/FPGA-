module bujindianji( clk,
	rst_n,
	po_data,
	rx_down,
	pul_ss,
	dir_ss,
	pul_sj,
	dir_sj
	
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
output  pul_ss;
output  dir_ss;
output  pul_sj;
output  dir_sj;


wire key_state1;
wire key_state2;
wire key_state3;
wire key_state4;

power  power_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
    .key_state1(key_state1),
    .key_state2(key_state2),
	.key_state3(key_state3),
	.key_state4(key_state4)
    );

bujindianji1  bujindianji1_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_state1(key_state3),    //ÉìËõ
	.key_state2(key_state4),
	.pul(pul_ss),
	.dir(dir_ss)
    );

	
bujindianji2  bujindianji2_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_state1(key_state1),
	.key_state2(key_state2),    //Éı½µ
	.pul(pul_sj),
	.dir(dir_sj)
    );

endmodule
