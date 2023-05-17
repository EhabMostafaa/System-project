
module TOP_uart_tx #(parameter DATA_SIZE_top=8)( 
     input   wire                            CLK_top,
     input   wire                            RST_top,
     input   wire     [DATA_SIZE_top-1:0]    P_DATA_top,
     input   wire                            Data_Valid_top,
     input   wire                            PAR_EN_top,
     input   wire                            PAR_TYP_top,

     output  wire                            TX_OUT_top,
     output  wire                            Busy_top);

//internal wires
wire         ser_en_top;   
wire         ser_data_top;
wire         ser_done_top;
wire [1:0]   mux_sel_top;
wire         par_bit_top;

parityCalic_uart_tx 
#(
    .DATA_SIZE (DATA_SIZE_top )
)
u_parityCalic_uart_tx(
    .P_DATA_PAR     (P_DATA_top     ),
    .Data_valid_PAR (Data_Valid_top ),
    .PAR_TYP_PAR    (PAR_TYP_top    ),
    .CLK_PAR        (CLK_top        ),
    .RST_PAR        (RST_top        ),
    .par_bit_PAR    (par_bit_top    )
);

mux_uart_tx u_mux_uart_tx(
    .CLK_MUX      (CLK_top      ),
    .RST_MUX      (RST_top      ),
    .mux_sel_MUX  (mux_sel_top  ),
    .ser_data_MUX (ser_data_top ),
    .par_bit_MUX  (par_bit_top  ),
    .TX_OUT_MUX   (TX_OUT_top   )
);



seriallizer_uart_tx 
#(
    .DATA_SIZE (DATA_SIZE_top )
)
u_seriallizer_uart_tx(
    .CLK_SER        (CLK_top        ),
    .RST_SER        (RST_top        ),
    .P_DATA_SER     (P_DATA_top     ),
    .ser_en_SER     (ser_en_top     ),
    .Busy_SER       (Busy_top       ),
    .Data_Valid_SER (Data_Valid_top ),
    .ser_data_SER   (ser_data_top   ),
    .ser_done_SER   (ser_done_top   )
);


fsm_uart_tx 
#(
    .DATA_SIZE (DATA_SIZE_top )
    )
u_fsm_uart_tx(
    .CLK_FSM        (CLK_top        ),
    .RST_FSM        (RST_top        ),
    .Data_Valid_FSM (Data_Valid_top ),
    .PAR_EN_FSM     (PAR_EN_top     ),
    .ser_done_FSM   (ser_done_top   ), 
    .mux_sel_FSM    (mux_sel_top    ),
    .ser_en_FSM     (ser_en_top     ),
    .Busy_FSM       (Busy_top)
);

endmodule

