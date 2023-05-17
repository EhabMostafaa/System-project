module PARITY_CHECK_URT_RX #(parameter DATA_WIDTH=8)
(
     input     wire                          CLK_PAR_CHECK,
     input     wire                          RST_PAR_CHECK,   
     input     wire                          PAR_TYP_PAR_CHECK,
     input     wire                          par_chk_en_PAR_CHECK,
     input     wire                          sampled_bit_PAR_CHECK,
     input     wire   [DATA_WIDTH-1:0]       P_DATA_PAR_CHECK,

     output    reg                           par_err_PAR_CHECK
     );

reg calculated_parity;

always @(*)
    begin
        if(PAR_TYP_PAR_CHECK)  // Odd Parity 
           begin
             calculated_parity=~^P_DATA_PAR_CHECK;
           end
        else   //Even Parity
           begin
              calculated_parity=^P_DATA_PAR_CHECK;
           end
    end


always @(posedge CLK_PAR_CHECK or negedge RST_PAR_CHECK)
    begin
      if(!RST_PAR_CHECK)
        begin
            par_err_PAR_CHECK<='b0;
        end
       else if(par_chk_en_PAR_CHECK)
           begin
              par_err_PAR_CHECK <=calculated_parity ^ sampled_bit_PAR_CHECK;
           end
         end

endmodule               
         