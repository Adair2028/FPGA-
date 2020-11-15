module finally(
        clk,
        rst_n,

        cam_pclk , 
        cam_xclk , 
        cam_href  , 
        cam_vsync ,
        cam_pwdn  ,
        cam_rst  , 
        cam_soic  ,
        cam_soid  , 
        cam_data  ,
                  
        vga_r  ,   
        vga_g ,    
        vga_b  ,   
        vga_clk ,  
        vga_hsync, 
        vga_vsync ,
             
        rx_data ,     
        rx_data_voice,
        rx_data_ly,   
        pul_sj ,      
        dir_sj,       
        pul_sj2,      
        dir_sj2 ,     
        pul_ss,       
        dir_ss ,      
        led ,         
        led1 ,        
        line_tx_gsm , 
        line_tx_ly,   
        led3 ,        
        pwm1 ,        
        pwm2 ,        
        key_in1,      
        key_in2,      
        line_tx_bb,
	    led_bb,
        eoc,
        dout,
        pwm_tire,
        pwm_tire1,
        in1_left,
        in2_left,
        in1_right,
        in2_right , 
        
        
        key1     ,
        RS232_RX ,
        rs232_tx ,
        
        RS_RX    ,
        ledx     ,
        led_me   ,
        led_video
);

input 	wire 		clk      ;   
input 	wire 		rst_n    ;	   
	                   
input 	wire 		cam_pclk ;   
output 	wire 		cam_xclk ;   
input 	wire 		cam_href ;   
input 	wire 		cam_vsync;   
output 	wire 		cam_pwdn ;   
output 	wire 		cam_rst  ;   
output 	wire 		cam_soic ;   
inout 	wire 		cam_soid ;   
input 	wire [7:0]	cam_data ;  
                        
output 	wire [7:0] 	vga_r    ;     
output 	wire [7:0] 	vga_g    ;     
output 	wire [7:0] 	vga_b    ;     
output 	wire 		vga_clk  ;   
output 	wire 		vga_hsync; 
output 	wire 		vga_vsync; 

output wire         ledx     ;


input   wire        rx_data  ;

input   wire        rx_data_voice;
input   wire        rx_data_ly   ;
output  wire        pul_sj       ;
output  wire        dir_sj       ;	
output  wire        pul_sj2      ;
output  wire        dir_sj2      ;
output  wire        pul_ss       ;
output  wire        dir_ss       ;
output  wire        led          ;
output  wire        led1         ;
output  wire        line_tx_gsm  ;
output  wire        line_tx_ly   ;
output  wire [1:0]  led3         ;
output  wire        pwm1         ;
output  wire        pwm2         ;
input   wire        key_in1      ;
input   wire        key_in2      ;
output  wire        line_tx_bb   ;
output  wire        led_bb       ;
//tires wire        
output  wire        eoc          ;
output  wire        [7:0]dout    ;
output  wire        pwm_tire     ;
output  wire        pwm_tire1    ;
output  wire        in1_left     ;
output  wire        in2_left     ;
output  wire        in1_right    ;
output  wire        in2_right    ;

input   wire        key1         ;
input   wire        RS232_RX     ;
output  wire        rs232_tx     ;

input   wire        RS_RX        ;
output              led_me       ;
output led_video;

wire        key_flag_me_video   ;
wire        key_flag_me_t       ;
wire        en_video            ;
test_camera u_test_camera(
	.clk_24m   (clk       ),	
	.rst_n     (rst_n     ),		
	
	.cam_pclk  (cam_pclk  ),	
	.cam_xclk  (cam_xclk  ),	
	.cam_href  (cam_href  ),	
	.cam_vsync (cam_vsync ),	
	.cam_pwdn  (cam_pwdn  ),	
	.cam_rst   (cam_rst   ),	
	.cam_soic  (cam_soic  ),	
	.cam_soid  (cam_soid  ),	
	.cam_data  (cam_data  ),	
	
	.vga_r     (vga_r     ),
	.vga_g     (vga_g     ),
	.vga_b     (vga_b     ),
	.vga_clk   (vga_clk   ),
	.vga_hsync (vga_hsync ),
	.vga_vsync (vga_vsync ),
    
    .key1      (key1    ),
    .RS232_RX  (RS232_RX),
    .rs232_tx  (rs232_tx),
    
    .ledx      (ledx)    ,
    
    .RS_RX     (RS_RX)   ,
    .key_flag_me_t(key_flag_me_t),
    .key_flag_me_video(key_flag_me_video),
    .en_video(en_video),
    .led_me(led_me),
    .led_video(led_video)
    
 );



top u_top(
    .clk          (clk          ),
	.rst_n        (rst_n        ),
	.rx_data      (rx_data      ),
	.rx_data_voice(rx_data_voice),
	.rx_data_ly   (rx_data_ly   ),
	.pul_sj       (pul_sj       ),
	.dir_sj       (dir_sj       ),
    .pul_sj2      (pul_sj2      ),
	.dir_sj2      (dir_sj2      ),
	.pul_ss       (pul_ss       ),
	.dir_ss       (dir_ss       ),
	.led          (led          ),
	.led1         (led1         ),
	.line_tx_gsm  (line_tx_gsm  ),
	.line_tx_ly   (line_tx_ly   ),
	.led3         (led3         ),
	.pwm1         (pwm1         ),
	.pwm2         (pwm2         ),
	.key_in1      (key_in1      ),
	.key_in2      (key_in2      ),
	.line_tx_bb   (line_tx_bb   ),
    .led_bb(led_bb),
    .eoc(eoc),
    .dout(dout),
    .pwm_tire(pwm_tire),
    .pwm_tire1(pwm_tire1),
    .in1_left(in1_left),
    .in2_left(in2_left),
    .in1_right(in1_right),
    .in2_right(in2_right),
    .key_flag_me_t(key_flag_me_t),
    .en_video(en_video),
    .key_flag_me_video(key_flag_me_video)
	//key_flag
    );
    
    
endmodule