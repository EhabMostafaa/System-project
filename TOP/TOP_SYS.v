module TOP_SYS #(parameter DATA_WIDTH =8 , ALU_OUT_WIDTH=16,
                           NUM_OF_ALU_INST=14 , ALU_FUNC_WIDTH=$clog2(NUM_OF_ALU_INST),
                           NUM_OF_REGISTERS=16, ADDRESS_WIDTH=$clog2(NUM_OF_REGISTERS) ) 
     (
        input  wire                             REF_CLK,
        input  wire                             UART_CLK,
        input  wire                             RST,
        input  wire                             S_DATA_IN_RX,
       
        output wire                             S_DATA_OUT_TX
      );




// signals due to uart tx
    wire                            TX_CLK_SYS;
    wire        [DATA_WIDTH-1:0]    TX_IN_P_SYS;
    wire                            data_sync_enable;
    wire                            tx_async_out_busy;
    wire                            tx_sync_out_busy;

//signals due to uart rx
    wire       [DATA_WIDTH-1:0]     REG0,REG1,REG2,REG3;
    wire       [DATA_WIDTH-1:0]     RX_OUT_P_SYS;
    wire                            RX_OUT_valid;   

//signals between data_sync  >> system control
    wire       [DATA_WIDTH-1:0]     RX_OUT_P_sync;
    wire                            data_sync_valid;                    

// signals between system control >> RegFile
wire                                Rd_D_Vld;
wire       [DATA_WIDTH-1:0]         Rd_D;
wire                                WrEn;
wire                                RdEn;
wire       [ADDRESS_WIDTH-1:0]      Addr;
wire                                Gate_EN;                     

//signals between system control >> ALU 
wire       [ALU_FUNC_WIDTH-1:0]     ALU_FUNC;
wire                                ALU_EN;
wire       [ALU_OUT_WIDTH-1:0]      ALU_OUT;
wire                                ALU_CLK;
wire                                ALU_OUT_Valid;
//signals between system control tx >> data sync
wire       [DATA_WIDTH-1:0]         OUT_TX_CTRL_async;
wire                                TX_CTRL_Valid_async; 

//signals due to RegFile
wire       [DATA_WIDTH-1:0]         Wr_D;                    

//signals due to RST SYNC
wire                                SYNC_RST1;
wire                                SYNC_RST2;


UART u_UART(                                                //finish
    .RST                (SYNC_RST2           ),
    .TX_CLK             (TX_CLK_SYS          ),
    .TX_IN_P            (TX_IN_P_SYS         ),
    .TX_IN_Valid        (data_sync_enable    ),
    .TX_OUT_S           (S_DATA_OUT_TX       ),
    .TX_OUT_BUSY        (tx_async_out_busy   ),        
    .RX_CLK             (UART_CLK            ),
    .RX_IN_S            (S_DATA_IN_RX        ),
    .RX_IN_PRESCALE     (REG2[6:2]           ),
    .RX_OUT_P           (RX_OUT_P_SYS        ),
    .RX_OUT_valid       (RX_OUT_valid        ),
    .UART_parity_enable (REG2[0]             ),
    .UART_parity_type   (REG2[1]             )
);

BIT_SYNC_SYS   u_BIT_SYNC_SYS(                                   //finish
    .CLK   (REF_CLK   ),
    .RST   (SYNC_RST1   ),
    .ASYNC (tx_async_out_busy ),
    .SYNC  (tx_sync_out_busy  )
);


DATA_SYNC_SYS     u_DATA_SYNC_SYS_RX(                       //finish
    .CLK          (REF_CLK          ),
    .RST          (SYNC_RST1          ),
    .bus_enable   (RX_OUT_valid   ),
    .unsync_bus   (RX_OUT_P_SYS   ),
    .sync_bus     (RX_OUT_P_sync     ),
    .enable_pulse (data_sync_valid )
);



