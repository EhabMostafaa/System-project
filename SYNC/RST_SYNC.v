module RST_SYNC_SYS (
    input   wire        CLK,
    input   wire        RST,

    output  reg         SYNC_RST
     );
     
    reg      stage; 

always @(posedge CLK or negedge RST ) 
   begin
     if(!RST)
       begin
        SYNC_RST<='b0;
        stage<='b0;
       end
     else
       begin
         stage<='b1;
         SYNC_RST<=stage; 
       end
   end
endmodule