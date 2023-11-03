module Adder_blk #(
    parameter data_width = 4
) (
    input [(data_width-1):0] a,b ,
    input cin,
    output [(data_width-1):0] sum,
    output cout
);
    Adder #(data_width) Add (a,b,cin,sum);
    Carry_gen #(data_width) CG (a,b,cin,cout);
endmodule