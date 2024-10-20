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



module double_flop_synch #( //double_flop_synch + pulsed_out
    parameter SIZE = 4
)(
    input            [(SIZE -1):0] signal_in,
    input                          dest_clk,
    input                          rst_n,
    output           [(SIZE -1):0] signal_out
);

    logic [(SIZE -1):0] signal_thru1;
    logic [(SIZE -1):0] signal_thru2;
    logic [(SIZE -1):0] signal_thru3;
    always_comb begin
        signal_out = (~signal_thru3) & signal_thru2;
    end
    always_ff @(posedge dest_clk or negedge rst_n) begin
        if(~rst_n) begin
            signal_thru1 <= 0;
            signal_thru2 <= 0;
            signal_thru3 <= 0;
        end
        else begin
            signal_thru1  <= signal_in;
            signal_thru2  <= signal_thru1
            signal_thru3  <= signal_thru2;
        end
    end
    
endmodule



module bin_to_gray #(
    parameter SIZE = 4
) (
    input [(SIZE -1):0] data_in,
    output [(SIZE -1):0] data_out
);
    always_comb begin
        data_out = data_in ^ (data_in >>1);
    end
    
endmodule



module gray_to_bin #(
    parameter SIZE = 4
) (
    input [(SIZE -1):0] data_in,
    output [(SIZE -1):0] data_out
);
    logic [(SIZE -1):0] signal_in;
    logic [(SIZE):0] signal_out;

    always_comb begin
        signal_in = data_in;
        data_out  = signal_out[(SIZE - 1):0]; 
    end
    genvar i;
    generate;
        for ( i= 0; i< SIZE; i = i+1) begin
            signal_out[i] = signal_out[i+1] ^ signal_in[i];
        end
    endgenerate
    
endmodule