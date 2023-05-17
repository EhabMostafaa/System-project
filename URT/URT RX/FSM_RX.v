module FSM_URT_RX (
    input    wire          CLK_FSM,
    input    wire          RST_FSM,
    input    wire          RX_IN_FSM,
    input    wire   [3:0]  bit_cnt_FSM,
    input    wire   [3:0]  edge_cnt_FSM,
    input    wire          PAR_EN_FSM,
    input    wire          par_err_FSM,
    input    wire          strt_glitch_FSM,
    input    wire          stp_err_FSM,

    output   reg           dat_samp_en_FSM,
    output   reg           enable_edge_bit_FSM,
    output   reg           par_chk_en_FSM,
    output   reg           strt_chk_en_FSM,
    output   reg           stp_chk_en_FSM,
    output   reg           data_valid_FSM,
    output   reg           deser_en_FSM  
);

localparam [2:0] IDLE   =3'b000,
                 START  =3'b001,
                 DATA   =3'b011,
                 PARITY =3'b010,
                 STOP   =3'b110,
                 ERR_CHK=3'b111,
                 VALID  =3'b101;

reg [2:0] current_state , next_state;


always@(posedge CLK_FSM or negedge RST_FSM)
      begin
         if(!RST_FSM)
            begin
               current_state <=IDLE;
              end
          else 
             begin
                current_state <=next_state;
             end  
      end


// combinational always to determine next states
always @(*)
  begin
    case(current_state)
      IDLE  :begin
              if(!RX_IN_FSM)
                begin
                    next_state=START;
                end
              else 
                begin
                    next_state=IDLE;
                end  
               end 
      
      START :begin
            if((bit_cnt_FSM=='d0) && (edge_cnt_FSM=='d7))
              begin
               if(!strt_glitch_FSM)
                begin
                    next_state=DATA;
                end        
              else
                begin
                    next_state=IDLE;
                end
            end 
            else
                begin
                  next_state=START;
                end
            end

      DATA :begin
               if((bit_cnt_FSM=='d8) && (edge_cnt_FSM=='d7))
                begin
                  if(PAR_EN_FSM)
                    begin
                    next_state=PARITY;
                    end
                  else 
                    begin
                      next_state=STOP;
                    end  
                end        
              else
                begin
                    next_state=DATA;
                end
            end 

    PARITY :begin
              if((bit_cnt_FSM=='d9) && (edge_cnt_FSM=='d7))
               begin 
                    next_state=STOP;
                   end        
               else 
                   begin
                    next_state=PARITY;
                   end 
                end

      STOP :begin
              if((bit_cnt_FSM=='d10) && (edge_cnt_FSM=='d7))
                 next_state=ERR_CHK;
               else  
                  next_state=STOP;
            end 

     ERR_CHK: begin
             if(par_err_FSM |stp_err_FSM)
             next_state=IDLE;
             else
             next_state=VALID;
                 end

     VALID: begin
            if(!RX_IN_FSM)
            next_state=START;
            else
            next_state=IDLE;
               end                     
               
    default: begin
                    next_state=IDLE;       
                end
      endcase
    end


// combinational always to determine outputs 
always @(*)
    begin
         dat_samp_en_FSM     ='b0;    
         enable_edge_bit_FSM ='b0;
         par_chk_en_FSM      ='b0;     
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b0;     
         deser_en_FSM        ='b0;  

    case(current_state)
    
    IDLE: begin
      if(!RX_IN_FSM)
         begin   
         dat_samp_en_FSM      ='b1;    
         enable_edge_bit_FSM  ='b1;
         par_chk_en_FSM       ='b0;     
         strt_chk_en_FSM      ='b1;    
         stp_chk_en_FSM       ='b0;     
         data_valid_FSM       ='b0;     
         deser_en_FSM         ='b0;  
             end         
     else 
         begin
         dat_samp_en_FSM     ='b0;    
         enable_edge_bit_FSM ='b0;
         par_chk_en_FSM      ='b0;     
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b0;     
         deser_en_FSM        ='b0;
         end
    end

   START: begin
         dat_samp_en_FSM      ='b1;    
         enable_edge_bit_FSM  ='b1;
         strt_chk_en_FSM      ='b1;    
         stp_chk_en_FSM       ='b0;     
         data_valid_FSM       ='b0;     
         deser_en_FSM         ='b0;
         par_chk_en_FSM       ='b0;
              end         

   DATA: begin
         dat_samp_en_FSM      ='b1;    
         enable_edge_bit_FSM  ='b1;
         strt_chk_en_FSM      ='b0;    
         stp_chk_en_FSM       ='b0;     
         data_valid_FSM       ='b0;     
         par_chk_en_FSM       ='b0;     
                deser_en_FSM  ='b1;
            end         
      
 PARITY: begin
         dat_samp_en_FSM     ='b1;    
         enable_edge_bit_FSM ='b1;
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b0;     
         deser_en_FSM        ='b0;     
              par_chk_en_FSM ='b1;     
          end

  STOP: begin
         dat_samp_en_FSM     ='b1;    
         enable_edge_bit_FSM ='b1;    
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b1;     
         deser_en_FSM        ='b0;
         par_chk_en_FSM      ='b0;
           end

 ERR_CHK: begin
         dat_samp_en_FSM     ='b1;    
         enable_edge_bit_FSM ='b0;
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b0;     
         deser_en_FSM        ='b0;     
              par_chk_en_FSM ='b0;
          end

 VALID :  begin
         dat_samp_en_FSM     ='b0;    
         enable_edge_bit_FSM ='b0;
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b1;     
         deser_en_FSM        ='b0;     
         par_chk_en_FSM ='b0;     
         
          end         

default: begin
         dat_samp_en_FSM     ='b0;    
         enable_edge_bit_FSM ='b0;
         par_chk_en_FSM      ='b0;     
         strt_chk_en_FSM     ='b0;    
         stp_chk_en_FSM      ='b0;     
         data_valid_FSM      ='b0;     
         deser_en_FSM        ='b0;  
           end

    endcase
   end
endmodule
