module hongwai_top(
   input clk_24m,
   input RS232_RX,
   input rst_n,
  
   output [3:0] qian,
   output [3:0] bai ,
   output [3:0] shi ,
   output [3:0] ge  
    );
	 
	 
    wire [7:0] data_Byte;
    wire Rx_done;
    wire [15:0] tiwen;
    wire [19:0] data_o;	   
    

 
  ip_pllz u_ip_pllz(
    .refclk  (clk_24m),
	.reset   (1'b0),
	.clk0_out(clk)
	
); 
 
 
 rx_content  rx_content_2(
   .clk(clk),
   .rst_n(rst_n),
   .data_Byte(data_Byte),
   .Rx_done(Rx_done),
   .tiwen(tiwen)
  
 );
 Rx Rx_3(
   .clk(clk),
   .rst_n(rst_n),
   .RS232_RX(RS232_RX),
   .data_Byte(data_Byte),
   .Rx_done(Rx_done)

 );
 
 

 bin2bcd1 bin2bcd_5(
   .clk(clk),
   .rst_n(rst_n),
   .data_i(tiwen),
   .qian(qian),
   .bai(bai),
   .shi(shi),
   .ge(ge)
 );
 
endmodule





