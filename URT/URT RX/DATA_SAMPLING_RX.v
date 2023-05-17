module DATA_SAMP_URT_RX  #(parameter  PRESCALE_WIDTH =5)( 
   input     wire                              CLK_SAMP,
   input     wire                              RST_SAMP,
   input     wire     [PRESCALE_WIDTH-1:0]     Prescale_SAMP,
   input     wire                              RX_IN_SAMP,
   input     wire                              dat_samp_en_SAMP,
   input     wire     [3:0]                    edge_cnt_SAMP,

   output    reg                               sampled_bit_SAMP  
);

///////////internal signals to get sampling time 
wire [3:0] first_sample_edge,last_sample_edge,center_sample_edge;

///////////internal signals to store samples
reg     first_sample,second_sample,third_sample;
      
          
always @(posedge CLK_SAMP or negedge RST_SAMP)
    begin
       if(!RST_SAMP)
            begin
               sampled_bit_SAMP<='b1;      // default in idle equal "1"
             end
       else if (dat_samp_en_SAMP)
            begin
            case({first_sample,second_sample,third_sample})
            3'b000: sampled_bit_SAMP<='b0;
            3'b001: sampled_bit_SAMP<='b0;
            3'b010: sampled_bit_SAMP<='b0;
            3'b011: sampled_bit_SAMP<='b1;
            3'b100: sampled_bit_SAMP<='b0;
            3'b101: sampled_bit_SAMP<='b1;
            3'b110: sampled_bit_SAMP<='b1;
            3'b111: sampled_bit_SAMP<='b1;
            endcase
           end             
        else 
           begin
             sampled_bit_SAMP<='b1;      // default in idle equal "1"
           end                 
         end


always @(posedge CLK_SAMP or negedge RST_SAMP)
    begin
       if(!RST_SAMP)
            begin
                first_sample<='b1;
                second_sample<='b1;
                third_sample<='b1;
             end

         else if(dat_samp_en_SAMP )
             begin
                   if (edge_cnt_SAMP == first_sample_edge)
                     first_sample<=RX_IN_SAMP;
                
                else if (edge_cnt_SAMP == center_sample_edge)
                     second_sample<=RX_IN_SAMP;

                else if (edge_cnt_SAMP == last_sample_edge)
                     third_sample<=RX_IN_SAMP;
              end
    
           else
              begin
                first_sample<='b1;
                second_sample<='b1;
                third_sample<='b1;
              end      
          end





assign center_sample_edge=(Prescale_SAMP>>1)-1;
assign first_sample_edge =center_sample_edge-1;
assign last_sample_edge  =center_sample_edge+1;

endmodule
