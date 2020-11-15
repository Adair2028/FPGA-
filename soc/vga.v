module vga(
     sclk,
	 rst_n,
	 cnt_h,
     cnt_v,
	 vga_hs,
	 vga_vs
    );
input sclk;
input rst_n;
output reg [11:0]cnt_h;
output reg [11:0]cnt_v;
output reg vga_hs;
output reg vga_vs;


parameter hy_all = 12'd1688,
          hy_a   = 12'd112,
		  hy_b   = 12'd248,
		  hy_c   = 12'd1280,
		  hy_d   = 12'd48,
			 
	      vy_all = 12'd1066,
		  vy_a   = 12'd3,
		  vy_b   = 12'd38,
	      vy_c   = 12'd1024,
		  vy_d   = 12'd1;






always@(posedge sclk or negedge rst_n)
 if(!rst_n)
   cnt_h <= 0;
 else if(cnt_h == (hy_all-1)) 
   cnt_h <= 0;
 else 
   cnt_h <= cnt_h+1'b1; 
	
always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  cnt_v <= 0;
 else if(cnt_v == (vy_all-1))
  cnt_v <= 0;
 else if(cnt_h == (hy_all-1))  
  cnt_v <= cnt_v+1'b1;

  
always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  vga_hs <= 1'b1;
 else if(cnt_h == 0)
  vga_hs <= 1'b0;
 else if(cnt_h == hy_a)  
  vga_hs <= 1'b1; 


always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  vga_vs <= 1'b1;
 else if(cnt_v == 0)
  vga_vs <= 1'b0;
 else if(cnt_v == vy_a)
  vga_vs <= 1'b1;
  
  

endmodule
