module box(
    input clk            ,
	input rst_n          ,
	input per_frame_clken,
	
	input [15:0] img_data,	
	output  post_img_Y
	
	);

   reg     color_zone;


    wire         post_frame_vsync;
	wire         post_frame_href;
	wire         post_frame_clken;
	
	reg	  [7:0 ]img_Y_r1;
	wire  [15:0]y;


	wire	[7:0]	per_img_red	;
    wire	[7:0]	per_img_green;
    wire	[7:0]	per_img_blue;
	
	assign  per_img_red		=	{img_data[15:11], img_data[13:11]};
    assign  per_img_green	=	{img_data[10:5], img_data[6:5]};	
    assign 	per_img_blue	=	{img_data[4:0], img_data[2:0]};	
	
	//Step 1
reg	[15:0]	img_red_r0,		img_red_r1,		img_red_r2;	
reg	[15:0]	img_green_r0,	img_green_r1,	img_green_r2; 
reg	[15:0]	img_blue_r0,	img_blue_r1,	img_blue_r2; 
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		img_red_r0		<=	0; 		
		img_red_r1		<=	0; 		
		img_red_r2		<=	0; 	
		img_green_r0	<=	0; 		
		img_green_r1	<=	0; 		
		img_green_r2	<=	0; 	
		img_blue_r0		<=	0; 		
		img_blue_r1		<=	0; 		
		img_blue_r2		<=	0; 			
		end
	else
		begin
		img_red_r0		<=	per_img_red 	* 	8'd77; 		
		img_red_r1		<=	per_img_red 	* 	8'd43; 	
		img_red_r2		<=	per_img_red 	* 	8'd128; 	
		
		img_green_r0	<=	per_img_green 	* 	8'd85; 
		img_green_r1	<=	per_img_green 	* 	8'd29; 		
		img_green_r2	<=	per_img_green 	* 	8'd107; 
		
		img_blue_r0		<=	per_img_blue 	* 	8'd150; 				
		img_blue_r1		<=	per_img_blue 	* 	8'd128; 			
		img_blue_r2		<=	per_img_blue 	* 	8'd21; 		
		end
end

//--------------------------------------------------
//Step 2
reg	[15:0]	img_Y_r0;	
reg	[15:0]	img_Cb_r0; 
reg	[15:0]	img_Cr_r0; 
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		img_Y_r0	<=	0; 		
		img_Cb_r0	<=	0; 		
		img_Cr_r0	<=	0; 	
		end
	else
		begin
		img_Y_r0	<=	img_red_r0 	+ 	img_green_r0 	+ 	img_blue_r0; 		
		img_Cb_r0	<=	img_blue_r1 - 	img_red_r1 		- 	img_green_r1	+	16'd32768; 		
		img_Cr_r0	<=	img_red_r2 	- 	img_green_r2 	- 	img_blue_r2		+	16'd32768; 		
		end
end

//--------------------------------------------------
//Step 3
//reg	[7:0]	img_Y_r1;	
reg	[7:0]	img_Cb_r1; 
reg	[7:0]	img_Cr_r1; 
reg [15:0]  y1;
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
		img_Y_r1	<=	0; 		
		img_Cb_r1	<=	0; 		
		img_Cr_r1	<=	0; 	
		y1      <=  0;
		end
	else
		begin
		img_Y_r1	<=	img_Y_r0[15:8];
		img_Cb_r1	<=	img_Cb_r0[15:8];
		img_Cr_r1	<=	img_Cr_r0[15:8]; 
		y1      <=  {img_Y_r0[15:11],img_Y_r0[15:10],img_Y_r0[15:11]};
		end
end

always@(posedge clk or negedge rst_n) begin
	    if(!rst_n) color_zone <= 0;
//		else if(img_Cb_r1 > 'd77 && img_Cb_r1 < 'd127 && img_Cr_r1 > 'd133 && img_Cr_r1 < 'd173) color_zone <= 1'b1;
		else if(img_Cb_r1 >= 'd100 && img_Cb_r1 <= 'd140 && img_Cr_r1 >= 'd130 && img_Cr_r1 <= 'd160) color_zone <= 1'b1;
		else color_zone <= 1'b0;
	end

//lag 3 clocks signal sync  
reg 	[3:0] 	per_frame_clken_r;

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)begin
		per_frame_clken_r <= 4'b0;
	end	
	else begin
		per_frame_clken_r <= {per_frame_clken_r [2:0], per_frame_clken};		
	end
end

assign post_frame_clken = per_frame_clken_r [3];



//wire	[7:0]	post_img_Y;	
wire	[7:0]	post_img_Cb; 
wire	[7:0]	post_img_Cr; 


//assign post_img_Y 	= 	color_zone;
assign	post_img_Y 	= color_zone;
assign	post_img_Cb =	post_frame_href ? img_Cb_r1: 8'd0;
assign	post_img_Cr = 	post_frame_href ? img_Cr_r1: 8'd0;
assign  y       =   post_frame_href ? y1   : 16'd0;

endmodule
