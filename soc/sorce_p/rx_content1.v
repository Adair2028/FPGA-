module rx_content1(
 input clk,rst_n,
 input [7:0] data_Byte,
 input Rx_done,
 output reg [7:0]rx_data5,
 output reg [7:0]rx_data6,
 output reg [7:0]rx_data_6,
 output reg bt
 
    );

 reg [7:0] cnt1;	

always@(posedge clk or negedge rst_n)
begin
      if(!rst_n)  
        begin      
           rx_data5<='d0;
           rx_data6<='d0;
           rx_data_6<='d0;
	        cnt1 <= 'd0;
           bt<=0;
	      end
     else if(Rx_done)
     begin
          case(cnt1)
           0:begin
              if(data_Byte=="+")
                cnt1<='d1;
             end
           1:begin
              if(data_Byte=="S")
                cnt1<='d2;
             end
           2:begin
             if(data_Byte=="P")
                cnt1<='d3;
             end
           3:begin
             if(data_Byte=="O")
                cnt1<='d4;
             end
           4:begin
             if(data_Byte=="2")
                cnt1<='d5;
             end
           5:begin
             if(data_Byte=="=")
                cnt1<='d6;
             end
           6:begin
             if(data_Byte=="N") begin
                cnt1<='d0;
                rx_data5<=8'd47;
                rx_data6<=8'd47;
                rx_data_6<=8'd47;
                
             end
             else begin
                rx_data5<=data_Byte; 
                 cnt1<='d7;end
             end
           7:begin
                if(data_Byte==8'b00001101) begin
                    cnt1<='d0;
                    rx_data6<=8'd58; 
                    rx_data_6<=8'd58; end
                else  begin
                  rx_data6<=data_Byte;
                    cnt1<='d8;     end
             end
           8:begin
              if(data_Byte==8'b00001101) begin
                cnt1<='d0;
                rx_data_6<=8'd58; end
               else begin
               rx_data_6<=data_Byte;
              
                 cnt1<='d9;     end
             end
           
             
           
           9:begin
              if(data_Byte==8'b00001101)
                cnt1<='d0;
             end
          
           default:     ;
         endcase
             bt<=1;
     end
    
end
endmodule 