module gsm_me_video( clk,
	rst_n,
	key_flag,
	line_tx,
	en_choice
    );
     input clk;
	 input rst_n;
	 input key_flag;
	 output reg line_tx;
	 output reg en_choice;
	 
	 
parameter tx_start = 0,tx_stop = 1;
parameter delay_cnt = 12000000;
parameter telephone = "18740404399";
//parameter data_tx = "A"; 
reg [7:0]data_tx;
reg [12:0] cnt;  //波特率计数
reg clk_tx;      //分频时钟（波特率）
reg [3:0] cnt_tx;
reg en ;
reg [7:0]stop;

reg [24:0]cnt_20ms; //每发送一串指令后的延时
reg en_cnt_20ms;

//用来选择是打电话还是发短信
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_choice <= 0;
	else if(key_flag)
	    en_choice <= 1;
	else if(stop == 171 && cnt_tx == 11)
	    en_choice <= 0;
	else 
	    en_choice <= en_choice;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    en_cnt_20ms <= 0;
	else if(cnt_20ms == delay_cnt - 1'b1)
	    en_cnt_20ms <= 0;
	else if(stop == 2 && cnt_tx == 11)//第一串指令发完
	    en_cnt_20ms <= 1;
	else if(stop == 6 && cnt_tx == 11)//第二串指令发完
	    en_cnt_20ms <= 1;
	else if(stop == 11 && cnt_tx == 11)//第三串指令发完
	    en_cnt_20ms <= 1;
	else if(stop == 16 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 25 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 32 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 41 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 51 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 53 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 63 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 77 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 86 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 107 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 129 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else if(stop == 169 && cnt_tx == 11)//第四串指令发完
	    en_cnt_20ms <= 1;
    else 
	    en_cnt_20ms <= en_cnt_20ms;
		
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    cnt_20ms <= 0;
	else if(en_cnt_20ms)
	    if(cnt_20ms == delay_cnt - 1'b1)
		    cnt_20ms <= 0;
		else 
		    cnt_20ms <= cnt_20ms + 1'b1;
	else 
	    cnt_20ms <= 0;

always @(posedge clk or negedge rst_n)
    if(!rst_n)
	    stop <= 0;
	else if(stop == 171 && cnt_tx == 11)
	    stop <= 0;
	else if(cnt_tx == 11)
	    stop <= stop + 1'b1;
	else 
	    stop <= stop;
		
always @(posedge clk or negedge rst_n)
    if(!rst_n)
	     data_tx <= 8'b1011_1110;
	else if(en)
	     case(stop)
	     'd0:data_tx <= "A";	 
	     'd1:data_tx <= "T";
		 'd2:data_tx <= 8'b0000_1101;//回车
         'd3:data_tx <= "A";	 
	     'd4:data_tx <= "T";
         'd5:data_tx <= "I";
		 'd6:data_tx <= 8'b0000_1101;//回车
         'd7:data_tx <= "A";	 
	     'd8:data_tx <= "T";
         'd9:data_tx <= "E";
         'd10:data_tx <= "0";
		 'd11:data_tx <= 8'b0000_1101;//回车
         'd12:data_tx <= "A";	 
	     'd13:data_tx <= "T";
         'd14:data_tx <= "E";
         'd15:data_tx <= "1";
		 'd16:data_tx <= 8'b0000_1101;//回车
         'd17:data_tx <= "A";	 
	     'd18:data_tx <= "T";
         'd19:data_tx <= "+";
         'd20:data_tx <= "C";
         'd21:data_tx <= "P";
         'd22:data_tx <= "I";
         'd23:data_tx <= "N";
         'd24:data_tx <= "?";
		 'd25:data_tx <= 8'b0000_1101;//回车
         'd26:data_tx <= "A";	 
	     'd27:data_tx <= "T";
         'd28:data_tx <= "+";
         'd29:data_tx <= "C";
         'd30:data_tx <= "S";
         'd31:data_tx <= "Q";
		 'd32:data_tx <= 8'b0000_1101;//回车
         'd33:data_tx <= "A";	 
	     'd34:data_tx <= "T";
         'd35:data_tx <= "+";
         'd36:data_tx <= "C";
         'd37:data_tx <= "R";
         'd38:data_tx <= "E";
         'd39:data_tx <= "G";
         'd40:data_tx <= "?";
		 'd41:data_tx <= 8'b0000_1101;//回车
         'd42:data_tx <= "A";	 
	     'd43:data_tx <= "T";
         'd44:data_tx <= "+";
         'd45:data_tx <= "C";
         'd46:data_tx <= "G";
         'd47:data_tx <= "A";
         'd48:data_tx <= "T";
         'd49:data_tx <= "T";
         'd50:data_tx <= "?";
		 'd51:data_tx <= 8'b0000_1101;//回车
         'd52:data_tx <= 8'b0010_0000;//空格
         'd53:data_tx <= 8'b0000_1101;//回车
		 'd54:data_tx <= "A";	 
	     'd55:data_tx <= "T";
		 'd56:data_tx <= "+";
		 'd57:data_tx <= "C";	 
	     'd58:data_tx <= "M";
		 'd59:data_tx <= "G";
		 'd60:data_tx <= "F";
		 'd61:data_tx <= "=";
		 'd62:data_tx <= "1";
		 'd63:data_tx <= 8'b0000_1101;//回车
         'd64:data_tx <= "A";	 
	     'd65:data_tx <= "T";
		 'd66:data_tx <= "+";
		 'd67:data_tx <= "C";	 
	     'd68:data_tx <= "S";
		 'd69:data_tx <= "C";
		 'd70:data_tx <= "S";
		 'd71:data_tx <= "=";
         'd72:data_tx <= 8'b0010_0010;//"
		 'd73:data_tx <= "G";
		 'd74:data_tx <= "S";
		 'd75:data_tx <= "M";
         'd76:data_tx <= 8'b0010_0010;//"
		 'd77:data_tx <= 8'b0000_1101;//回车
         'd78:data_tx <= "A";	 
	     'd79:data_tx <= "T";
		 'd80:data_tx <= "+";
		 'd81:data_tx <= "C";	 
	     'd82:data_tx <= "S";
		 'd83:data_tx <= "C";
		 'd84:data_tx <= "A";
		 'd85:data_tx <= "?";
		 'd86:data_tx <= 8'b0000_1101;//回车
         'd87:data_tx <= "A";	 
	     'd88:data_tx <= "T";
		 'd89:data_tx <= "+";
		 'd90:data_tx <= "C";	 
	     'd91:data_tx <= "S";
		 'd92:data_tx <= "M";
		 'd93:data_tx <= "P";
		 'd94:data_tx <= "=";
		 'd95:data_tx <= "1";
         'd96:data_tx <= "7";
         'd97:data_tx <= ",";
         'd98:data_tx <= "1";
         'd99:data_tx <= "6";
         'd100:data_tx <= "7";
         'd101:data_tx <= ",";
         'd102:data_tx <= "0";
         'd103:data_tx <= ",";
         'd104:data_tx <= "2";
         'd105:data_tx <= "4";
         'd106:data_tx <= "0";
		 'd107:data_tx <= 8'b0000_1101;//回车
		 'd108:data_tx <= "A";	 
	     'd109:data_tx <= "T";
		 'd110:data_tx <= "+";
		 'd111:data_tx <= "C";	 
	     'd112:data_tx <= "M";
		 'd113:data_tx <= "G";
		 'd114:data_tx <= "S";
		 'd115:data_tx <= "=";
		 'd116:data_tx <= 8'b0010_0010;//"
		 'd117:data_tx <= telephone[87:80];
		 'd118:data_tx <= telephone[79:72];
		 'd119:data_tx <= telephone[71:64];
		 'd120:data_tx <= telephone[63:56];
		 'd121:data_tx <= telephone[55:48];
		 'd122:data_tx <= telephone[47:40];
		 'd123:data_tx <= telephone[39:32];
		 'd124:data_tx <= telephone[31:24];
		 'd125:data_tx <= telephone[23:16];
		 'd126:data_tx <= telephone[15:8];
		 'd127:data_tx <= telephone[7:0];
		 'd128:data_tx <= 8'b0010_0010;//"
		 'd129:data_tx <= 8'b0000_1101;//回车
		 'd130:data_tx <= "T";
		 'd131:data_tx <= "h";
		 'd132:data_tx <= "e";
		 'd133:data_tx <= 8'b0010_0000;//空格
		 'd134:data_tx <= "p";
		 'd135:data_tx <= "a";
		 'd136:data_tx <= "t";
		 'd137:data_tx <= "i";
		 'd138:data_tx <= "e";
		 'd139:data_tx <= "n";
		 'd140:data_tx <= "t";
		 'd141:data_tx <= 8'b0010_0000;//空格
		 'd142:data_tx <= "i";
		 'd143:data_tx <= "s";
		 'd144:data_tx <= 8'b0010_0000;//空格
		 'd145:data_tx <= "n";
		 'd146:data_tx <= "o";
		 'd147:data_tx <= "t";
		 'd148:data_tx <= 8'b0010_0000;//空格
		 'd149:data_tx <= "i";
		 'd150:data_tx <= "n";
		 'd151:data_tx <= 8'b0010_0000;//空格
		 'd152:data_tx <= "t";
		 'd153:data_tx <= "h";
		 'd154:data_tx <= "e";
		 'd155:data_tx <= 8'b0010_0000;//空格
		 'd156:data_tx <= "h";
		 'd157:data_tx <= "o";
		 'd158:data_tx <= "s";
		 'd159:data_tx <= "p";
		 'd160:data_tx <= "i";
		 'd161:data_tx <= "t";
		 'd162:data_tx <= "a";
		 'd163:data_tx <= "l";
		 'd164:data_tx <= 8'b0010_0000;//空格
		 'd165:data_tx <= "b";
		 'd166:data_tx <= "e";
		 'd167:data_tx <= "d";
		 'd168:data_tx <= ".";
		 'd169:data_tx <= 8'b0000_1101;//回车
		 'd170:data_tx <= 8'b0001_1010;//HEX :1A
		 'd171:data_tx <= 8'b0000_1101;//回车
	     endcase		
		
always @(posedge clk or negedge rst_n)
begin
   if(!rst_n)
	    en <= 0;
	else if(key_flag)
	    en <= 1;
	else if(cnt_20ms == delay_cnt - 1'b1)
	    en <= 1;
	else if(stop == 2 && cnt_tx == 11)//第一串指令发完
	    en <= 0;
	else if(stop == 6 && cnt_tx == 11)//第二串指令发完
	    en <= 0;
	else if(stop == 11 && cnt_tx == 11)//第三串指令发完
	    en <= 0;
	else if(stop == 16 && cnt_tx == 11)//第四串指令发完
	    en <= 0;
	else if(stop == 25 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 32 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 41 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 51 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 53 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 63 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 77 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 86 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 107 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 129 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 169 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
    else if(stop == 171 && cnt_tx == 11)//第五串指令发完
	    en <= 0;
	else 
	    en <= en;
end


// 按键按下使能端打开，以及使能的停止


always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	     cnt <= 0;
	 else if(en)
	 begin
	     if(cnt == 2499)
	         cnt <= 0;
	     else 
	         cnt <= cnt + 1'b1;
	 end
	 else 
	     cnt <= 0;
end
//分频计数

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	     clk_tx <= 0;
	 else if(cnt == 2)
	     clk_tx <= 1;
	 else 
	     clk_tx <= 0;
end
//分频时钟的产生

always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
	     cnt_tx <= 0;
	 else if(en)
	 begin
	     if(cnt_tx == 11)
	         cnt_tx <= 0;
	     else if(clk_tx)
	         cnt_tx <= cnt_tx + 1'b1;
	 end
	 else 
	     cnt_tx <= 0;
end

//用来传输数据的计数
always @(posedge clk or negedge rst_n)
begin
    if(!rst_n)
        line_tx <= 1;
	 else if(en)
	 case(cnt_tx)
	 'd0:line_tx <= 1;
	 'd1:line_tx <= tx_start;
	 'd2:line_tx <= data_tx[0];
	 'd3:line_tx <= data_tx[1];
	 'd4:line_tx <= data_tx[2];
	 'd5:line_tx <= data_tx[3];
	 'd6:line_tx <= data_tx[4];
	 'd7:line_tx <= data_tx[5];
	 'd8:line_tx <= data_tx[6];
	 'd9:line_tx <= data_tx[7];
	 'd10:line_tx <= tx_stop;
	 default:line_tx <= 1;
	 endcase
end


endmodule
