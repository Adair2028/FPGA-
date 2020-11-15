module power_in( clk,
	rst_n,
    key_state_up,
    key_state_down,
    key_state_left,
    key_state_right,
	in1,
	in2
    );

input clk ;
input rst_n;
input key_state_up;
input key_state_down;
input key_state_left;
input key_state_right;
output reg in1;
output reg in2;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
    begin
        in1 <= 0;
        in2 <= 0;
    end
    else if(key_state_up)
    begin 
        in1 <= 1;
        in2 <= 0;
    end
    else if(key_state_right)
    begin 
        in1 <= 1;
        in2 <= 0;
    end
    else if(key_state_down)
    begin
        in1 <= 0;
        in2 <= 1;
    end
    else if(key_state_left)
    begin
        in1 <= 0;
        in2 <= 0;
    end
    else 
    begin
       in1 <= 0;
        in2 <= 0; 
    end

endmodule
