module TOP_URT_RX #(parameter  DATA_WIDTH_TOP = 8 , PRESCALE_WIDTH_TOP = 5)
(
   input      wire                           CLK_TOP,
   input      wire                           RST_TOP,
   input      wire                           RX_IN_TOP,
   input      wire                           PAR_EN_TOP,
   input      wire                           PAR_TYP_TOP,
   input      wire  [PRESCALE_WIDTH_TOP-1:0] Prescale_TOP,
   
   output     wire  [DATA_WIDTH_TOP-1:0]      P_DATA_TOP,
   output     wire                            data_valid_TOP
   
);


//internal signals 
   wire            dat_samp_en_TOP;
   wire  [3:0]     edge_cnt_TOP;
   wire  [3:0]     bit_cnt_TOP;
   wire            enable_edge_bit_TOP;
   wire            sampled_bit_TOP;

   wire            par_chk_en_TOP;

   wire            strt_chk_en_TOP;
   wire            strt_glitch_TOP;

   wire            stp_chk_en_TOP;

   wire            deser_en_TOP;      
   wire            stp_err_TOP;
   wire            par_err_TOP;

EDGE_BIT_COUNT_URT_RX
#(
    .PRESCALE_WIDTH(PRESCALE_WIDTH_TOP)
    )
 u_EDGE_BIT_COUNT_URT_RX
(
    .CLK_edge_bit      (CLK_TOP            ),
    .RST_edge_bit      (RST_TOP            ),
    .Prescale_edge_bit (Prescale_TOP       ),
    .enable_edge_bit   (enable_edge_bit_TOP),
    .bit_cnt_edge_bit  (bit_cnt_TOP        ),
    .edge_cnt_edge_bit (edge_cnt_TOP       )
);

DATA_SAMP_URT_RX
# (.PRESCALE_WIDTH(PRESCALE_WIDTH_TOP) )

 u_DATA_SAMP_URT_RX(
    .CLK_SAMP         (CLK_TOP         ),
    .RST_SAMP         (RST_TOP         ),
    .Prescale_SAMP    (Prescale_TOP    ),
    .RX_IN_SAMP       (RX_IN_TOP       ),
    .dat_samp_en_SAMP (dat_samp_en_TOP ),
    .edge_cnt_SAMP    (edge_cnt_TOP    ),
    .sampled_bit_SAMP (sampled_bit_TOP )
);


START_CHECK_URT_RX u_START_CHECK_URT_RX(
    .CLK_START_CHECK         (CLK_TOP         ),
    .RST_START_CHECK         (RST_TOP         ),
    .strt_chk_en_START_CHECK (strt_chk_en_TOP ),
    .sampled_bit_START_CHECK (sampled_bit_TOP ),
    .strt_glitch_START_CHECK (strt_glitch_TOP )
);


PARITY_CHECK_URT_RX 
# (
    .DATA_WIDTH(DATA_WIDTH_TOP)
     )
u_PARITY_CHECK_URT_RX(
    .CLK_PAR_CHECK         (CLK_TOP         ),
    .RST_PAR_CHECK         (RST_TOP         ),
    .PAR_TYP_PAR_CHECK     (PAR_TYP_TOP     ),
    .par_chk_en_PAR_CHECK  (par_chk_en_TOP  ),
    .sampled_bit_PAR_CHECK (sampled_bit_TOP ),
    .P_DATA_PAR_CHECK      (P_DATA_TOP      ),
    .par_err_PAR_CHECK     (par_err_TOP     )
);

STOP_CHECK_URT_RX u_STOP_CHECK_URT_RX(
    .CLK_STOP_CHECK         (CLK_TOP         ),
    .RST_STOP_CHECK         (RST_TOP         ),
    .stp_chk_en_STOP_CHECK  (stp_chk_en_TOP  ),
    .sampled_bit_STOP_CHECK (sampled_bit_TOP ),
    .stp_err_STOP_CHECK     (stp_err_TOP     )
);


DESERIALIZER_URT_RX 
# ( .DATA_WIDTH(DATA_WIDTH_TOP),
    .PRESCALE_WIDTH(PRESCALE_WIDTH_TOP)
    )
     u_DESERIALIZER_URT_RX(
    .CLK_DESERIALIZER         (CLK_TOP         ),
    .RST_DESERIALIZER         (RST_TOP         ),
    .deser_en_DESERIALIZER    (deser_en_TOP    ),
    .Prescale_DESERIALIZER    (Prescale_TOP    ),
    .sampled_bit_DESERIALIZER (sampled_bit_TOP ),
    .edge_cnt_DESERIALIZER    (edge_cnt_TOP    ),
    .P_DATA_DESERIALIZER      (P_DATA_TOP      )
);



FSM_URT_RX  u_FSM_URT_RX(
    .CLK_FSM             (CLK_TOP             ),
    .RST_FSM             (RST_TOP             ),
    .RX_IN_FSM           (RX_IN_TOP           ),
    .bit_cnt_FSM         (bit_cnt_TOP         ),
    .edge_cnt_FSM        (edge_cnt_TOP        ),
    .PAR_EN_FSM          (PAR_EN_TOP          ),
    .par_err_FSM         (par_err_TOP         ),
    .strt_glitch_FSM     (strt_glitch_TOP     ),
    .stp_err_FSM         (stp_err_TOP         ),
    .dat_samp_en_FSM     (dat_samp_en_TOP     ),
    .enable_edge_bit_FSM (enable_edge_bit_TOP ),
    .par_chk_en_FSM      (par_chk_en_TOP      ),
    .strt_chk_en_FSM     (strt_chk_en_TOP     ),
    .stp_chk_en_FSM      (stp_chk_en_TOP      ),
    .data_valid_FSM      (data_valid_TOP      ),
    .deser_en_FSM        (deser_en_TOP        )
);

endmodule


