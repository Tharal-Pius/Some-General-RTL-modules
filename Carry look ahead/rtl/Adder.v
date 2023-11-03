module Adder #(
    parameter data_width =4
) (
    input [(data_width-1):0] a,b ,
    input cin,
    output [(data_width-1):0] sum
);
    wire [data_width:0] cin_w;
    assign cin_w[0] = cin;
    //assign sum[4] = cin_w[4];
    generate
        genvar i;
        for (i = 0; i< data_width; i= i+1) begin
            Full_adder FA (a[i], b[i], cin_w[i], sum[i], cin_w[i+1]);
        end
    endgenerate
endmodule