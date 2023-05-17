module STOP_CHECK_URT_RX (
    input     wire         CLK_STOP_CHECK,
    input     wire         RST_STOP_CHECK,
    input     wire         stp_chk_en_STOP_CHECK,
    input     wire         sampled_bit_STOP_CHECK,

    output    reg          stp_err_STOP_CHECK
);



always @(posedge CLK_STOP_CHECK or negedge RST_STOP_CHECK)
    begin
        if(!RST_STOP_CHECK)
           begin
            stp_err_STOP_CHECK<='b0;
           end
        else if(stp_chk_en_STOP_CHECK)
             begin
            stp_err_STOP_CHECK <= 1'b1 ^ sampled_bit_STOP_CHECK;
            end
          end
endmodule     
