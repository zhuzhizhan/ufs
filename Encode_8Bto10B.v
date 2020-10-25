`timescale 1ns / 1ps
module Transition_8Bto10B(data_in,data_out,rd_in,rd_out,k_in);
   input [7:0]data_in;
	input rd_in,k_in;
	output[9:0]data_out;
	output rd_out;
	reg [9:0]data_out;
	reg [5:0]code6b;
	reg [3:0]code4b,i;
	reg [2:0]disparity_5bto6b,disparity_3bto4b;
	reg rd_after5bto6b;
	reg rd_out;
	
	initial
     begin
		if(k_in&&(data_in[4:0]===5'b11100))
		 begin
			if(!rd_in)
				code6b=6'b001111;
			else
				code6b=6'b110000;
		 end
		else
		begin
			if(!rd_in)
				begin
					case(data_in[4:0])
						 5'b00000 :                
							code6b=6'b100111;
						 5'b00001 :                
							code6b=6'b011101;
						 5'b00010 :                
							code6b=6'b101101;
						 5'b00011 :
							code6b=6'b110001;
						 5'b00100 :                
							code6b=6'b110101;			  
						 5'b00101 :
							code6b=6'b101001;	
						 5'b00110 :
							code6b=6'b011001;
						 5'b00111 :                
							code6b=6'b111000;
						 5'b01000 :                
							code6b=6'b111001;
						 5'b01001 :
							code6b=6'b100101;
						 5'b01010 :
							code6b=6'b010101;  
						 5'b01011 :
							code6b=6'b110100;
						 5'b01100 :
							code6b=6'b001101;
						 5'b01101 :
							code6b=6'b101100;
						 5'b01110 :
							code6b=6'b011100;
						 5'b01111 :              
							code6b=6'b010111;
						 5'b10000 :             
							code6b=6'b011011;
						 5'b10001 :
							code6b=6'b100011;
						 5'b10010 :
							code6b=6'b010011;
						 5'b10011 :
							code6b=6'b110010;
						 5'b10100 :
							code6b=6'b001011;
						 5'b10101 :
							code6b=6'b101010;
						 5'b10110 :
							code6b=6'b011010;
						 5'b10111 :             
							code6b=6'b111010;
						 5'b11000 :             
							code6b=6'b110011;
						 5'b11001 :
							code6b=6'b100110;
						 5'b11010 :
							code6b=6'b010110;
						 5'b11011 :              
							code6b=6'b110110;
						 5'b11100 :
							code6b=6'b001110;
						 5'b11101 :             
							code6b=6'b101110;
						 5'b11110 :               
							code6b=6'b011110;
						 5'b11111 :     
							code6b=6'b101011;
					  default :
							code6b=6'bXXXXXX;		
					endcase
				end
			else
				begin
					case(data_in[4:0])
						 5'b00000 :                
							code6b=6'b011000;
						 5'b00001 :                
							code6b=6'b100010;
						 5'b00010 :                
							code6b=6'b010010;
						 5'b00011 :
							code6b=6'b110001;
						 5'b00100 :                
							code6b=6'b001010;			  
						 5'b00101 :
							code6b=6'b101001;	
						 5'b00110 :
							code6b=6'b011001;
						 5'b00111 :                
							code6b=6'b000111;
						 5'b01000 :                
							code6b=6'b000110;
						 5'b01001 :
							code6b=6'b100101;
						 5'b01010 :
							code6b=6'b010101;  
						 5'b01011 :
							code6b=6'b101100;
						 5'b01100 :
							code6b=6'b001101;
						 5'b01101 :
							code6b=6'b101100;
						 5'b01110 :
							code6b=6'b011100;
						 5'b01111 :              
							code6b=6'b101000;
						 5'b10000 :             
							code6b=6'b100100;
						 5'b10001 :
							code6b=6'b100011;
						 5'b10010 :
							code6b=6'b010011;
						 5'b10011 :
							code6b=6'b110010;
						 5'b10100 :
							code6b=6'b001010;
						 5'b10101 :
							code6b=6'b101010;
						 5'b10110 :
							code6b=6'b011010;
						 5'b10111 :             
							code6b=6'b000101;
						 5'b11000 :             
							code6b=6'b001100;
						 5'b11001 :
							code6b=6'b100110;
						 5'b11010 :
							code6b=6'b010110;
						 5'b11011 :              
							code6b=6'b001001;
						 5'b11100 :
							code6b=6'b001110;
						 5'b11101 :             
							code6b=6'b010001;
						 5'b11110 :
							code6b=6'b100001;
						 5'b11111 :     
							code6b=6'b010100;
					  default :
							code6b=6'bXXXXXX;
					endcase
				end
		end
			
		for(i=0;i<6;i=i+1)
			data_out[i+4]=code6b[i];
			
		for(i=0;i<6;i=i+1)
			disparity_5bto6b=disparity_5bto6b+code6b[i];
			
		if(disparity_5bto6b>3||code6b===6'b000111||(disparity_5bto6b==3&&rd_in==1))
		   rd_after5bto6b=1;
		else
			rd_after5bto6b=0;

		if(!k_in)
		begin
			if(!rd_after5bto6b)
				begin
					case(data_in[7:5])
						3'b000:
							code4b=4'b1011;
						3'b001:
							code4b=4'b1001;
						3'b010:
							code4b=4'b0101;
						3'b011:
							code4b=4'b1100;
						3'b100:
							code4b=4'b1101;
						3'b101:
							code4b=4'b1010;
						3'b110:
							code4b=4'b0110;
						3'b111:
							if((code6b[0]==1)&&(code6b[1]==1))
							  code4b=4'b0111;
							else
							  code4b=4'b1110;
						default :
                       code4b=4'bXXXX;
					endcase
				end
			else
				begin
					case(data_in[7:5])
						3'b000:
							code4b=4'b0100;
						3'b001:
							code4b=4'b1001;
						3'b010:
							code4b=4'b0101;
						3'b011:
							code4b=4'b0011;
						3'b100:
							code4b=4'b0010;
						3'b101:
							code4b=4'b1010;
						3'b110:
							code4b=4'b0110;
						3'b111:
							if((code6b[0]==0)&&(code6b[1]==0))
							  code4b=4'b1000;
							else
							  code4b=4'b0001;
					   default :
                       code4b=4'bXXXX;
					endcase
				end
		end
		else
		begin
			if(!rd_after5bto6b)
				begin
					case(data_in[7:5])
						3'b000:
							code4b=4'b1011;
						3'b001:
							code4b=4'b0110;
						3'b010:
							code4b=4'b1010;
						3'b011:
							code4b=4'b1100;
						3'b100:
							code4b=4'b1101;
						3'b101:
							code4b=4'b0101;
						3'b110:
							code4b=4'b1001;
						3'b111:
							code4b=4'b0111;
						default :
                     code4b=4'bXXXX;
					endcase
				end
			else
				begin
					case(data_in[7:5])
						3'b000:
							code4b=4'b0100;
						3'b001:
							code4b=4'b1001;
						3'b010:
							code4b=4'b0101;
						3'b011:
							code4b=4'b0011;
						3'b100:
							code4b=4'b0010;
						3'b101:
							code4b=4'b1010;
						3'b110:
							code4b=4'b0110;
						3'b111:
							code4b=4'b1000;
						default :
                     code4b=4'bXXXX;
					endcase
				end
	  end
	
	  for(i=0;i<4;i=i+1)
			data_out[i]=code4b[i];
	
	  for(i=0;i<4;i=i+1)
			disparity_3bto4b=disparity_3bto4b+code4b[i];
	  
		if(disparity_3bto4b>2||code4b===4'b0011||(rd_after5bto6b==1&&disparity_3bto4b==2))
			rd_out=1;
		else
			rd_out=0;
	end


endmodule

module testbench;
	reg [7:0]data_in;
	reg k_in,rd_in;
	wire [9:0]data_out;
	wire rd_out;

	Transition_8Bto10B testbench(.data_in(data_in),.rd_in(rd_in),.k_in(k_in),.data_out(data_out),.rd_out(rd_out));

  initial
	  begin
			data_in=8'b10111100;
			k_in=0;
			rd_in=0;
	  end
		
endmodule
