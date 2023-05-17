`timescale 1ns/1ps
module SYS_testbench ;

// ports
reg          REF_CLK_tb;
reg          UART_CLK_tb;
reg          RST_tb;
reg          S_DATA_IN_RX_tb;

wire         S_DATA_OUT_TX_tb;



//parameters of clock
parameter   REF_CLOCK =20;
parameter   UART_CLOCK=100; 

//parameters of module
parameter  DATA_WIDTH_tb         =8 ;
parameter  URT_PRESCALE_WIDTH_tb =5 ;
parameter  ALU_OUT_WIDTH_tb      =2*DATA_WIDTH_tb;
parameter  NUM_OF_ALU_INST_tb    =14 ;
parameter  ALU_FUNC_WIDTH_tb     =$clog2(NUM_OF_ALU_INST_tb) ;
parameter  NUM_OF_REGISTERS_tb   =16 ;
parameter  ADDRESS_WIDTH_tb      =$clog2(NUM_OF_REGISTERS_tb) ;




parameter WR_NUM_OF_FRAMES = 3 ;
parameter RD_NUM_OF_FRAMES = 2 ;
parameter ALU_WP_NUM_OF_FRAMES = 4 ;
parameter ALU_NP_NUM_OF_FRAMES = 2 ; 

reg   [WR_NUM_OF_FRAMES*11-1:0]       WR_CMD     = 'b10_01110111_0_10_00000101_0_10_10101010_0 ;
reg   [RD_NUM_OF_FRAMES*11-1:0]       RD_CMD     = 'b10_00000101_0_10_10111011_0;
reg   [ALU_WP_NUM_OF_FRAMES*11-1:0]   ALU_WP_CMD = 'b11_00000001_0_10_00000011_0_10_00000101_0_10_11001100_0 ;
reg   [ALU_NP_NUM_OF_FRAMES*11-1:0]   ALU_NP_CMD = 'b11_00000001_0_10_11011101_0 ;

reg   [WR_NUM_OF_FRAMES*11-1:0]       WR_CMD_A     = 'b10_01110111_0_10_00000000_0_10_10101010_0 ;
reg   [WR_NUM_OF_FRAMES*11-1:0]       WR_CMD_B     = 'b10_10000010_0_11_00000001_0_10_10101010_0 ;


reg                         TX_CLK_TB;
reg                         Data_Stimulus_En;
reg   [10:0]                 count = 6'b0 ;







initial 
begin

$dumpfile("SYSTEM.vcd");
$dumpvars;

initialize();
reset();

#400
#20 
Data_Stimulus_En = 1'b1 ;
#400000
$stop;

end






always @ (posedge u_TOP_SYS.u_CLOCK_DIVIDER_SYS.o_div_clk)
 begin
  if(Data_Stimulus_En)
      begin
      
        if(count < 'd33)
            begin
                S_DATA_IN_RX_tb <=  WR_CMD[count] ;
	            count <= count + 'b1 ;
             end
             	
        else if(count < 'd34)
            begin    
	            count <= count + 'b1 ;
            end
            	
        else if(count < 'd56 )
            begin
                S_DATA_IN_RX_tb <=  RD_CMD[count-34] ;
	            count <= count + 'b1 ;
             end
             
        else if(count < 'd57)
            begin    
	            count <= count + 'b1 ;
            end

            	
         else if(count < 'd90 )
            begin
                S_DATA_IN_RX_tb <=  WR_CMD_A[count-57] ;
	            count <= count + 'b1 ;
             end 

        else if(count < 'd91)
            begin    
	            count <= count + 'b1 ;
             end
             
        else if(count < 'd124)
            begin
                S_DATA_IN_RX_tb <=  WR_CMD_B[count-91] ;
	            count <= count + 'b1 ;
             end
             

        else if(count < 'd125)
            begin    
	            count <= count + 'b1 ;
             end
              
             
        else if(count < 'd147)
            begin
                S_DATA_IN_RX_tb <=  ALU_NP_CMD[count-125] ;
	            count <= count + 'b1 ;
             end
            	                          
        end         
  else
    S_DATA_IN_RX_tb <= 1'b1 ;  
  end






//initialiaze task
task initialize();
  begin 
REF_CLK_tb='b0;
UART_CLK_tb='b0;
//S_DATA_IN_RX_tb='b0;
TX_CLK_TB='b0;
  end
  endtask


//reset task
task reset();
  begin
RST_tb='b1;
#5;
RST_tb='b0;
#5;
RST_tb='b1;
#5;
  end
endtask



//clock generator
always  #(REF_CLOCK/2)   REF_CLK_tb=~REF_CLK_tb;
always  #(UART_CLOCK/2)  UART_CLK_tb=~UART_CLK_tb;     
    

//module instantation
  TOP_SYS  u_TOP_SYS(
  	.REF_CLK       (REF_CLK_tb       ),
    .UART_CLK      (UART_CLK_tb      ),
    .RST           (RST_tb           ),
    .S_DATA_IN_RX  (S_DATA_IN_RX_tb  ),
    .S_DATA_OUT_TX (S_DATA_OUT_TX_tb )
  );
  
endmodule