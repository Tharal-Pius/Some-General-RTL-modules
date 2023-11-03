module Full_adder (
    input a,b,cin,
    output sum,carry
);

assign sum = a^b^cin;
assign carry = ((a&b)|((a^b)&cin));

endmodule //Full_adder