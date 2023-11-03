// Code your design here
module ASYNCH_RAM_SP #(
    parameter data_width = 8,
    parameter address_width = 4,
    parameter RAM_size = 16
) (
    inout [(data_width-1):0] data,
    input [(address_width-1):0] address,
    input wr_rd_en //wr = 1, rd = 0 
);
  reg [(data_width-1):0] mem [0:(RAM_size-1)];
    always @(*) begin
        if(wr_rd_en)
          mem[address] <= data;
    end

  assign data = (wr_rd_en)? 8'bz : mem[address];
endmodule