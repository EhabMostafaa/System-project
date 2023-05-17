module UART #(parameter  DATA_WIDTH = 8 , PRESCALE_WIDTH = 5  )
  (   
      input     wire                          RST,
      input     wire                          TX_CLK,
      input     wire   [DATA_WIDTH-1:0]       TX_IN_P,
      input     wire                          TX_IN_Valid,

      output    wire                          TX_OUT_S,
      output    wire                          TX_OUT_BUSY,
         

       input    wire                          RX_CLK,
       input    wire                          RX_IN_S,
       input    wire  [PRESCALE_WIDTH-1:0]    RX_IN_PRESCALE,
       
       output   wire  [DATA_WIDTH-1:0]        RX_OUT_P,
       output   wire                          RX_OUT_valid,

       input     wire                          UART_parity_enable,
       input     wire                          UART_parity_type

);




TOP_uart_tx 
#(
    .DATA_SIZE_top (DATA_WIDTH )
)
u_TOP_uart_tx(
    .CLK_top        (TX_CLK        ),
    .RST_top        (RST        ),
    .P_DATA_top     (TX_IN_P     ),
    .Data_Valid_top (TX_IN_Valid ),
    .PAR_EN_top     (UART_parity_enable     ),
    .PAR_TYP_top    (UART_parity_type    ),
    .TX_OUT_top     (TX_OUT_S     ),            
    .Busy_top       (TX_OUT_BUSY       )             
);




TOP_URT_RX 
#(
    .DATA_WIDTH_TOP (DATA_WIDTH ),
    .PRESCALE_WIDTH_TOP(PRESCALE_WIDTH)
)
u_TOP_URT_RX(
    .CLK_TOP        (RX_CLK        ),
    .RST_TOP        (RST        ),
    .RX_IN_TOP      (RX_IN_S      ),
    .PAR_EN_TOP     (UART_parity_enable    ),
    .PAR_TYP_TOP    (UART_parity_type ),
    .Prescale_TOP   (RX_IN_PRESCALE   ),
    .P_DATA_TOP     (RX_OUT_P     ),
    .data_valid_TOP (RX_OUT_valid )
);

endmodule