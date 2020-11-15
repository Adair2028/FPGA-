module rx(
input clk,
input rst_n,
input RS232_RX,
output reg [7:0] data_Byte,
output reg Rx_done
    );
reg [2:0] START_BIT;
reg [2:0] STOP_BIT;	
reg s0_Rs232_Rx,s1_Rs232_Rx;//同步寄存�?
reg tmp0_Rs232_Rx,tmp1_Rs232_RX;//异步寄存�?
reg uart_state;
//同步寄存器，阻止亚稳态的传播�?
always @(posedge clk or negedge rst_n)begin
 if(!rst_n)begin
   s0_Rs232_Rx <= 1'b0;
   s1_Rs232_Rx <= 1'b0;
 end
 else begin
   s0_Rs232_Rx <= RS232_RX;
   s1_Rs232_Rx <= s0_Rs232_Rx;
 end
end

//数据寄存�?
always @(posedge clk or negedge rst_n)begin
  if(!rst_n)begin
     tmp0_Rs232_Rx <= 1'b0;
     tmp1_Rs232_RX <= 1'b0;
  end
  else begin
     tmp0_Rs232_Rx <= s1_Rs232_Rx;
     tmp1_Rs232_RX <= tmp0_Rs232_Rx;
  end
end
wire nedge;
assign nedge = !tmp0_Rs232_Rx & tmp1_Rs232_RX;

parameter bps_DR = 16'd324;
reg [15:0] div_cnt;
reg bps_clk;

always @(posedge clk or negedge rst_n)begin
   if(!rst_n)
     uart_state <= 1'b0;
   else if (nedge) 
     uart_state <= 1'b1;
   else if(Rx_done) 	 
     uart_state <= 1'b0;    
end   
always @(posedge clk or negedge rst_n)begin     
  if(!rst_n)
    div_cnt <= 16'd0;
  else if(uart_state) begin
     if(div_cnt == bps_DR)
         div_cnt <= 16'd0;
     else
         div_cnt <= div_cnt + 1'b1;
  end
  else
     div_cnt <= 16'd0;
end
always @(posedge clk or negedge rst_n)begin
   if(!rst_n)
     bps_clk <= 1'b0;
   else if(div_cnt == 16'd1)
     bps_clk <= 1'b1;
   else
	 bps_clk <= 1'b0;
end	

reg [7:0] bps_cnt;
always @(posedge clk or negedge rst_n)begin
   if(!rst_n) 
      bps_cnt <= 8'd0;
   else if(bps_cnt == 8'd159 || (bps_cnt == 8'd12 && (START_BIT)>2))
      bps_cnt <= 8'd0;
   else if(bps_clk)
      bps_cnt <= bps_cnt + 1'b1;
end
always @(posedge clk or negedge rst_n)begin
   if(!rst_n)
      Rx_done <= 1'b0;
   else if(bps_cnt == 8'd159)
      Rx_done <= 1'b1;
   else
      Rx_done <= 1'b0;      
end
reg [2:0] r_data_byte [7:0];  
always @(posedge clk or negedge rst_n)begin
  if(!rst_n)begin
      START_BIT <= 3'd0;
  	  r_data_byte[0] <= 3'd0;    r_data_byte[1] <= 3'd0;
	  r_data_byte[2] <= 3'd0;    r_data_byte[3] <= 3'd0; 
	  r_data_byte[4] <= 3'd0;    r_data_byte[5] <= 3'd0;  
	  r_data_byte[6] <= 3'd0;    r_data_byte[7] <= 3'd0;
  end	  
  else if(bps_clk)begin
      case (bps_cnt) 
        0 : begin    
                   START_BIT <= 3'd0;
                   r_data_byte[0] <= 3'd0;   
                   r_data_byte[1] <= 3'd0; 
	               r_data_byte[2] <= 3'd0;    
				   r_data_byte[3] <= 3'd0;	   
				   r_data_byte[4] <= 3'd0;	   
				   r_data_byte[5] <= 3'd0;	   
				   r_data_byte[6] <= 3'd0;	   
				   r_data_byte[7] <= 3'd0;
                   STOP_BIT <= 3'd0;   				   
			end		   
		6,7,8,9,10,11:START_BIT <= START_BIT + s1_Rs232_Rx;			   
		22,23,24,25,26,27:r_data_byte[0] <= r_data_byte[0] + s1_Rs232_Rx;			   
		38,39,40,41,42,43:r_data_byte[1] <= r_data_byte[1] + s1_Rs232_Rx;			   
		54,55,56,57,58,59:r_data_byte[2] <= r_data_byte[2] + s1_Rs232_Rx;			   
		70,71,72,73,74,75:r_data_byte[3] <= r_data_byte[3] + s1_Rs232_Rx;			   
		86,87,88,89,90,91:r_data_byte[4] <= r_data_byte[4] + s1_Rs232_Rx;			   
		102,103,104,105,106,107:r_data_byte[5] <= r_data_byte[5] + s1_Rs232_Rx; 			   
		118,119,120,121,122,123:r_data_byte[6] <= r_data_byte[6] + s1_Rs232_Rx; 			   
		134,135,136,137,138,139:r_data_byte[7] <= r_data_byte[7] + s1_Rs232_Rx;
        150,151,152,153,154,155:STOP_BIT <= STOP_BIT + s1_Rs232_Rx;
        default : 
             begin
			         START_BIT <= START_BIT;
					 r_data_byte[0] <= r_data_byte[0]; 
					 r_data_byte[1] <= r_data_byte[1];
					 r_data_byte[2] <= r_data_byte[2];
					 r_data_byte[3] <= r_data_byte[3];
					 r_data_byte[4] <= r_data_byte[4];
					 r_data_byte[5] <= r_data_byte[5];
					 r_data_byte[6] <= r_data_byte[6];
					 r_data_byte[7] <= r_data_byte[7];
                     STOP_BIT <= STOP_BIT;
             end
      endcase
  end	
end
always @(posedge clk or negedge rst_n)begin
  if(!rst_n)
    data_Byte <= 8'd0;
  else if(bps_cnt == 8'd159)begin
    data_Byte[0] <= r_data_byte[0][2];    
    data_Byte[1] <= r_data_byte[1][2];
    data_Byte[2] <= r_data_byte[2][2];
    data_Byte[3] <= r_data_byte[3][2];
    data_Byte[4] <= r_data_byte[4][2];
	data_Byte[5] <= r_data_byte[5][2];		         
	data_Byte[6] <= r_data_byte[6][2];		 
	data_Byte[7] <= r_data_byte[7][2];
  end
end 
endmodule
