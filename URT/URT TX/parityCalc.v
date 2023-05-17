module parityCalic_uart_tx #(parameter DATA_SIZE =8)(
		 input   wire                    CLK_PAR,
		 input   wire                    RST_PAR,
         input   wire  [DATA_SIZE-1:0]   P_DATA_PAR,
         input   wire                    Data_valid_PAR,
         input   wire                    PAR_TYP_PAR,
		 output  reg                     par_bit_PAR);



always@(posedge CLK_PAR or negedge RST_PAR)
   begin
     if(!RST_PAR)
       begin
	   par_bit_PAR<='b0;
	   end
	   
     else if(Data_valid_PAR)
       begin
          if(PAR_TYP_PAR)	     // odd parity  
		    par_bit_PAR<=~^P_DATA_PAR;
		  else                   // even parity
		    par_bit_PAR<=^P_DATA_PAR;
        end
	end
endmodule	
