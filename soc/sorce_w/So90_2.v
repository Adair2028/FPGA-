module So90_2( clk,
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

always @(*)
    case(state)
	    0:if(cnt < 12000) pwm <= 1;else pwm <= 0;
		1:if(cnt < 36000) pwm <= 1;else pwm <= 0;
		default:if(cnt < 12000) pwm <= 1;else pwm <= 0;
	endcase
 
endmodule

