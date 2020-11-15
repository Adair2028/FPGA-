module judge(
  clk   ,
  rst_n ,
  ledx  ,
  flag  ,
  led
);

input  clk  ;
input  rst_n;
input  ledx ;


output   flag ;
output   reg led;


reg temp1;
reg temp2;
reg [27:0]cnt;
reg en_me_t;
reg [3:0]count;

assign flag = temp1 & (~temp2);

always @(posedge clk)
    temp1 <= en_me_t;
always @(posedge clk)
    temp2 <= temp1;


always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if(ledx == 1'b0)
        if(cnt == 23999999)
            cnt <= 0;
        else 
            cnt <= cnt +1'b1;
    else 
        cnt <= 0;
       
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        count <= 0;
    else if(ledx == 1'b0)
        if(count == 4)
            count <= count;
        else if(cnt == 23999999)
            count <= count + 1'b1;
        else 
            count <= count;     
    else 
        count <= 0;
        
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        en_me_t <= 0;
    else if(count == 4)
        en_me_t <= 1;
    else 
        en_me_t <= 0; 
         
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        led <= 1;
    else if(flag)
        led <= 0;
    else 
        led <= led;         
endmodule
