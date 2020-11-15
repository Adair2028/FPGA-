module xiaodou( clk,
		 rst_n,
		 key_in,
		 key_flag,
		 key_state
    );
       input clk;
		 input rst_n;
		 input key_in;
		 output reg key_flag;
		 output reg key_state;

wire pedge;
wire nedge;

reg [3:0]state_score;

reg key_temp0,key_temp1;
reg [19:0]cnt_score;
reg cnt_full;   
      //20ms计满；
reg en_cnt;  
        //计数器使能端；

localparam IDEL    = 4'b0001,
           FILTER0 = 4'b0010,
		     DOWN    = 4'b0100,
		     FILTER1 = 4'b1000;

always@(posedge clk or negedge rst_n) 
 begin
 if(!rst_n) begin
  key_temp0 <= 1'b0;
  key_temp1 <= 1'b0;
  end
 else begin
  key_temp0 <= key_in;
  key_temp1 <= key_temp0;
 end
 end
 
 assign nedge = (!key_temp0) & key_temp1;
 assign pedge = key_temp0 & (!key_temp1);
  
  
 
always@(posedge clk or negedge rst_n) begin
if(!rst_n)
begin
  cnt_score <= 0;
  cnt_full <= 0;
  end
  else if(en_cnt)
begin
 if(cnt_score == 20'd479999) begin
  cnt_score <= 20'd0;
  cnt_full <= 1'b1;
  end
 else 
  cnt_score <= cnt_score +1'b1;
 
 end
 else
 cnt_full <= 0;
 
 end
 
 
always@(posedge clk or negedge rst_n)
begin 
 if(!rst_n)
  begin
    key_state <= 0;
	 key_flag <= 1'b0;
	 state_score <= IDEL;
  end
  else begin
  case(state_score)
   IDEL:
	begin
    if(nedge) begin
    state_score <= FILTER0;
	 en_cnt <= 1'b1;
	 key_state <= 0;
	 end
	 else begin
	 state_score <= IDEL;
	 end
	end
   FILTER0:
    if(cnt_full) begin
     state_score <= DOWN; 
	 en_cnt <= 1'b0;
	 key_flag <= 1;
	 key_state <= ~key_in;
	end
	else begin
	 state_score <= FILTER0;
	 key_state <= 0;
    end 
   DOWN:
	begin
	 key_flag <= 0;
    if(pedge) begin
	 state_score <= FILTER1; 
     en_cnt <= 1'b1;
	 key_state <= 1;
	end
	else begin
	begin
	state_score <= DOWN;
	 end
	end
	end
   FILTER1: 
	if(cnt_full) begin
	 state_score <= IDEL;
	 en_cnt <= 1'b0;
	 key_state <= ~key_in;
	end
    else begin
	 state_score <= FILTER1;
	 key_state <= 1;
	end
   default:state_score <= IDEL;
   endcase
 end
end 
endmodule