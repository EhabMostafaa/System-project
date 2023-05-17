
module fsm_uart_tx #(parameter DATA_SIZE=8)( 
    input   wire                     CLK_FSM,
	  input   wire                     RST_FSM,
	  input   wire                     Data_Valid_FSM,
    input   wire                     PAR_EN_FSM,
    input   wire                     ser_done_FSM,

    output  reg     [1:0]            mux_sel_FSM,
    output  reg                      ser_en_FSM,
	  output  reg                      Busy_FSM );

localparam  IDLE   =3'b000,
            START  =3'b001,
            DATA   =3'b010,
            PARITY =3'b011,
            STOP   =3'b100  ;

//fsm registers
reg  [2:0]  current_state,next_state;
reg         Busy_comb;

always @(posedge CLK_FSM or negedge RST_FSM )
 begin
if(!RST_FSM)
   begin
     current_state<=IDLE;
     Busy_FSM<='b0;
   end
 else 
  begin
    current_state<=next_state;
    Busy_FSM<=Busy_comb;
  end
end

always @(*)
  begin
      //initial values
             mux_sel_FSM ='b11;
             ser_en_FSM  ='b0;
             Busy_comb   ='b0;
          
    case(current_state)
  
    IDLE   :begin
             mux_sel_FSM ='b11;
             ser_en_FSM  ='b0;
             Busy_comb   ='b0;
           if (Data_Valid_FSM)
             begin
             Busy_comb   ='b1;
             next_state=START;
             mux_sel_FSM ='b00;
             end
           else
             begin
             Busy_comb   ='b0; 
             next_state=IDLE;
             end
            end     

    START :begin
             mux_sel_FSM ='b01;
             ser_en_FSM  ='b0;
             Busy_comb   ='b1;
             next_state  =DATA;             
     
          end

    DATA  :begin
             mux_sel_FSM ='b01;
             ser_en_FSM  ='b1;
             Busy_comb   ='b1;

           if(ser_done_FSM && PAR_EN_FSM)
           begin
             next_state =PARITY;
             mux_sel_FSM ='b10;
           end
           else if (ser_done_FSM && !PAR_EN_FSM)
           begin
             next_state =STOP;
             
           end

           else
              begin    
             next_state =DATA;
             
           end
         end

    PARITY:begin
             mux_sel_FSM ='b11;
             ser_en_FSM  ='b0;
             Busy_comb   ='b1;
             next_state  =STOP;
           end

    STOP  :begin
             mux_sel_FSM ='b11;
             ser_en_FSM  ='b0;
             Busy_comb   ='b0;
             next_state  =IDLE;
            end
    endcase
  end
endmodule         
           


