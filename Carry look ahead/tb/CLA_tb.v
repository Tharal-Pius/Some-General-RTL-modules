
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2023 11:33:42 AM
// Design Name: 
// Module Name: tb_Adder
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



module CLA_tb;

    // Parameters
    parameter data_width = 4;  // Set the data width
    parameter adder_size = 16;

    // Signals
    reg [(adder_size-1):0] a, b;  // Input data vectors
    reg cin;                     // Input carry-in
    wire [(adder_size-1):0] sum;  // Output sum
    wire cout;

    // Instantiate the Adder module
    CLA_adder #(adder_size,data_width) u_cla_Adder (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),.cout(cout)
    );

    // Clock generation
   
    // Test stimulus
    initial begin

        // Test case 1: 4-bit addition without carry-in
        a = 16'hABCD;
        b = 16'hEFD1;
        cin = 1'b0;

        #10;  // Allow some time for the outputs to settle
        // Test case 2: 4-bit addition with carry-in
        a = 16'hA0CD;
        b = 16'hEFA1;
        cin = 1'b1;

        // Terminate the simulation
        $finish;
    end

 
endmodule

