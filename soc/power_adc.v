module power_adc(clk,
       rst_n,
       eoc,
       soc,
       pd,
       s


);

input clk;
input rst_n;
input eoc;
output  soc;
output  pd;
output reg [2:0]s;

reg [1:0]count;
reg [2:0]cnt;
reg state;



always @(posedge clk or negedge rst_n)
    if(!rst_n)
        state <= 0;
    else if(eoc)
        state <= ~state;
    else 
        state <= state;
        
always @(*)
    case(state)
        0:s <= 3'b001;
        1:s <= 3'b010;
    default:;
    endcase
        
always @(negedge  clk or negedge rst_n)
    if(!rst_n)
        count <= 0;
    else if(count == 3)
        count <= 3;
    else
        count <= count + 1'b1;

assign soc = (count == 3)?1'b1:1'b0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt <= 0;
    else if(cnt == 7)
        cnt <= cnt;
    else if(count >= 2)
        cnt <= cnt + 1'b1;
    else 
        cnt <= cnt;

assign pd = (cnt >= 1 && cnt <= 4)?1'b1:1'b0;

endmodule
