module tx(
input clk, rst_n,
input [7:0] data_byte,
input[2:0] baud_set,
input send_en,
output reg rs232_tx,
output reg uart_state,
output reg tx_done//发送完成信号
);
     localparam start_bite=1'b0;
    localparam stop_bite=1'b1;

	 reg bps_clk;//波特率时钟
    reg  [15:0] div_cnt;//分频计数器
	reg  [25:0] bps_dr;//分频计数最大值
	reg  [3:0] bps_cnt;//波特率计数时钟
	reg  [7:0] r_data_byte;//寄存发送数据，保持发送数据时的稳定
  always@(posedge clk or negedge rst_n)
 begin 
	if(!rst_n)
	  uart_state <= 1'b0;//空闲状态
	else if(send_en)
		uart_state <= 1'b1;//发送状态
	else if(bps_cnt == 4'd11)//保证一个周期
			uart_state<= 1'b0;
	else
			uart_state<= uart_state;
	end
 always@(posedge clk or negedge rst_n)
 begin
	if(!rst_n)
	r_data_byte <=8'b0000_0000;
	else if(send_en)
	r_data_byte <= data_byte;
	else
	r_data_byte <= r_data_byte;	 
 end
	
	always@(posedge clk or negedge rst_n)
 begin
	if(!rst_n)
    bps_dr <= 16'd5207;
    else	
	begin
			case(baud_set)
			 0:bps_dr <= 16'd5207;
			 1:bps_dr <= 16'd2603;
			 2:bps_dr <= 16'd1301;
			 3:bps_dr <= 16'd867;
			 4:bps_dr<= 16'd433;
			 default: bps_dr <= 16'd5207;
				endcase
	
	 end 
  end
	
	
	
	
	//分频计数器
	always@(posedge clk or negedge rst_n)
	begin
	    if(!rst_n)
		 div_cnt <= 'd0;
		 else if(uart_state)
	 begin		 
		 if (div_cnt == bps_dr)//计数到最大值
		 div_cnt <= 'd0;
		 else
		 div_cnt <= div_cnt + 1'b1;
	 end  
	 else
		div_cnt <= 'd0;
	end
	//产生bps时钟
	always@(posedge clk or negedge rst_n)
	begin
	   if(!rst_n)
	   bps_clk <= 1'b0;
	   else if(div_cnt == 'd1)
	   bps_clk <= 1'b1;
	   else
	   bps_clk <= 1'b0;
	end
	//bps计数器
always@(posedge clk or negedge rst_n)
begin
	   if(!rst_n)
	   bps_cnt <= 4'd0;
	   else if(bps_cnt == 4'd11)
	    bps_cnt <= 4'd0;
		else if(bps_clk)
	   bps_cnt <= bps_cnt+1'b1;
	   else
	   bps_cnt <= bps_cnt;
	   
end


always@(posedge clk or negedge rst_n)
begin
	   if(!rst_n)
	   tx_done <= 1'b0;
	   else if (bps_cnt == 4'd11)
	   tx_done <= 1'b1;
	   else
	   tx_done <= 1'b0;
end

always@(posedge clk or negedge rst_n )
begin
	if(!rst_n)
	rs232_tx <= 1'b1;
	else
	begin 
		case(bps_cnt)
			0:rs232_tx <= 1'b1;
			1:rs232_tx <= start_bite;
			2:rs232_tx <= r_data_byte[0];
			3:rs232_tx <= r_data_byte[1];
			4:rs232_tx <= r_data_byte[2];
			5:rs232_tx <= r_data_byte[3];
			6:rs232_tx <= r_data_byte[4];
			7:rs232_tx <= r_data_byte[5];
			8:rs232_tx <= r_data_byte[6];
			9:rs232_tx <= r_data_byte[7];
			10:rs232_tx <= stop_bite;
			default: rs232_tx <= 1'b1;
		endcase
	end
 end
endmodule