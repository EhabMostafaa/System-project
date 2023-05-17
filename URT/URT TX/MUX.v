module mux_uart_tx ( input   wire                CLK_MUX,
                     input   wire                RST_MUX,
                     input   wire  [1:0]         mux_sel_MUX,
                     input   wire                ser_data_MUX,
                     input   wire                par_bit_MUX,
                     output  reg                 TX_OUT_MUX );

reg       mux_comb;
always@(*) 
   begin 
      mux_comb='b1;
      case (mux_sel_MUX)
         2'b00   : mux_comb='b0;
         2'b01   : mux_comb=ser_data_MUX;
         2'b10   : mux_comb=par_bit_MUX;
         2'b11   : mux_comb='b1;
         default : mux_comb='b1;
      endcase
   end


                              
 always @(posedge CLK_MUX or negedge RST_MUX)
  begin
  if(!RST_MUX)
   TX_OUT_MUX<='b0;
  else
  TX_OUT_MUX<=mux_comb; 
 end                    
 
endmodule