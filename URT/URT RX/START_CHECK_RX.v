module START_CHECK_URT_RX (
     input    wire        CLK_START_CHECK,
     input    wire        RST_START_CHECK,
     input    wire        strt_chk_en_START_CHECK,
     input    wire        sampled_bit_START_CHECK,
      
     output   reg         strt_glitch_START_CHECK 
);

always@(posedge CLK_START_CHECK or negedge RST_START_CHECK)
  begin
    if(!RST_START_CHECK)
       begin
           strt_glitch_START_CHECK<='b0;
         end
   
    else if(strt_chk_en_START_CHECK)
       begin
          strt_glitch_START_CHECK <= sampled_bit_START_CHECK;
         end
    end
endmodule           

