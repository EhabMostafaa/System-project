//THIS TESTBENCH assume we work im Prescale *8*  //

`timescale 1ns/1ps
module TEST_BENCH_URT_RX;
 
  reg            CLK_TB;
  reg            RST_TB;
  reg            RX_IN_TB;
  reg            PAR_EN_TB;
  reg            PAR_TYP_TB;
  reg   [4:0]    Prescale_TB;

  wire  [7:0]    P_DATA_TB;
  wire           data_valid_TB;

  parameter CLOCK=10 ;              //edge CLOCk
  parameter BIT_CLOCK=80 ;          //bit CLOCK


initial
   begin
       
       $dumpfile("URT_RX.vcd");
       $dumpvars;
   
  initalize();
  reset();


//////////////////// case1 ///////////////////////////////////
  //data 0-1010_0010-0-1
  Prescale_TB='d8;
  RX_IN_TB   ='b0;
  PAR_EN_TB  ='b1;
  PAR_TYP_TB ='b1;
  
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;  
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;

@(posedge data_valid_TB)
begin
if(P_DATA_TB==8'b0100_0101)
$display ("case 1 CORRECT time=%0t   ,data_valid =%b     ,P_DATA=%b    ",$time,data_valid_TB,P_DATA_TB);
else
$display ("case 1 FALSE   time=%0t  ,data_valid =%b     ,P_DATA=%b      ",$time,data_valid_TB,P_DATA_TB);
end

  //data 0-0110_1011-1-1
  RX_IN_TB   ='b0;
  PAR_EN_TB  ='b1;
  PAR_TYP_TB ='b0;

#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b1;  
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b0;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;
  RX_IN_TB   ='b1;
#BIT_CLOCK;

@(posedge data_valid_TB)
begin
if(P_DATA_TB==8'b1101_0110)
$display ("case 2 CORRECT time=%0t   ,data_valid =%b     ,P_DATA=%b    ",$time,data_valid_TB,P_DATA_TB);
else
$display ("case 2 FALSE   time=%0t  ,data_valid =%b     ,P_DATA=%b      ",$time,data_valid_TB,P_DATA_TB);
end

#BIT_CLOCK;
#BIT_CLOCK;
#BIT_CLOCK;
#BIT_CLOCK; 
$stop; 
end

//initializatiom
task initalize();
  begin
CLK_TB='b0;
RX_IN_TB='b1;
PAR_EN_TB='b0;
PAR_TYP_TB='b0;
Prescale_TB='b0;
  end
endtask

//reset configuration
task reset();
   begin
RST_TB='b1;
#CLOCK;
RST_TB='b0;
#CLOCK;
RST_TB='b1;
#CLOCK;
   end
endtask

//CLOCK GENERATOR
always #(CLOCK/2) CLK_TB=~CLK_TB;

//TOP INSTANTATION
TOP_URT_RX u_TOP_URT_RX(
    .CLK_TOP        (CLK_TB        ),
    .RST_TOP        (RST_TB        ),
    .RX_IN_TOP      (RX_IN_TB      ),
    .PAR_EN_TOP     (PAR_EN_TB     ),
    .PAR_TYP_TOP    (PAR_TYP_TB    ),
    .Prescale_TOP   (Prescale_TB   ),
    .P_DATA_TOP     (P_DATA_TB     ),
    .data_valid_TOP (data_valid_TB )
);

endmodule
