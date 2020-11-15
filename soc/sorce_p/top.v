`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:47:11 10/21/2020 
// Design Name: 
// Module Name:    top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module top_p(

   input        clk_24m  ,
   input        rst_n    ,
   input        key1     ,
   input        RS232_RX ,
   
   output       rs232_tx,
   
   output [3:0] H1      ,
   output [3:0] H2      ,
   output [3:0] H3      ,
   output [3:0] H4      ,
   output [3:0] H5      ,
   output [3:0] H6      ,
   output [3:0] H7      ,
   output [3:0] H8      ,
   output [3:0] H9      ,
   output [3:0] H10     

  );
	   
	   
	   
	  wire       clk      ;		
	  wire [7:0] data_Byte; 
	  wire send_en        ;
      wire [7:0]data_byte ;
	  wire button_out    ;
      wire Rx_done       ;
      wire [7:0]rx_data1 ;
      wire [7:0]rx_data2 ;
      wire [7:0]rx_data3 ;
      wire [7:0]rx_data4 ;
      
      
      wire [7:0]rx_data5;
      wire [7:0]rx_data6;
      wire [7:0]rx_data_6;
      
      wire [7:0]rx_data7;
      wire [7:0]rx_data8;
      wire [7:0]rx_data9;
      
     
      wire button_negedge; 
      wire bt;
 
          
      
      
  ip_pllx u_pllx(
        .refclk(clk_24m),
		.reset (1'b0)   ,
		.clk0_out(clk)   	
		);      
      
  tx u_1(
    .clk(clk), 
    .rst_n(rst_n), 
    .data_byte(data_byte), 
    .send_en(send_en), 
    .rs232_tx(rs232_tx), 
    .uart_state(led),
	.baud_set(3'd0)
    );
	
 tx1 u_2(
    .clk(clk), 
    .rst_n(rst_n), 
    .button_out(button_out),
    .button_negedge(button_negedge),
    .data_1(data_byte), 
   
    .send_en_1(send_en)
    );
    
ax_debounce ax_debounce_3(
	.clk             (clk),
	.rst             (~rst_n),
	.button_in       (key1),
	.button_posedge  (),
	.button_negedge  (button_negedge),
	.button_out      (button_out)
);

rx rx_4(
   .clk(clk),
   .rst_n(rst_n),
   .RS232_RX(RS232_RX),
   .data_Byte(data_Byte),
   .Rx_done(Rx_done)
 );
  rx_content1 rx_content_5(
   .clk(clk),
   .rst_n(rst_n),
   .data_Byte(data_Byte),
   .Rx_done(Rx_done),
   .rx_data5(rx_data5),
   .rx_data6(rx_data6),
   .rx_data_6(rx_data_6),
   .bt(bt)
 );
  
  
  rx_content3 rx_content_7(
   .clk(clk),
   .rst_n(rst_n),
   .data_Byte(data_Byte),
   .Rx_done(Rx_done),
   
   .rx_data1(rx_data1),
   .rx_data2(rx_data2),
   .rx_data3(rx_data3),
   .rx_data4(rx_data4),
   
   
   .rx_data7(rx_data7),
   .rx_data8(rx_data8),
   .rx_data9(rx_data9)
  
  
 );
   rxbcd rxbcd_8(
   .rx_data1(rx_data1),
   .rx_data2(rx_data2),
   .rx_data3(rx_data3),
   .rx_data4(rx_data4),
   
   
   .rx_data5(rx_data5),
   .rx_data6(rx_data6),
   .rx_data_6(rx_data_6),
   
   .rx_data7(rx_data7),
   .rx_data8(rx_data8),
   .rx_data9(rx_data9),
   
   .H1(H1),
   .H2(H2),
   .H3(H3),
   .H4(H4),
   .H5(H5),
   .H6(H6),
   
   .H7(H7),
   .H8(H8),
   .H9(H9),
   .H10(H10)
   
   
 );
  
  




     
endmodule 