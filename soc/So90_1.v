module So90_1(clk,
	rst_n,
	key_flag,
	pwm
    );
	
	
input clk;
input rst_n;
input key_flag;
output  reg pwm;

reg [19:0]cnt;
reg [2:0]state;
reg [7:0]count;
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    cnt <= 0;
	else if(cnt == 479999)
	    cnt <= 0;
	else if(key_flag)
	    cnt <= 0;
	else 
	    cnt <= cnt + 1'b1;
		


always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    state <= 0;
	else if(key_flag)
	    if(state == 1)
	        state <= 0;
	    else 
	        state <= state + 1'b1;
	else 
	    state <= state;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        count <= 0;
    else if(key_flag)
        count <= 0;
    else if(count == 100)
        count <= count;
    else if(cnt == 479999)
        count <= count + 1'b1;
    else 
        count <= count;

always @(*)
    case(state)
	    0:if(count == 14)
              if(cnt < 53000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 16)
              if(cnt < 52000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 18)
              if(cnt < 51000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 20)
	          if(cnt < 50000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 22)
              if(cnt < 49000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 24)
              if(cnt < 48000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 26)
              if(cnt < 47000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 28)
              if(cnt < 46000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 30)
              if(cnt < 45000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 32)
              if(cnt < 44000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 34)
              if(cnt < 43000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 36)
	          if(cnt < 42000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 38)
              if(cnt < 41000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 40)
              if(cnt < 40000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 42)
              if(cnt < 39000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 44)
              if(cnt < 38000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 46)
              if(cnt < 37000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 48)
              if(cnt < 36000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 50)
	          if(cnt < 35000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 52)
              if(cnt < 34000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 54)
              if(cnt < 33000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 56)
              if(cnt < 32000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 58)
              if(cnt < 31000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 60)
              if(cnt < 30000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 62)
              if(cnt < 29000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 64)
              if(cnt < 28000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 66)
              if(cnt < 27000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 68)
	          if(cnt < 26000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 70)
              if(cnt < 25000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 72)
              if(cnt < 24000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 74)
              if(cnt < 23000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 76)
              if(cnt < 22000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 78)
              if(cnt < 21000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 80)
              if(cnt < 20000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 82)
              if(cnt < 19000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 84)
	          if(cnt < 18000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 86)
              if(cnt < 17000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 88)
              if(cnt < 16000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 90)
              if(cnt < 14000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 92)
              if(cnt < 13000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 94)
              if(cnt < 12800)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 96)
              if(cnt < 12600)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 98)
	          if(cnt < 12400)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 100)
	          if(cnt < 12000)
	              pwm <= 1;
	          else
	              pwm <= 0;
       1:if(count == 2)
	          if(cnt < 13000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 4)
              if(cnt < 14000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 6)
              if(cnt < 15000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 8)
              if(cnt < 16000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 10)
              if(cnt < 17000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 12)
              if(cnt < 18000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 14)
              if(cnt < 19000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 16)
              if(cnt < 20000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 18)
              if(cnt < 21000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 20)
	          if(cnt < 22000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 22)
              if(cnt < 23000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 24)
              if(cnt < 24000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 26)
              if(cnt < 25000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 28)
              if(cnt < 26000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 30)
              if(cnt < 27000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 32)
              if(cnt < 28000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 34)
              if(cnt < 29000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 36)
	          if(cnt < 30000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 38)
              if(cnt < 31000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 40)
              if(cnt < 32000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 42)
              if(cnt < 33000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 44)
              if(cnt < 34000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 46)
              if(cnt < 35000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 48)
              if(cnt < 36000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 50)
	          if(cnt < 37000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 52)
              if(cnt < 38000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 54)
              if(cnt < 39000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 56)
              if(cnt < 40000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 58)
              if(cnt < 41000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 60)
              if(cnt < 42000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 62)
              if(cnt < 43000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 64)
              if(cnt < 44000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 66)
              if(cnt < 45000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 68)
	          if(cnt < 46000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 70)
              if(cnt < 47000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 72)
              if(cnt < 48000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 74)
              if(cnt < 49000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 76)
              if(cnt < 50000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 78)
              if(cnt < 51000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 80)
              if(cnt < 52000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 82)
              if(cnt < 53000)
	              pwm <= 1;
	          else
	              pwm <= 0;
          else if(count == 84)
	          if(cnt < 54000)
	              pwm <= 1;
	          else
	              pwm <= 0;
		default:if(cnt < 12000) pwm <= 1;else pwm <= 0;
	endcase
 
endmodule

