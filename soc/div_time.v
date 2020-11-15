module div_time(clk,
       rst_n,
       clk_1mhz
       );


input clk;
input rst_n;
output reg clk_1mhz;


parameter delay_cnt = 48;
reg [19:0]cnt;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if(cnt == delay_cnt - 1)
        cnt <= 0;
    else 
        cnt <= cnt + 1'b1;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        clk_1mhz <= 0;
    else if(cnt == delay_cnt - 1)
        clk_1mhz <= ~clk_1mhz;
    else 
        clk_1mhz <= clk_1mhz;


endmodule
