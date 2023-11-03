module Carry_gen #(
    parameter data_width = 4
) (
    input [(data_width-1):0] a, b,
    input cin,
    output cout
);
    wire [(data_width-1):0] g,w;
    wire [(data_width-1):1] p;
    assign g[0] = cin;
    generate
        genvar i;
        for ( i = 1; i<data_width; i = i+1) begin
            assign p[i] = a[i]^b[i];
            assign g[i] = a[i]&b[i];
            assign w[data_width-1] = g[data_width-1];
        end
        for ( i = 0; i<data_width-1; i = i+1) begin
            assign w[i] = g[i] & (&(p[(data_width-1):(i+1)]));
        end
    endgenerate
    assign cout = |w;
endmodule