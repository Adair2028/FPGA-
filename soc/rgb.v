module rgb(
     sclk      ,
	 rst_n     ,
     cnt_h     ,
	 cnt_v     ,
	 vga_red   ,
	 vga_bule  ,
	 vga_green ,
	 
	 color_zone,
	 
	 rgb_cam   ,
	 cam_addr  ,
	 
	 num_data   ,
	 num_addr   ,
	 
	 shuzi_data   ,
	 shuzi_addr   ,
	 
	 heart_data   ,
	 heart_addr   ,
	 
	 temp_data    ,
	 temp_addr    ,
	 
	 blood_data   ,
	 blood_addr   ,
	 
	 cifen_data   ,
	 cifen_addr   ,
	 
	 dian_data    ,
	 dian_addr    ,
	 
	 led          ,
	 
	 vga_rden     ,
	 
	 
     H1           ,
     H2           ,
     H3           ,
     H4           ,
     H5           ,
     H6           ,
     H7           ,
     H8           ,
     H9           ,
     H10          ,
     
     qian         ,
     bai          ,
     shi          ,
     ge   	 
	 	       
    );
input sclk;
input rst_n;	 
input [11:0]cnt_h;
input [11:0]cnt_v;

input color_zone;

output reg [7:0]vga_red;
output reg [7:0]vga_bule;
output reg [7:0]vga_green;

input      [15:0]rgb_cam;
output reg [15:0]cam_addr;

input      [31:0]num_data;
output reg [7:0] num_addr;

input      [15:0]shuzi_data;
output reg [8:0] shuzi_addr;

input      [31:0]heart_data;
output reg [6:0] heart_addr;

input      [31:0]temp_data;
output reg [6:0] temp_addr;

input      [31:0]blood_data;
output reg [6:0] blood_addr;

input      [31:0]cifen_data;
output reg [5:0] cifen_addr;
 
 
input      [15:0]dian_data;
output reg [6:0] dian_addr;
  
 
output reg led     ; 
output reg vga_rden;

input  [3:0]   H1  ;
input  [3:0]   H2  ;
input  [3:0]   H3  ;
input  [3:0]   H4  ;
input  [3:0]   H5  ;
input  [3:0]   H6  ;
input  [3:0]   H7  ;
input  [3:0]   H8  ;
input  [3:0]   H9  ;
input  [3:0]   H10 ;

input  [3:0]   qian  ;
input  [3:0]   bai   ;
input  [3:0]   shi   ;
input  [3:0]   ge    ;




 
reg BLK;
always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  BLK <= 0;
  else begin
   if(cnt_h >= 360 & cnt_h <= 1640 & cnt_v >= 41 & cnt_v <= 1065)
	 BLK <= 1;
	 else 
	  BLK <= 0;
  end



