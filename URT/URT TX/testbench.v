`timescale 1ns/1ps
module TOP_uart_tx_tb ;

//parameters
parameter   CLOCK_PERIOD = 50;
parameter   DATA_SIZE_tb =8;

//ports
reg                           CLK_tb;
reg                           RST_tb;
reg  [DATA_SIZE_tb-1:0]       P_DATA_tb;
reg                           Data_Valid_tb;
reg                           PAR_EN_tb;
reg                           PAR_TYP_tb;

wire                          TX_OUT_tb;
wire                          Busy_tb;





initial
 begin

$dumpfile("URT_TX.vcd");
$dumpvars;

//initial values
initialize();

//reset config
reset();    

/////////////////////////////////////case to check it is in idle case ////////////////////
$display("/n 1st case to check trasmitted bit in idle case ");
#CLOCK_PERIOD;
if(TX_OUT_tb && !Busy_tb)
 $display("1st case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("1st case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
/////////////////////////////////////case 2 to check start bit //////////////////////////////
//transmitted Data =8'b1001_1101

$display("/n 2nd case to check start bit in transmititon operation ");
P_DATA_tb=8'b1001_1101;
Data_Valid_tb='b1;
PAR_EN_tb='b1;
PAR_TYP_tb='b0;

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("2nd case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("2nd case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 3 to check first bit in data transmitted //////////////////////////////

$display("/n 3rd case to check first bit in data transmitted ");
Data_Valid_tb='b0;
#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("3rd case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("3rdd case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 4 to check second bit in data transmitted //////////////////////////////

$display("/n 4th case to check second bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
$display("4th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("4th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 5 to check third bit in data transmitted //////////////////////////////

$display("/n 5th case to check 3rd bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("5th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("5th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 6 to check fourth bit in data transmitted //////////////////////////////

$display("/n 6th case to check 4th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("6th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("6th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 7 to check fifth bit in data transmitted //////////////////////////////

$display("/n 7th case to check 5th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("7th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("7th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 8 to check sixth bit in data transmitted //////////////////////////////

$display("/n 8th case to check 6th bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("6th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("6th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);




/////////////////////////////////////case 9 to check seventh bit in data transmitted //////////////////////////////

$display("/n 9th case to check 7th bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("9th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("9th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);



/////////////////////////////////////case 10 to check eigth bit in data transmitted //////////////////////////////

$display("/n 10th case to check 8th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("10th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("10th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 11 to check parity bit in data transmitted //////////////////////////////

$display("/n 11th case to check parity bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("11th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("11th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 12 to check stop bit in data transmitted //////////////////////////////

$display("/n 12th case to check stop bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("12th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("12th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 13 to check idle after transmitting //////////////////////////////

$display("/n 13th case to check idle after transmitting");

#CLOCK_PERIOD;
if(TX_OUT_tb && !Busy_tb)
 $display("13th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("13th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);







//////////////////////////////////////////////////////test another packet of data with odd parity ////////////////////////////////
//transmitted packet  8'b1101_0011 

P_DATA_tb=8'b1101_0011;
Data_Valid_tb='b1;
PAR_EN_tb='b1;
PAR_TYP_tb='b1;

$display("/n 14th case to check start bit in transmititon operation ");
#CLOCK_PERIOD;

if(!TX_OUT_tb && Busy_tb)
 $display("14th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("14th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 15 to check first bit in data transmitted //////////////////////////////

$display("/n 15th case to check first bit in data transmitted ");
Data_Valid_tb='b0;
#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("15th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("15th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 16 to check second bit in data transmitted //////////////////////////////

$display("/n 16th case to check second bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
$display("16th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("16th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 17 to check third bit in data transmitted //////////////////////////////

$display("/n 17th case to check 3rd bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("17th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("17th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);

/////////////////////////////////////case 18 to check fourth bit in data transmitted //////////////////////////////

$display("/n 18th case to check 4th bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("18th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("18th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 19 to check fifth bit in data transmitted //////////////////////////////

$display("/n 19th case to check 5th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("19th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("19th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);



//////////////try enter anothet packet while channel is busy /////////////////////


P_DATA_tb=8'b1101_0011;
Data_Valid_tb='b1;
PAR_EN_tb='b1;
PAR_TYP_tb='b1;

//expected is still send old data and igorning new packet

/////////////////////////////////////case 20 to check sixth bit in data transmitted //////////////////////////////

$display("/n 20th case to check 6th bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("20th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("20th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);




/////////////////////////////////////case 21 to check seventh bit in data transmitted //////////////////////////////

$display("/n 21th case to check 7th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("21th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("21th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);



/////////////////////////////////////case 22th to check eigth bit in data transmitted //////////////////////////////

$display("/n 22th case to check 8th bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("22th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("22th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 23 to check parity bit in data transmitted //////////////////////////////

$display("/n 23th case to check parity bit in data transmitted ");

#CLOCK_PERIOD;
if(!TX_OUT_tb && Busy_tb)
 $display("23th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("23th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 24 to check stop bit in data transmitted //////////////////////////////

$display("/n 24th case to check stop bit in data transmitted ");

#CLOCK_PERIOD;
if(TX_OUT_tb && Busy_tb)
 $display("24th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("24th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


/////////////////////////////////////case 25 to check idle after transmitting //////////////////////////////

$display("/n 25th case to check idle after transmitting");

#CLOCK_PERIOD;
if(TX_OUT_tb && !Busy_tb)
 $display("25th case CORRECT ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);
else
$display("25th case FALSE ,RST=%b ,P_DATA=%b ,Data_Valid=%b ,PAR_EN=%b ,PAR_TYP=%b ,TX_OUT=%b ,Busy=%b",RST_tb,P_DATA_tb,Data_Valid_tb,PAR_EN_tb,PAR_TYP_tb,TX_OUT_tb,Busy_tb);


#CLOCK_PERIOD;
#CLOCK_PERIOD;
$stop;


end

//initial values
task initialize ;
   begin
CLK_tb='b0;
P_DATA_tb='b0;
Data_Valid_tb='b0;
PAR_EN_tb='b0;
PAR_TYP_tb='b0;
   end
endtask


task reset;
     begin
RST_tb='b1;
#CLOCK_PERIOD;
RST_tb='b0;
#CLOCK_PERIOD;
RST_tb='b1;
     end
endtask



//clock generation
always #(CLOCK_PERIOD/2)  CLK_tb=~CLK_tb;

//module instantation
TOP_uart_tx 
#(
    .DATA_SIZE_top (DATA_SIZE_tb)
)
u_TOP_uart_tx(
    .CLK_top        (CLK_tb      ),
    .RST_top        (RST_tb        ),
    .P_DATA_top     (P_DATA_tb     ),
    .Data_Valid_top (Data_Valid_tb ),
    .PAR_EN_top     (PAR_EN_tb     ),
    .PAR_TYP_top    (PAR_TYP_tb    ),
    .TX_OUT_top     (TX_OUT_tb     ),
    .Busy_top       (Busy_tb       )
);

endmodule