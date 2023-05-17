module RX_CTRL_SYS #(parameter DATA_WIDTH=8,
                               NUM_OF_ALU_INST=14 , ALU_FUNC_WIDTH=$clog2(NUM_OF_ALU_INST),
                               NUM_OF_REGISTERS=16, ADDRESS_WIDTH=$clog2(NUM_OF_REGISTERS))
   (
    input   wire                                     CLK,
    input   wire                                     RST,
    input   wire   [DATA_WIDTH-1:0]                  RX_P_DATA,
    input   wire                                     RX_DATA_VLD,
    
    input   wire                                     ALU_OUT_Valid,
//  input   wire                                     Rd_D_VLD,          /// !!!

    output  reg                                      WrEn,
    output  reg                                      RdEn,
    output  reg    [ADDRESS_WIDTH-1:0]               Addr,
    output  reg    [DATA_WIDTH-1:0]                  Wr_D,

    output reg                                       Gate_EN,

    output reg     [ALU_FUNC_WIDTH-1:0]              ALU_FUNC,
    output reg                                       ALU_EN     
     );
   
   //states of FSM
localparam  IDLE       =3'b000 ,
            RF_Wr_Addr =3'b001 ,
            RF_Wr_Data =3'b011 ,
            RF_Rd_Addr =3'b111 ,
            Wr_Oper_A  =3'b110 ,
            Wr_Oper_B  =3'b100 ,
            Wr_alu_fun =3'b101 ;

reg [2:0]                current_state , next_state ;
reg  [DATA_WIDTH-1:0]    data_saved;
reg                      Save_En; 


always @(posedge CLK or negedge RST )
  begin
     if(!RST)
       begin
         current_state<='b0;
       end
    else
       begin
         current_state<=next_state;
       end 
  end

always @(posedge CLK or negedge RST )
begin
      if (!RST) begin
        data_saved<='b0;
    end else if(Save_En) begin
        data_saved<=RX_P_DATA;
    end

end

// combinational always to determine the state
always@(*)
  begin
                WrEn     ='b0;    
                RdEn     ='b0;
                Wr_D     ='b0;
                Gate_EN  ='b0;
                ALU_FUNC ='b0;
                Save_En  ='b0;
                ALU_EN   ='b0;
                Addr     =data_saved;

                                       
   case (current_state)           
      IDLE       : begin              
               if(RX_DATA_VLD)                           
                  begin                               
                    case(RX_P_DATA)

                       'hAA  : begin
                        next_state=RF_Wr_Addr ;             
                                end

                       'hBB  :  begin
                        next_state=RF_Rd_Addr ; 
                                end

                       'hCC  :  begin
                         next_state=Wr_Oper_A  ;
                                  end

                       'hDD  :  begin 
                        next_state=Wr_alu_fun ;
                        Gate_EN  ='b1;
                              end

                       default: begin
                        next_state=IDLE      ; 
                                end 
                     endcase                           
                  end                                   
              else                                    
                    begin                                
                       next_state=IDLE ;                    
                     end   
                 end
                                                                                            
      RF_Wr_Addr : begin
                    if(RX_DATA_VLD)
                      begin
                        Save_En   ='b1;
                        next_state=RF_Wr_Data ;
                      end
                   else
                      begin
                        next_state=RF_Wr_Addr;   
                      end   
                   end
                                                                
      RF_Wr_Data : begin
                    if(RX_DATA_VLD)
                       begin
                        WrEn      ='b1;
                        Addr      =data_saved;
                        Wr_D      =RX_P_DATA;                                   
                        next_state=IDLE;   
                       end
                    else
                       begin
                        next_state=RF_Wr_Data;   
                       end   
                  end
/*
      RF_Rd_Addr : begin
                     if(RX_DATA_VLD)
                       begin     
                       RdEn      ='b1;
                       Addr      =RX_P_DATA;
                      if(Rd_D_VLD)
                          begin
                           next_state=IDLE;   
                          end
                      else
                          begin
                           next_state=RF_Rd_Addr;
                          end  
                       end  
         
                    else
                       begin
                       next_state=RF_Rd_Addr;   
                       end            
                   end                      
*/

      RF_Rd_Addr : begin
                     if(RX_DATA_VLD)
                       begin     
                       RdEn      ='b1;
                       Addr      =RX_P_DATA;
                       next_state=IDLE;   
                          end
                    else
                       begin
                       next_state=RF_Rd_Addr;   
                       end            
      end


      Wr_Oper_A : begin
                     if(RX_DATA_VLD)
                       begin
                       WrEn      ='b1;    
                       Addr      ='b0;
                       Wr_D      = RX_P_DATA;
                       next_state= Wr_Oper_B;   
                       end
                     else
                       begin
                       next_state=Wr_Oper_A;   
                       end            
                   end     
 
      Wr_Oper_B : begin
                     if(RX_DATA_VLD)
                       begin
                       WrEn      = 'b1;    
                       Addr      = 'd1;
                       Wr_D      = RX_P_DATA;
                       Gate_EN   ='b1;                
                       next_state= Wr_alu_fun;   
                       end
                     else
                       begin
                       next_state= Wr_Oper_B;   
                       end            
                   end                                        

      Wr_alu_fun : begin
                     if(RX_DATA_VLD)
                       begin

                              Gate_EN  ='b1;
                              ALU_FUNC =RX_P_DATA;
                              ALU_EN   ='b1;  
                        
                        if(ALU_OUT_Valid)
                            begin
                              next_state=IDLE;
                            end
                        else
                            begin
                               next_state=Wr_alu_fun;   
                            end
                       end
                     else
                       begin
                       next_state=Wr_alu_fun;   
                       end            
                   end     

      default    : begin
                     next_state=IDLE;       
                      WrEn     ='b0;    
                      RdEn     ='b0;
                      Addr     ='b0;
                      Wr_D     ='b0;
                      Gate_EN  ='b0;
                      ALU_FUNC ='b0;
                      ALU_EN   ='b0;
                    end      
            endcase
       end
         
endmodule