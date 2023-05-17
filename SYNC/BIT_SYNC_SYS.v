module BIT_SYNC_SYS #(parameter DATA_WIDTH=1 , NUM_STAGES=2)
   ( input  wire                       CLK,
     input  wire                       RST,
     input  wire   [DATA_WIDTH-1:0]    ASYNC,

     output reg    [DATA_WIDTH-1:0]    SYNC 
   );



 
reg  stage;

always @(posedge CLK or negedge RST) 
   begin
     if(!RST)
       begin
        SYNC  <='b0;
        stage <='b0;
       end
     else  
       begin
        stage<=ASYNC;
        SYNC <=stage;
       end          
    end
endmodule

















//parameterized
/*
reg [NUM_STAGES-1:0]  stages;
integer I;

always @(posedge CLK or negedge RST )
  begin
     if(!RST)
        begin
          SYNC<='b0;        
        end  
     else 
        begin
            stages[0] <= ASYNC;
         for ( I=0 ;I<NUM_STAGES ;I=I+1 )
           begin
             stages[I+1]<=stages[I];   
           end
            SYNC<=stages[I-1]; 
        end    
  end

endmodule
*/