module pwm(  clk,
       rst_n,
       key_state_s,
       key_state_forward_h,
       key_state_forward_l,
       key_state_back_h,
       key_state_back_l,
       key_state_left_h,
       key_state_left_l,
       key_state_right_h,
       key_state_right_l,
       pwm_tire
 

);

input clk;
input rst_n;
input key_state_s;
input key_state_forward_h;
input key_state_forward_l;
input key_state_back_h;
input key_state_back_l;
input key_state_left_h;
input key_state_left_l;
input key_state_right_h;
input key_state_right_l;
output reg pwm_tire;

wire key_flag_forward_h;
wire key_flag_forward_l;

wire key_flag_back_h;
wire key_flag_back_l;

wire key_flag_left_h;
wire key_flag_left_l;

wire key_flag_right_h;
wire key_flag_right_l;

reg temp1,temp2;
reg temp3,temp4;

reg temp5,temp6;
reg temp7,temp8;

reg temp9,temp10;
reg temp11,temp12;

reg temp13,temp14;
reg temp15,temp16;

reg [24:0]cnt;
reg [1:0]state;
//forward
assign key_flag_forward_h = temp1 & (~temp2);
assign key_flag_forward_l = temp3 & (~temp4);

always @(posedge clk )
        temp1 <= key_state_forward_h;

always @(posedge clk )
        temp2 <= temp1;

always @(posedge clk )
        temp3 <= key_state_forward_l;

always @(posedge clk )
        temp4 <= temp3;

//back
assign key_flag_back_h = temp5 & (~temp6);
assign key_flag_back_l = temp7 & (~temp8);
always @(posedge clk )
        temp5 <= key_state_back_h;

always @(posedge clk )
        temp6 <= temp5;

always @(posedge clk )
        temp7 <= key_state_back_l;

always @(posedge clk )
        temp8 <= temp7;

//left
assign key_flag_left_h = temp9 & (~temp10);
assign key_flag_left_l = temp11 & (~temp12);
always @(posedge clk )
        temp9 <= key_state_left_h;

always @(posedge clk )
        temp10 <= temp9;

always @(posedge clk )
        temp11 <= key_state_left_l;

always @(posedge clk )
        temp12 <= temp11;


//right
assign key_flag_right_h = temp13 & (~temp14);
assign key_flag_right_l = temp15 & (~temp16);
always @(posedge clk )
        temp13 <= key_state_right_h;

always @(posedge clk )
        temp14 <= temp13;

always @(posedge clk )
        temp15 <= key_state_right_l;

always @(posedge clk )
        temp16 <= temp15;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        state <= 0;
    else if(key_state_s)
        state <= 0;
    else if(key_flag_forward_l || key_flag_back_l || key_flag_left_l || key_flag_right_l)
        state <= 2;
    else if(key_flag_forward_h || key_flag_back_h || key_flag_left_h || key_flag_right_h)
        state <= 1;
    else 
        state <= state;

        
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if(cnt == 4800 - 1)
        cnt <= 0; 
    else 
        cnt <= cnt + 1'b1;

       
always @(posedge clk)
    case(state)
        0:pwm_tire <= 0;
        1:pwm_tire <= 1;
        2:if(cnt < 2400 - 1)
		      pwm_tire <= 1;
		  else
              pwm_tire <= 0; 
     default:pwm_tire <= 0;
     endcase
		      
endmodule
