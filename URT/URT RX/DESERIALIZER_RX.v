module DESERIALIZER_URT_RX #(parameter DATA_WIDTH= 8,
                                       PRESCALE_WIDTH=5)
      (
    input    wire                            CLK_DESERIALIZER,
    input    wire                            RST_DESERIALIZER,
    input    wire                            deser_en_DESERIALIZER,     
    input    wire  [PRESCALE_WIDTH-1:0]      Prescale_DESERIALIZER, 
    input    wire                            sampled_bit_DESERIALIZER,
    input    wire  [3:0]                     edge_cnt_DESERIALIZER,

    output   reg   [DATA_WIDTH-1:0]           P_DATA_DESERIALIZER
   );


always @(posedge CLK_DESERIALIZER or negedge RST_DESERIALIZER )
   begin
      if(!RST_DESERIALIZER)
        begin
            P_DATA_DESERIALIZER<='b0;
        end
           
      else if (deser_en_DESERIALIZER) 
          begin
            if((Prescale_DESERIALIZER=='d8) && (edge_cnt_DESERIALIZER =='b111))
               begin
                P_DATA_DESERIALIZER<={sampled_bit_DESERIALIZER,P_DATA_DESERIALIZER[7:1]};             //if is send 0>0>1>1>1>0>1>1      it will stored p_data=8'b1101_1100              i chose this assumption
               end
           
            else if((Prescale_DESERIALIZER=='d16) && (edge_cnt_DESERIALIZER =='b1111))
               begin
              P_DATA_DESERIALIZER<={sampled_bit_DESERIALIZER,P_DATA_DESERIALIZER[7:1]};
                end
            else 
               begin
                P_DATA_DESERIALIZER<=P_DATA_DESERIALIZER;
               end   
          end
       else 
           begin
              P_DATA_DESERIALIZER<=P_DATA_DESERIALIZER;
             end   
               
   end
endmodule       