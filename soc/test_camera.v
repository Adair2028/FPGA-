`timescale 1ns/ 1ps
// --------------------------------------------------------------------
// >>>>>>>>>>>>>>>>>>>>>>>>> COPYRIGHT NOTICE <<<<<<<<<<<<<<<<<<<<<<<<<
// --------------------------------------------------------------------
// 
// Author: Anlogic
// 
// Description:
//
//		dvp_ov2640,摄像头VGA显示
// 
// Web: www.anlogic.com
// --------------------------------------------------------------------
module test_camera
(
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
	output 	wire [7:0] 	vga_r    ,
	output 	wire [7:0] 	vga_g    ,
	output 	wire [7:0] 	vga_b    ,
	output 	wire 		vga_clk  ,
	output 	wire 		vga_hsync,
	output 	wire 		vga_vsync,
    
    
    input   wire        key1     ,
    input   wire        RS232_RX ,
    output  wire        rs232_tx ,
    
    input   wire        RS_RX, 

    output  wire        key_flag_me_video,
    output  wire        key_flag_me_t,
    input   wire        en_video     ,
    output  wire         ledx,
    output  wire         led_me,
    output            led_video
 );
	 
wire 		clk_lcd;
wire 		clk_cam;  
wire 		clk_sccb;

wire        camera_wrreq;
wire        camera_wclk;
wire [15:0] camera_wrdat;
wire [19:0] camera_addr;


reg 		init_state;
wire 		init_ready;
wire 		sda_oe;
wire 		sda;
wire 		sda_in;
wire 		scl;

//lcd display
wire [11:0] cnt_h;
wire [11:0] cnt_v;

wire 		vga_rden;

wire [15:0]	rgb_cam ;	//lcd read
wire [15:0]	cam_addr;

wire [7:0]  num_addr;
wire [31:0] num_data ;

wire [8:0]  shuzi_addr;
wire [15:0] shuzi_data ;

wire [6:0]  heart_addr  ;
wire [31:0] heart_data ;

wire [6:0]  temp_addr  ;
wire [31:0] temp_data  ;

wire [6:0]  blood_addr  ;
wire [31:0] blood_data  ;

wire [5:0]  cifen_addr  ;
wire [31:0] cifen_data  ;

wire [6:0]  dian_addr  ;
wire [15:0] dian_data  ;


assign cam_soid = (sda_oe == 1'b1) ? sda : 1'bz;
assign sda_in 	= cam_soid;
assign cam_soic = scl;
assign cam_pwdn = 1'b0;
assign cam_rst 	= rst_n;

assign vga_clk = clk_lcd ;

//


wire [3:0]  H1 ;
wire [3:0]  H2 ;
wire [3:0]  H3 ;
wire [3:0]  H4 ;
wire [3:0]  H5 ;
wire [3:0]  H6 ;
wire [3:0]  H7 ;
wire [3:0]  H8 ;
wire [3:0]  H9 ;
wire [3:0]  H10;

wire [3:0] qian ;
wire [3:0] bai  ;
wire [3:0] shi  ;
wire [3:0] ge   ;





wire vga_den;
wire vga_pwm;	//backlight,set to high
  
ip_pll u_pll(
	.refclk(clk_24m),		//24M
	.clk0_out(clk_lcd),		//lcd clk
	.clk1_out(clk_cam),		//12m,for cam xclk
	.clk2_out(clk_sccb)		//4m,for sccb init
);

pll_2 u_pll_2(
       .refclk (clk_24m),
	   .reset  (1'b0),
	   .clk0_out(clk_50m)
);

camera_init u_camera_init
(
	.clk(clk_sccb),
	.reset_n(rst_n),
	.ready(init_ready),
	.sda_oe(sda_oe),
	.sda(sda),
	.sda_in(sda_in),
	.scl(scl)
);
	

wire color_zone;
camera_reader u_camera_reader
(
	.clk		(clk_cam		),
	.reset_n	(rst_n			),
	.csi_xclk	(cam_xclk		),
	.csi_pclk	(cam_pclk		),
	.csi_data	(cam_data		),
	.csi_vsync	(!cam_vsync		),
	.csi_hsync	(cam_href		),
	.data_out	(camera_wrdat	),
	.wrreq		(camera_wrreq	),
	.wrclk		(camera_wclk	),
	.wraddr		(camera_addr	)
);  

judge u_judge(
   .clk(clk_24m)   ,
   .rst_n(rst_n & en_video),
   .ledx(ledx)     ,
   .flag(key_flag_me_video),
   .led(led_video)
);


img_cache u_img 
( 
	//write 45000*8
	.dia		(camera_wrdat   ), 
	.addra		(camera_addr	), 
	.cea		(camera_wrreq	), 
	.clka		(camera_wclk	), 
	.rsta		(!rst_n			), 
	//read 22500*16
	.dob		(rgb_cam		), 
	.addrb		(cam_addr		), 
	.ceb		(vga_rden   	),
	.clkb		(clk_lcd		), 
	.rstb		(!rst_n			)
);


box u_box(
  .clk            (camera_wclk ),
  .rst_n          (rst_n       ),
  .per_frame_clken(camera_wrreq),
  .img_data       (rgb_cam     ),
  .post_img_Y     (color_zone  )      
);



vga u_vga(
     .sclk(clk_lcd),
	 .rst_n(rst_n),
	 .cnt_h(cnt_h),
     .cnt_v(cnt_v),
	 .vga_hs(vga_hsync),
	 .vga_vs(vga_vsync)
    );	
	
	   
rgb u_rgb(
     .sclk        (clk_lcd),
	 .rst_n       (rst_n),
     .cnt_h       (cnt_h),
	 .cnt_v       (cnt_v),
	 .vga_red     (vga_r),
	 .vga_bule    (vga_b), 
	 .vga_green   (vga_g),
	 
	 
	 .color_zone (color_zone),
     .rgb_cam    (rgb_cam),  
     .cam_addr   (cam_addr),
     
     .num_data   (num_data),
     .num_addr   (num_addr),
     
     .shuzi_data   (shuzi_data),
     .shuzi_addr   (shuzi_addr),
     
     .heart_data   (heart_data),
     .heart_addr   (heart_addr),
     
     .temp_data   (temp_data),
     .temp_addr   (temp_addr),
     
     .blood_data   (blood_data),
     .blood_addr   (blood_addr),
     
     .cifen_data   (cifen_data),
     .cifen_addr   (cifen_addr),
     
     .dian_data   (dian_data),
     .dian_addr   (dian_addr),
     
     .led          (ledx),
     
     .vga_rden     (vga_rden),
     
    .H1      (H1),
    .H2      (H2),
    .H3      (H3),
    .H4      (H4),
    .H5      (H5),
    .H6      (H6),
    .H7      (H7),
    .H8      (H8),
    .H9      (H9),
    .H10     (H10),
    
    .qian    (qian),
    .bai     (bai),
    .shi     (shi),
    .ge      (ge)  
     
     
     
    );
	
	
	
top_p u_top_p(

    .clk_24m  (clk_24m),
    .rst_n    (rst_n),
    
    .key1     (key1),
    .RS232_RX (RS232_RX),
    .rs232_tx(rs232_tx),
 
    .H1      (H1),
    .H2      (H2),
    .H3      (H3),
    .H4      (H4),
    .H5      (H5),
    .H6      (H6),
    .H7      (H7),
    .H8      (H8),
    .H9      (H9),
    .H10     (H10)

  );
	
	
hongwai_top u_hongwai_top(
    .clk_24m  (clk_24m),
    .rst_n    (rst_n  ),
    .RS232_RX (RS_RX  ),
    .qian     (qian   ),
    .bai      (bai    ),
    .shi      (shi    ),
    .ge       (ge     )  
    );	
	
	
gsm_en_t  gsm_en_t_inst( 
       .clk(clk_24m),
       .rst_n(rst_n),
       .qian(qian),
       .bai(bai),
       .key_flag_me_t(key_flag_me_t),
       .led(led_me)
);
	
	
	
	
	
/***********************************************************************************************************/
/***********************************************************************************************************/
      













	


rom_shinei u_rom_shinei(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(num_data), 
 .raddr(num_addr) 
 );
 
rom_blood u_rom_blood(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(blood_data), 
 .raddr(blood_addr) 
 ); 
 
rom u_rom(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(heart_data), 
 .raddr(heart_addr) 
 );

rom_temp u_rom_temp(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(temp_data), 
 .raddr(temp_addr) 
 );
 
 rom_dian u_rom_dian(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(dian_data), 
 .raddr(dian_addr) 
 );
 
  rom_cifen u_rom_cifen(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(cifen_data), 
 .raddr(cifen_addr) 
 );

rom_shuzi u_rom_shuzi( 
     .doa(shuzi_data),
     .addra(shuzi_addr),
     .clka(clk_lcd),
     .rsta(~rst_n) 
);	

	
endmodule


	

/*rom_shuzi1 u_rom_shuzi1(
 .di(1'd0), 
 .waddr(1'd0), 
 .we(1'd0), 
 .wclk(clk_lcd), 
 .do(shuzi_data), 
 .raddr(shuzi_addr) 
 );*/