
module seriallizer_uart_tx #(parameter DATA_SIZE=8)( 
	  input   wire                     CLK_SER,
	  input   wire                     RST_SER,
    input   wire   [DATA_SIZE-1:0]   P_DATA_SER,
    input   wire                     ser_en_SER,
    input   wire                     Busy_SER,
	  input   wire                     Data_Valid_SER,
    output  reg                      ser_data_SER,
    output  reg                      ser_done_SER);

//internal Signals
 reg   [DATA_SIZE-1 :0] DATA;
 reg   [2:0]            count;
 
 always@(posedge CLK_SER or negedge RST_SER)
     begin
       if (!RST_SER)
         begin
           DATA<='b0;
          end
	   else if(Data_Valid_SER && !Busy_SER)
         begin
           DATA<=P_DATA_SER; 
         end
       else
           DATA<=DATA>>1;
	end	   
	
always@(posedge CLK_SER or negedge RST_SER)
     begin
       if (!RST_SER)
        count<='b0;
       else if(ser_en_SER)
       	count<=count+1;
       else	  	
        count<='b0;
	 end
	 
always@(*)
     begin
      ser_data_SER=DATA[0];
      if(count==3'b111)
        ser_done_SER='b1;
	    else
        ser_done_SER='b0;
      end		
endmodule