module TX_CTRL_SYS #(parameter DATA_WIDTH=8,
                               ALU_OUT_WIDTH=16       )
     (  
       input   wire                            CLK,
       input   wire                            RST,

       input   wire                            Rd_D_Vld,
       input   wire     [DATA_WIDTH-1:0]       Rd_Data,

       input   wire                            ALU_OUT_Valid, 
       input   wire     [ALU_OUT_WIDTH-1:0]    ALU_OUT,
       
       input   wire                            TX_Busy, 
      
       output  reg      [DATA_WIDTH-1:0]       OUT_TX_CTRL_SYS,    
       output  reg                             TX_CTRL_Valid
    );                                                                                                                             
                                                                                               
localparam IDLE           ='b000,
           RegF_TX        ='b001,
           ALU_TX_Packet1 ='b011,
           Wait           ='b111,
           ALU_TX_Packet2 ='b110; 

reg  [2:0]  current_state, next_state;
wire [1:0]  flag_valids;

assign flag_valids={Rd_D_Vld,ALU_OUT_Valid};

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


always@(*)
   begin
        OUT_TX_CTRL_SYS ='b0;   
        TX_CTRL_Valid   ='b0;

    case(current_state)
        IDLE    :begin
                   if(!TX_Busy)
                          begin
                 OUT_TX_CTRL_SYS ='b0;   
                 TX_CTRL_Valid   ='b0;

                   case (flag_valids)
                      'b10:begin
                            next_state=RegF_TX;
                          end

                      'b01:begin
                             next_state=ALU_TX_Packet1;
                          end
 
                      default:begin
                              next_state=IDLE;
                            end 
                      endcase 
                     end  

                   else
                      begin
                            next_state=IDLE;
                      end 
                   end                

        RegF_TX  :begin
                    OUT_TX_CTRL_SYS = Rd_Data;   
                    TX_CTRL_Valid   ='b1     ;       
                        if(TX_Busy)
                          begin
                            next_state=IDLE;
                          end
                        else 
                          begin
                            next_state=RegF_TX;
                          end
                     end 
       
        ALU_TX_Packet1:begin
                    OUT_TX_CTRL_SYS = ALU_OUT[DATA_WIDTH-1:0];   
                    TX_CTRL_Valid   ='b1     ;    
                         if(TX_Busy)
                          begin
                            next_state=Wait;
                          end
                        else 
                          begin
                            next_state=ALU_TX_Packet1;
                          end 
                     end
     
         Wait    :begin
                     if(TX_Busy)
                          begin
                            next_state=Wait;
                          end
                        else 
                          begin
                            next_state=ALU_TX_Packet2;
                          end 
                   end
        ALU_TX_Packet2: begin
                     OUT_TX_CTRL_SYS = ALU_OUT[ALU_OUT_WIDTH-1:DATA_WIDTH];   
                     TX_CTRL_Valid   ='b1     ;    
                         if(TX_Busy)
                          begin
                            next_state=IDLE;
                          end
                        else 
                          begin
                            next_state=ALU_TX_Packet2;
                          end 
                       end

       default         :begin
                     OUT_TX_CTRL_SYS ='b0;   
                     TX_CTRL_Valid   ='b0;    
                     next_state      =IDLE;   
                        end         
    endcase   
   end


endmodule