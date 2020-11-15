module rx_content3(
 input clk,rst_n,
 input [7:0] data_Byte,
 input Rx_done,
 output reg [7:0]rx_data1,
 output reg [7:0]rx_data2,
 output reg [7:0]rx_data3,
 output reg [7:0]rx_data4,
 
 
 output reg [7:0]rx_data7,
 output reg [7:0]rx_data8,
 output reg [7:0]rx_data9
 
    );

 reg [10:0] cnt1;	

always@(posedge clk or negedge rst_n)
begin
      if(!rst_n)  
        begin  
           rx_data1<='d0;
           rx_data2<='d0;
           rx_data3<='d0;
	        rx_data4<='d0;  
           
           rx_data7<='d0;
           rx_data8<='d0;
           rx_data9<='d0;
	        cnt1 <= 'd0;
          
	      end
     else if(Rx_done)
     begin
          case(cnt1)
           0:begin
              if(data_Byte=="+")
                cnt1<='d1;
             end
           1:begin
              if(data_Byte=="H")
                cnt1<='d2;
              else if(data_Byte=="T")
                 cnt1<='d11;
             end
           2:begin
             if(data_Byte=="E")
                cnt1<='d3;
             end
           3:begin
             if(data_Byte=="A")
                cnt1<='d4;
             end
           4:begin
             if(data_Byte=="R")
                cnt1<='d5;
             end
           5:begin
             if(data_Byte=="T")
                cnt1<='d6;
             end
           6:begin
             if(data_Byte=="=")
                cnt1<='d7;
             end
           7:begin
             if(data_Byte=="N") begin
                cnt1<='d0;
                rx_data7<=8'd47;
                rx_data8<=8'd47;
                rx_data9<=8'd47;
                
             end
             else begin
                rx_data7<=data_Byte; 
                 cnt1<='d8;end
             end
           8:begin
                if(data_Byte==8'b00001101) begin
                    cnt1<='d0;
                    rx_data8<=8'd58; 
                    rx_data9<=8'd58; end
                else  begin
                  rx_data8<=data_Byte;
                    cnt1<='d9;     end
             end
           9:begin
              if(data_Byte==8'b00001101) begin
                cnt1<='d0;
                rx_data9<=8'd58;       end
               else  begin
                   rx_data9<=data_Byte;
                   cnt1<='d10;     end
             end
           10:begin
              if(data_Byte==8'b00001101)
                cnt1<='d0;
             end
             
           
           
           
           
           
           11:begin
             if(data_Byte=="=")
                cnt1<='d12;
             end
           12:begin
              rx_data1<=data_Byte;
              cnt1<='d13;
             end
           13:begin
              rx_data2<=data_Byte;
              cnt1<='d14;
             end
           14:begin
              if(data_Byte==".")
                cnt1<='d15;
             end
           15:begin
              rx_data3<=data_Byte;
              cnt1<='d16;
             end
           16:begin
              rx_data4<=data_Byte;
              cnt1<='d0;
             end
          
           default:     ;
         endcase
             
     end
    
end
endmodule 