RX_CTRL_SYS                                                   //finish 
#(
    .DATA_WIDTH       (DATA_WIDTH       ),
    .NUM_OF_ALU_INST  (NUM_OF_ALU_INST  ),
    .ALU_FUNC_WIDTH   (ALU_FUNC_WIDTH   ),
    .NUM_OF_REGISTERS (NUM_OF_REGISTERS ),
    .ADDRESS_WIDTH    (ADDRESS_WIDTH    )
)
u_RX_CTRL_SYS(
    .CLK           (REF_CLK           ),
    .RST           (SYNC_RST1           ),
    .RX_P_DATA     (RX_OUT_P_sync     ),
    .RX_DATA_VLD   (data_sync_valid   ),
    .ALU_OUT_Valid (ALU_OUT_Valid ),
    .WrEn          (WrEn          ),
    .RdEn          (RdEn          ),
    .Addr          (Addr          ),    
    .Wr_D          (Wr_D          ),
    .Gate_EN       (Gate_EN       ),
    .ALU_FUNC      (ALU_FUNC      ),
    .ALU_EN        (ALU_EN        )
);


TX_CTRL_SYS                                                     //finish
#(
    .DATA_WIDTH     (DATA_WIDTH     ),
    .ALU_OUT_WIDTH  (ALU_OUT_WIDTH  )
)
u_TX_CTRL_SYS(
    .CLK             (REF_CLK             ),
    .RST             (SYNC_RST1             ),
    .Rd_D_Vld        (Rd_D_Vld        ),
    .Rd_Data         (Rd_D         ),
    .ALU_OUT_Valid   (ALU_OUT_Valid   ),
    .ALU_OUT         (ALU_OUT         ),
    .TX_Busy         (tx_sync_out_busy         ),
    .OUT_TX_CTRL_SYS (OUT_TX_CTRL_async ),
    .TX_CTRL_Valid   (TX_CTRL_Valid_async   )
);


DATA_SYNC_SYS  u_DATA_SYNC_SYS_TX(                              //finish
    .CLK          (TX_CLK_SYS          ),
    .RST          (SYNC_RST2          ),
    .bus_enable   (TX_CTRL_Valid_async   ),
    .unsync_bus   (OUT_TX_CTRL_async   ),
    .sync_bus     (TX_IN_P_SYS     ),
    .enable_pulse (data_sync_enable )
);



REG_FILE_SYS                                      //finish
#(
    .ADDRESS_WIDTH (ADDRESS_WIDTH ),
    .DATA_SIZE     (DATA_WIDTH     )
    )
u_REG_FILE_SYS(
    .CLK          (REF_CLK          ),
    .RST          (SYNC_RST1          ),
    .Address      (Addr      ),
    .WrEn         (WrEn         ),
    .RdEn         (RdEn         ),
    .WrData       (Wr_D       ),                //
    .RdData       (Rd_D       ),
    .RdData_Valid (Rd_D_Vld ),
    .REG0         (REG0         ),
    .REG1         (REG1         ),
    .REG2         (REG2         ),
    .REG3         (REG3         )
);



ALU_SYS                                                //finish                                         
#(
    .DATA_WIDTH     (DATA_WIDTH     ),
    .ALU_FUNC_WIDTH (ALU_FUNC_WIDTH ),
    .ALU_OUT_WIDTH  (ALU_OUT_WIDTH  )
)
u_ALU_SYS(
    .CLK       (ALU_CLK       ),
    .RST       (RST       ),
    .A         (REG0      ),
    .B         (REG1         ),
    .Enable    (ALU_EN    ),
    .ALU_FUNC  (ALU_FUNC  ),
    .ALU_OUT   (ALU_OUT   ),
    .OUT_VALID (ALU_OUT_Valid )
);


RST_SYNC_SYS u_RST_SYNC_SYS1(                           //finish
    .CLK      (REF_CLK      ),
    .RST      (RST      ),
    .SYNC_RST (SYNC_RST1 )
);


CLK_GATE_SYS u_CLK_GATE_SYS(                           //finish
    .CLK_EN    (Gate_EN    ),
    .CLK       (REF_CLK       ),
    .GATED_CLK (ALU_CLK )
);




RST_SYNC_SYS u_RST_SYNC_SYS2(                       //finish
    .CLK      (UART_CLK) ,
    .RST      (RST      ),
    .SYNC_RST (SYNC_RST2 )
);


CLOCK_DIVIDER_SYS  u_CLOCK_DIVIDER_SYS(                  //finish
    .i_ref_clk   (UART_CLK   ),
    .i_rst       (SYNC_RST2    ),
    .i_clk_en    (1'b1    ),
    .i_div_ratio (REG3[3:0] ),
    .o_div_clk   (TX_CLK_SYS   )
);

endmodule
