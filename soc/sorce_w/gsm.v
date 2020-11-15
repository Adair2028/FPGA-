module gsm( clk,
	rst_n,
	po_data,
	rx_down,
	po_data_ly,
	rx_down_ly,
	key_flag_me_t,
    key_flag_me_video,
	line_tx
    );

input clk;
input rst_n;
input [7:0]po_data;
input rx_down;
input [7:0]po_data_ly;
input rx_down_ly;
input key_flag_me_t;
input key_flag_me_video;
output reg line_tx;

wire key_flag1;
wire key_flag2;
wire [87:0]telephone;

wire key_flag_me_water;


wire line_tx_te;

wire line_tx_me_water;
wire en_choice_water;

wire line_tx_me_t;
wire en_choice_t;

wire line_tx_me_video;
wire en_choice_video;

//assign line_tx = (en_choice_water)?line_tx_me_water:line_tx_te;

always @(*)
    if(en_choice_water)
	    line_tx <= line_tx_me_water;
	else if(en_choice_t)
	    line_tx <= line_tx_me_t;
	else if(en_choice_video)
	    line_tx <= line_tx_me_video;
	else 
	    line_tx <= line_tx_te;

power_te  power_te_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.key_flag1(key_flag1),
	.key_flag2(key_flag2),
	.telephone(telephone)
    );
	
rx_power_ly  rx_power_ly_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data_ly),
	.rx_down(rx_down_ly),
	.key_flag(key_flag_me_water)
    );
	
gsm_te  gsm_te_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.key_flag1(key_flag1),
	.key_flag2(key_flag2),
	.telephone(telephone),
	.line_tx(line_tx_te)
    );

	
gsm_me  gsm_me_water_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag_me_water),
	.line_tx(line_tx_me_water),
	.en_choice(en_choice_water)
    );
	
	
gsm_me_t  gsm_me_t_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag_me_t),
	.line_tx(line_tx_me_t),
	.en_choice(en_choice_t)
    );
	
	
gsm_me_video  gsm_me_video_inst(
    .clk(clk),
	.rst_n(rst_n),
	.key_flag(key_flag_me_video),
	.line_tx(line_tx_me_video),
	.en_choice(en_choice_video)
    );
endmodule
