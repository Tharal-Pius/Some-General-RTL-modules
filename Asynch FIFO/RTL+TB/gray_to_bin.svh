`ifndef GRAY
`define GRAY_TO_BIN

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
`endif //GRAY_TO_BIN