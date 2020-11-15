`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:57:03 10/21/2020 
// Design Name: 
// Module Name:    bin2bcd 
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
module	bin2bcds(

input [7:0]data_i,
output reg [3:0]data	
);

  always@(*)
begin
	case(data_i)
   'd47:     data<=4'b1011;
   
   'd48:     data<=4'b0000;
   'd49:     data<=4'b0001;
   'd50:     data<=4'b1001;
   'd51:     data<=4'b1001;
   'd52:     data<=4'b1001;
   'd53:     data<=4'b1001;
   'd54:     data<=4'b1001;
   'd55:     data<=4'b1001;
   'd56:     data<=4'b1001;
   'd57:     data<=4'b1001;
   
   'd58:     data<=4'b1010;
   
		
		default:   ;
	endcase
end
endmodule
