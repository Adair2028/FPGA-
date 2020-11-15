module power_pwm( clk,
      rst_n,
      s,
      eoc,
      dout,
      key_state_s,
      key_state_forward_h,
      key_state_forward_l,
      key_state_back_h,
      key_state_back_l,
      key_state_left_h,
      key_state_left_l,
      key_state_right_h,
      key_state_right_l


);
input clk;
input rst_n;
input [2:0]s;
input eoc;
input [7:0]dout;
output reg key_state_s;
output reg key_state_forward_h;
output reg key_state_forward_l;
output reg key_state_back_h   ;
output reg key_state_back_l   ;
output reg key_state_left_h   ;
output reg key_state_left_l   ;
output reg key_state_right_h  ;
output reg key_state_right_l  ;


reg [7:0]dout_x;
reg [7:0]dout_y;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        dout_x <= 0;
    else if(eoc  && s == 3'b001)
        dout_x <= dout;
    else 
        dout_x <= dout_x;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        dout_y <= 0;
    else if(eoc  && s == 3'b010)
        dout_y <= dout;
    else 
        dout_y <= dout_y;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_s <= 0;
    else if(dout_x >= 100  && dout_x < 150 && dout_y >= 100  && dout_y < 150)
        key_state_s <= 1;
    else 
        key_state_s<= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_forward_h <= 0;
    else if(dout_x < 20)
        key_state_forward_h <= 1;
    else 
        key_state_forward_h <= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_forward_l <= 0;
    else if(dout_x >= 20  && dout_x < 100)
        key_state_forward_l <= 1;
    else 
        key_state_forward_l <= 0;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_back_h <= 0;
    else if(dout_x > 240)
        key_state_back_h <= 1;
    else 
        key_state_back_h <= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_back_l <= 0;
    else if(dout_x >= 150  &&  dout_x <= 240)
        key_state_back_l <= 1;
    else 
        key_state_back_l <= 0;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_left_h <= 0;
    else if(dout_y < 20)
        key_state_left_h <= 1;
    else 
        key_state_left_h <= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_left_l <= 0;
    else if(dout_y >= 20 && dout_y < 100)
        key_state_left_l <= 1;
    else 
        key_state_left_l <= 0;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_right_h <= 0;
    else if(dout_y > 240)
        key_state_right_h <= 1;
    else 
        key_state_right_h <= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        key_state_right_l <= 0;
    else if(dout_y >= 150  &&  dout_y <= 240)
        key_state_right_l <= 1;
    else 
        key_state_right_l <= 0;
endmodule
