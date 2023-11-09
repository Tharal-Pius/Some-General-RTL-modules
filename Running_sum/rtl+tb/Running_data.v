module Running_data #(
    parameter data_width = 8,
    parameter out_width = 16
) (
    input   data_in_valid, rst, clk,
    input  [(data_width-1):0] data_in,
    output reg data_out_valid,
    output  reg [(out_width-1):0] data_out
);
    
    always @(posedge clk) begin
        if(rst) begin
          data_out_valid <= 0;
          data_out <= 0;
        end
        else if(data_in_valid) begin
          data_out <= data_out + data_in;
          data_out_valid <= 1;
        end
        else begin
          data_out <= data_out;
          data_out_valid <= 1;
        end
    end
endmodule