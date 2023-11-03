
//////////////////////////////////////////////////////////////////////////////////
// Company: AMD-Xilinx
// Engineer: Tharal Pius
// 
// Create Date: 10/10/2023 01:21:11 PM
// Design Name: 
// Module Name: CLA_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CLA_adder #(
    parameter adder_size = 16,
    parameter data_width = 4
) (
    input [(adder_size-1):0] a,b ,
    input cin,
    output [(adder_size-1):0] sum,
    output cout
);
    wire [(adder_size/data_width):0] cin_w;
    assign cin_w[0] = cin;
    assign cout = cin_w[(adder_size/data_width)];
    generate
    genvar i;
    for (i =0; i<(adder_size/data_width); i= i+1) begin
        Adder_blk #(data_width) A_blk (
                a[(data_width*(i+1)-1):(data_width*i)],
                b[(data_width*(i+1)-1):(data_width*i)],
                cin_w[i],
                sum[(data_width*(i+1)-1):(data_width*i)],
                cin_w[i+1]);
    end
endgenerate
endmodule
