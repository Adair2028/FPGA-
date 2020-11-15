module bb( 
    clk,
    rst_n,
    po_data,
    rx_down,
    line_tx,
    led
    );

    input clk;
    input rst_n;
    input [7:0]po_data;
    input rx_down;
    output reg line_tx;
    output led;

wire key_flag;

wire key_flag_nh;
wire key_flag_ly;
wire key_flag_bc;
wire key_flag_open;
wire key_flag_close;

wire line_tx_nh;
wire line_tx_ly;
wire line_tx_bc;
wire line_tx_open;
wire line_tx_close;

wire en_nh;
wire en_ly;
wire en_bc;
wire en_open;
wire en_close;


always @(*)
    if(en_nh)
        line_tx <= line_tx_nh;
    else if(en_ly)
        line_tx <= line_tx_ly;
    else if(en_bc)
        line_tx <= line_tx_bc;
    else if(en_open)
        line_tx <= line_tx_open;
    else if(en_close)
        line_tx <= line_tx_close;
    else 
        line_tx <= 1;
        
power_bb_voice  power_bb_voice_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
    .key_flag1(key_flag_ly),   //
    .key_flag2(key_flag_bc),   //
    .led(led)
    );


power_bb  power_bb_inst( 
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
	.key_flag(key_flag_nh)   //
    );


power_voice_wc  power_voice_wc_inst(
    .clk(clk),
	.rst_n(rst_n),
	.po_data(po_data),
	.rx_down(rx_down),
    .key_flag(key_flag),
	.en_choice_wc()
    );

power_bb_wc  power_bb_wc_inst( 
       .clk(clk),
       .rst_n(rst_n),
       .key_flag(key_flag),
       .key_flag1(key_flag_open),//
       .key_flag2(key_flag_close)   //
       );

uart_tx_bb    uart_tx_bb_inst1( 
    .clk(clk),
	.rst_n(rst_n),
    .data_in(16'b0000_0101_1011_1000),
	.key_flag(key_flag_nh),
	.line_tx(line_tx_nh),
	.en(en_nh)
    );

uart_tx_bb    uart_tx_bb_inst2( 
    .clk(clk),
	.rst_n(rst_n),
    .data_in(16'b0000_0011_1011_0110),
	.key_flag(key_flag_ly),
	.line_tx(line_tx_ly),
	.en(en_ly)
    );

uart_tx_bb    uart_tx_bb_inst3( 
    .clk(clk),
	.rst_n(rst_n),
    .data_in(16'b0000_0100_1011_0111),
	.key_flag(key_flag_bc),
	.line_tx(line_tx_bc),
	.en(en_bc)
    );

uart_tx_bb    uart_tx_bb_inst4( 
    .clk(clk),
	.rst_n(rst_n),
    .data_in(16'b0000_0010_1011_0101),
	.key_flag(key_flag_open),
	.line_tx(line_tx_open),
	.en(en_open)
    );

uart_tx_bb    uart_tx_bb_inst5( 
    .clk(clk),
	.rst_n(rst_n),
    .data_in(16'b0000_0001_1011_0100),
	.key_flag(key_flag_close),
	.line_tx(line_tx_close),
	.en(en_close)
    );

endmodule
