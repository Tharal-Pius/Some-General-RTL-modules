`ifndef BIN_TO_GRAY
`define BIN_TO_GRAY
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
`endif //BIN_TO_GRAY