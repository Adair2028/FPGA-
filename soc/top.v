module top( 

    input 	wire 		clk_24m,	
	input 	wire 		rst_n,		
	//camera	
	input 	wire 		cam_pclk,	
	output 	wire 		cam_xclk,	
	input 	wire 		cam_href,	
	input 	wire 		cam_vsync,	
	output 	wire 		cam_pwdn,	
	output 	wire 		cam_rst,	
	output 	wire 		cam_soic,	
	inout 	wire 		cam_soid,	
	input 	wire [7:0]	cam_data,	
	//vga
	output 	wire [7:0] 	vga_r,
	output 	wire [7:0] 	vga_g,
	output 	wire [7:0] 	vga_b,
	output 	wire 		vga_clk,
	output 	wire 		vga_hsync,
	output 	wire 		vga_vsync,
    output  wire        led

);



 test_camera
(
    .clk_24m  (clk_24m),	
	.rst_n    (rst_n),		
		
	.cam_pclk (cam_pclk),	
	.cam_xclk (cam_xclk),	
	.cam_href (cam_href),	
	.cam_vsync(cam_vsync),	
	.cam_pwdn (cam_pwdn),	
	.cam_rst  (cam_rst),	
	.cam_soic (cam_soic),	
	.cam_soid (cam_soid),	
	.cam_data (cam_data),	

	.vga_r    (vga_r),
 	.vga_g    (vga_g),
	.vga_b    (vga_b),
	.vga_clk  (vga_clk),
	.vga_hsync(vga_hsync),
    .vga_vsync(vga_vsync),
    .led      (led)
 );



endmodule
