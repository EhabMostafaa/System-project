module CLK_GATE_SYS (
input   wire        CLK_EN,
input   wire        CLK,

output  wire        GATED_CLK
   );
 


reg Latch_enable;

always @(CLK or CLK_EN)
   begin
     if(!CLK)         //active low latch
       Latch_enable<= CLK_EN;
     else 
       Latch_enable<=Latch_enable;
   end

assign GATED_CLK = Latch_enable && CLK;

 /*

TLATNCAX2M U0(
.CK(CLK),
.E(test_mode||CLK_EN),
.ECK(GATED_CLK)

 );
 */

endmodule

