module uart_tx_ly9( clk,
	rst_n,
	key_flag,
	line_tx
    );
    input clk;
	input rst_n;
	input key_flag;
	output reg line_tx;
	 
	 
parameter tx_start = 0,tx_stop = 1; 
reg [12:0] cnt;
reg clk_tx;
reg [3:0] cnt_tx;
reg en ;
reg [3:0]cnt_stop;
reg [7:0]data_tx ;



always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	 en <= 0;
	 else if(key_flag)
	 en <= 1;
	 else if(cnt_stop == 4)
	 en <= 0;
end

// 按键按下使能端打开，以及使能的停止


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	     cnt <= 0;
	 else if(en)
	 begin
	     if(cnt == 2499)
	         cnt <= 0;
	     else 
	         cnt <= cnt + 1'b1;
	 end
	 else 
	     cnt <= 0;
end
//分频计数

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	     clk_tx <= 0;
	 else if(cnt == 1)
	     clk_tx <= 1;
	 else 
	     clk_tx <= 0;
end
//分频时钟的产生

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	 begin
	     cnt_tx <= 0;
		  cnt_stop <= 0;
		  end
	 else if(en)
	 begin
	     if(cnt_tx == 11)
		  begin
	         cnt_tx <= 0;
				cnt_stop <= cnt_stop + 1'b1;
				end
	     else if(clk_tx)
	         cnt_tx <= cnt_tx + 1'b1;
	 end
	 else 
	 begin
	     cnt_tx <= 0;
		  cnt_stop <= 0;
		  end
end

//用来传输数据的计数

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	 data_tx <= 8'b1011_0101;
	 else if(en)
	 case(cnt_stop)
	 'd0:data_tx <= "O";	 
	 'd1:data_tx <= "1";
     'd2:data_tx <= "O";
     'd3:data_tx <= "0";	 
	 endcase
	 
end

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        line_tx <= 1;
	 else if(en)
	 case(cnt_tx)
	 'd0:line_tx <= 1;
	 'd1:line_tx <= tx_start;
	 'd2:line_tx <= data_tx[0];
	 'd3:line_tx <= data_tx[1];
	 'd4:line_tx <= data_tx[2];
	 'd5:line_tx <= data_tx[3];
	 'd6:line_tx <= data_tx[4];
	 'd7:line_tx <= data_tx[5];
	 'd8:line_tx <= data_tx[6];
	 'd9:line_tx <= data_tx[7];
	 'd10:line_tx <= tx_stop;
	 default:line_tx <= 1;
	 endcase
end

endmodule