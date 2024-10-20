`ifndef TRANSMITTER
`define TRANSMITTER
module transmitter #(
    parameter SIZE = 4
) (
    input            [(SIZE -1):0] signal_in,
    input                          dest_clk,
    input                          rst_n,
    output           [(SIZE -1):0] signal_out
);
    logic [(SIZE -1):0] gray_to_synch;
    logic [(SIZE -1):0] synch_to_bin;
    bin_to_gray #(.SIZE(SIZE)) tr_bin_to_gray_inst1 (.data_in(signal_in), .data_out(gray_to_synch));
    double_flop_synch #(.SIZE(SIZE)) tr_double_flop_synch_inst1 (.data_in(gray_signal_out), .dest_clk(dest_clk), .rst_n(rst_n) .data_out(synch_to_bin));
    gray_to_bin #(.SIZE(SIZE)) tr_gray_to_bin_inst1 (.data_in(synch_to_bin), .data_out(signal_out));

endmodule

`endif TRANSMITTER