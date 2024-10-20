`ifndef DOUBLE_FLOP_SYNCH
`define DOUBLE_FLOP_SYNCH

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

`endif  //DOUBLE_FLOP_SYNCH