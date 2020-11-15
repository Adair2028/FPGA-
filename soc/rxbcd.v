`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:19 10/21/2020 
// Design Name: 
// Module Name:    rxbcd 
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
module rxbcd(
    input  wire [7:0]rx_data1,
    input  wire [7:0]rx_data2,
    input  wire [7:0]rx_data3,
    input  wire [7:0]rx_data4,
    
    
    input  wire [7:0]rx_data5,
    input  wire [7:0]rx_data6,
    input  wire [7:0]rx_data_6,
    
    
    input  wire [7:0]rx_data7,
    input  wire [7:0]rx_data8,
    input  wire [7:0]rx_data9,
    
    
    output  [3:0]H1,
    output  [3:0]H2,
    output  [3:0]H3,
    output  [3:0]H4, 
    
    
    output  [3:0]H5,
    output  [3:0]H6,
    
    output  [3:0]H7,
    output  [3:0]H8,
    output  [3:0]H9,
    output  [3:0]H10
    
    );
  bin2bcd bin2bcd_1(
  
  .data_i(rx_data1),
  .data(H1)
  
);
   bin2bcd bin2bcd_2(
  
  .data_i(rx_data2),
  .data(H2)
  
);

 bin2bcd bin2bcd_3(
  
  .data_i(rx_data3),
  .data(H3)
  
);
 bin2bcd bin2bcd_4(
  
  .data_i(rx_data4),
  .data(H4)
  
);
 bin2bcds bin2bcds_5(
  
  .data_i(rx_data5),
  .data(H5)
  
);
 bin2bcd bin2bcd_6(
  
  .data_i(rx_data6),
  .data(H6)
  
);

 bin2bcd bin2bcd_7(
  
  .data_i(rx_data7),
  .data(H7)
  
);

 bin2bcd bin2bcd_8(
  
  .data_i(rx_data8),
  .data(H8)
  
);

 bin2bcd bin2bcd_9(
  
  .data_i(rx_data9),
  .data(H9)
  
);
bin2bcd bin2bcd_10(
  
  .data_i(rx_data_6),
  .data(H10)
  
);
endmodule