reg [21:0]cnt_rgb;
always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  cnt_rgb <= 0;
 else if(cnt_h >= 380 && cnt_h < 1180 && cnt_v >= 241 && cnt_v < 897)begin
   if(color_zone == 1'b1)
     cnt_rgb <= cnt_rgb + 1'b1;
   else 
     cnt_rgb <= cnt_rgb;
 end
 else if(cnt_h == 1300 && cnt_v == 897)
   cnt_rgb <= 0;
 


always@(posedge sclk or negedge rst_n)
if(!rst_n)
 led <= 1'b1;
 else if(cnt_h == 1290 && cnt_v == 890)begin
   if(cnt_rgb > 10000)
     led <= 1'b1;
   else 
     led <= 1'b0;   
 end
 else 
  led <= led ;



always@(posedge sclk or negedge rst_n)
 if(!rst_n)
  vga_rden <= 1'b0;
 else if(cnt_h > 380 && cnt_h < 1200 && cnt_v > 241 && cnt_v < 897)
  vga_rden <= 1'b1;
 else
  vga_rden <= 1'b0;














always@(posedge sclk or negedge rst_n)
 if(!rst_n) begin 
   vga_red <= 8'b0000_0000;
	vga_bule <= 8'b0000_0000;
	vga_green <= 8'b0000_0000;
   end
	else if(BLK) begin
	   if(cnt_h >= 380 && cnt_h < 1180 && cnt_v >= 241 && cnt_v < 897)begin
	   {vga_red[7:3],vga_green[7:2],vga_bule[7:3]} <= rgb_cam;
	   {vga_red[2:0],vga_green[1:0],vga_bule[2:0]} <= 8'h00;
        cam_addr <= (cnt_h-380)/4 + (cnt_v - 241)/4 * 200;
	    end
/******************************************************************************/
/******************************************************************************/	    
     else if(cnt_h >= 1290 && cnt_h < 1322 && cnt_v >= 241 && cnt_v < 273)begin
              num_addr <= cnt_v - 241;       
            if(num_data[1322 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;     //室
      end    	    	       
      else if(cnt_h >= 1327 && cnt_h < 1359 && cnt_v >= 241 && cnt_v < 273)begin
              num_addr <= cnt_v - 241 + 32;       
            if(num_data[1359 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;  //内
      end       
      else if(cnt_h >= 1364 && cnt_h < 1396 && cnt_v >= 241 && cnt_v < 273)begin
              num_addr <= cnt_v - 241 + 64;       
            if(num_data[1396 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //温
      end  
     else if(cnt_h >= 1401 && cnt_h < 1433 && cnt_v >= 241 && cnt_v < 273)begin
              num_addr <= cnt_v - 241 + 96;       
            if(num_data[1433 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //度
      end  
      else if(cnt_h >= 1532 && cnt_h < 1564 && cnt_v >= 241 && cnt_v < 273)begin
              num_addr <= cnt_v - 241 + 128;       
            if(num_data[1564 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //℃
      end   
/******************************************************************************/
/******************************************************************************/
     else if(cnt_h >= 1290 && cnt_h < 1322 && cnt_v >= 400 && cnt_v < 432)begin
              heart_addr <= cnt_v - 400;       
            if(heart_data[1322 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;     //人
      end    	    	       
      else if(cnt_h >= 1327 && cnt_h < 1359 && cnt_v >= 400 && cnt_v < 432)begin
              heart_addr <= cnt_v - 400 + 32;       
            if(heart_data[1359 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //体
      end       
      else if(cnt_h >= 1364 && cnt_h < 1396 && cnt_v >= 400 && cnt_v < 432)begin
              heart_addr <= cnt_v - 400 + 64;       
            if(heart_data[1396 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //心
      end  
     else if(cnt_h >= 1401 && cnt_h < 1433 && cnt_v >= 400 && cnt_v < 432)begin
              heart_addr <= cnt_v - 400 + 96;       
            if(heart_data[1433 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //率
      end  
      
     else if(cnt_h >= 1496 && cnt_h < 1528 && cnt_v >= 400 && cnt_v < 432)begin
               cifen_addr <= cnt_v - 400;       
            if(cifen_data[1528 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //ci
      end  
      
     else if(cnt_h >= 1546 && cnt_h < 1578 && cnt_v >= 400 && cnt_v < 432)begin
               cifen_addr <= cnt_v - 400 + 32;       
            if(cifen_data[1578 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //fen
      end  
     
     else if(cnt_h >= 1529 && cnt_h < 1545 && cnt_v >= 400 && cnt_v < 432)begin
               dian_addr <= cnt_v - 400 + 64;       
            if(dian_data[1545 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //fen
      end
/******************************************************************************/
/******************************************************************************/


/******************************************************************************/
/******************************************************************************/
     else if(cnt_h >= 1290 && cnt_h < 1322 && cnt_v >= 559 && cnt_v < 591)begin
              temp_addr <= cnt_v - 559;       
            if(temp_data[1322 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;     //人
      end    	    	       
      else if(cnt_h >= 1327 && cnt_h < 1359 && cnt_v >= 559 && cnt_v < 591)begin
              temp_addr <= cnt_v - 559 + 32;       
            if(temp_data[1359 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //体
      end       
      else if(cnt_h >= 1364 && cnt_h < 1396 && cnt_v >= 559 && cnt_v < 591)begin
              temp_addr <= cnt_v - 559 + 64;       
            if(temp_data[1396 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //温
      end  
     else if(cnt_h >= 1401 && cnt_h < 1433 && cnt_v >= 559 && cnt_v < 591)begin
              temp_addr <= cnt_v - 559 + 96;       
            if(temp_data[1433 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //度
      end  
     else if(cnt_h >= 1532 && cnt_h < 1564 && cnt_v >= 559 && cnt_v < 591)begin
              num_addr <= cnt_v - 559 + 128;       
            if(num_data[1564 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //℃
      end 
     
/******************************************************************************/
/******************************************************************************/


/******************************************************************************/
/******************************************************************************/
     else if(cnt_h >= 1290 && cnt_h < 1322 && cnt_v >= 718 && cnt_v < 750)begin
              blood_addr <= cnt_v - 718;       
            if(blood_data[1322 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;     //血
      end    	    	       
      else if(cnt_h >= 1327 && cnt_h < 1359 && cnt_v >= 718 && cnt_v < 750)begin
              blood_addr <= cnt_v - 718 + 32;       
            if(blood_data[1359 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //氧
      end       
      else if(cnt_h >= 1364 && cnt_h < 1396 && cnt_v >= 718 && cnt_v < 750)begin
              blood_addr <= cnt_v - 718 + 64;       
            if(blood_data[1396 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //浓
      end  
     else if(cnt_h >= 1401 && cnt_h < 1433 && cnt_v >= 718 && cnt_v < 750)begin
              blood_addr <= cnt_v - 718 + 96;       
            if(blood_data[1433 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //度
      end  
      else if(cnt_h >= 1514 && cnt_h < 1530 && cnt_v >= 718 && cnt_v < 750)begin
              dian_addr <= cnt_v - 718 + 32;       
            if(dian_data[1530 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    //度
      end  
      
     
/******************************************************************************/
/******************************************************************************/


     else if(cnt_h >= 1440 && cnt_h < 1456 && cnt_v >= 241 && cnt_v < 273)begin
              shuzi_addr <= cnt_v - 241 + ( H1 * 32 );       
            if(shuzi_data[1456 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end  
    else if(cnt_h >= 1458 && cnt_h < 1474 && cnt_v >= 241 && cnt_v < 273)begin
              shuzi_addr <= cnt_v - 241 + ( H2 * 32 ) ;       
            if(shuzi_data[1474 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
      
   else if(cnt_h >= 1476 && cnt_h < 1492 && cnt_v >= 241 && cnt_v < 273)begin
              dian_addr <= cnt_v - 241 ;       
            if(dian_data[1492 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end       
      
    else if(cnt_h >= 1496 && cnt_h < 1512 && cnt_v >= 241 && cnt_v < 273)begin
              shuzi_addr <= cnt_v - 241 + ( H3 * 32 );       
            if(shuzi_data[1512 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
    else if(cnt_h >= 1514 && cnt_h < 1530 && cnt_v >= 241 && cnt_v < 273)begin
              shuzi_addr <= cnt_v - 241 + ( H4 * 32 );       
            if(shuzi_data[1530 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end       
/******************************************************************************/
/******************************************************************************/	  


/******************************************************************************/
/******************************************************************************/
     else if(cnt_h >= 1440 && cnt_h < 1456 && cnt_v >= 400 && cnt_v < 432)begin
              shuzi_addr <= cnt_v - 400 + ( H7 *32 ) ;       
            if(shuzi_data[1456 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end  
    else if(cnt_h >= 1458 && cnt_h < 1474 && cnt_v >= 400 && cnt_v < 432)begin
              shuzi_addr <= cnt_v - 400 + ( H8 *32 ) ;       
            if(shuzi_data[1474 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
    else if(cnt_h >= 1476 && cnt_h < 1492 && cnt_v >= 400 && cnt_v < 432)begin
              shuzi_addr <= cnt_v - 400 + ( H9 *32 ) ;       
            if(shuzi_data[1492 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
   
/******************************************************************************/
/******************************************************************************/ 

/******************************************************************************/
/******************************************************************************/
      else if(cnt_h >= 1440 && cnt_h < 1456 && cnt_v >= 559 && cnt_v < 591)begin
              shuzi_addr <= cnt_v - 559 + (qian * 32);       
            if(shuzi_data[1456 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end  
    else if(cnt_h >= 1458 && cnt_h < 1474 && cnt_v >= 559 && cnt_v < 591)begin
              shuzi_addr <= cnt_v - 559 + ( bai * 32 );       
            if(shuzi_data[1474 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
     else if(cnt_h >= 1476 && cnt_h < 1492 && cnt_v >= 559 && cnt_v < 591)begin
              dian_addr <= cnt_v - 559 ;       
            if(dian_data[1492 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
    else if(cnt_h >= 1496 && cnt_h < 1512 && cnt_v >= 559 && cnt_v < 591)begin
              shuzi_addr <= cnt_v - 559 + ( shi * 32 );       
            if(shuzi_data[1512 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
    else if(cnt_h >= 1514 && cnt_h < 1530 && cnt_v >= 559 && cnt_v < 591)begin
              shuzi_addr <= cnt_v - 559 + ( ge * 32 );       
            if(shuzi_data[1530 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end       
/******************************************************************************/
/******************************************************************************/ 


/******************************************************************************/
/******************************************************************************/
     else if(cnt_h >= 1440 && cnt_h < 1456 && cnt_v >= 718 && cnt_v < 750)begin
              shuzi_addr <= cnt_v - 718 + ( H5 * 32 );       
            if(shuzi_data[1456 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end  
    else if(cnt_h >= 1458 && cnt_h < 1474 && cnt_v >= 718 && cnt_v < 750)begin
              shuzi_addr <= cnt_v - 718 + ( H6 * 32 );       
            if(shuzi_data[1474 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end 
    else if(cnt_h >= 1476 && cnt_h < 1492 && cnt_v >= 718 && cnt_v < 750)begin
              shuzi_addr <= cnt_v - 718 + ( H10 * 32 );       
            if(shuzi_data[1492 - cnt_h])     
             {vga_red,vga_green,vga_bule} <= 24'hffffff ;
            else 
               {vga_red,vga_green,vga_bule} <= 24'h000000 ;    
      end                  

/******************************************************************************/
/******************************************************************************/ 	  	                            
	  else begin 
	  {vga_red,vga_green,vga_bule} <= 24'h000000;
	  end 
	                           
	end
	
	else  begin 
	vga_red <= 8'b0000_0000;
	vga_bule <= 8'b0000_0000;
	vga_green <= 8'b0000_0000;
	end 
	
	
	
















endmodule
