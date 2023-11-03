// Code your design here
module ASRAM_dp #(
    parameter data_width = 8,
    parameter address_width = 4,
    parameter RAM_size = 16 
) (
    input [(data_width-1):0] data_in,
    input [(address_width-1):0] wr_addr, rd_addr,
    input wr_en, rd_en, wr_clk, rd_clk, rst,
    output reg data_out 
);
    reg [(data_width-1):0] mem [(RAM_size-1):0];
    integer i;

    //read

    always @(posedge rd_clk or posedge rst ) begin
        if(rst) begin
            data_out <= 0;
        end
        else begin
            data_out <= (rd_en)?mem[rd_addr]:data_out;
        end    
    end

    //write
    always @(posedge wr_clk or posedge rst ) begin
        if(rst) begin
          for (i=0; i< RAM_size; i= i+1) begin
                mem[i] <= 0;
            end
        end
        else begin
            mem[wr_addr] <= (wr_en)? data_in : mem[wr_addr];
        end
    end


endmodule