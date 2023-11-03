// Code your design here
module SRAM_dual_port #(
    parameter data_width  = 8,
    parameter RAM_size = 16,
    parameter address_width = 4
) (
    input   [(data_width - 1):0] data_in, 
    input   [(address_width - 1):0] wr_addr, rd_addr,      
    input   wr_en, rd_en, clk, rst,
  output  [(data_width - 1):0] data_out_port
);

    reg [(data_width - 1):0] data_out;
    reg [(data_width - 1):0] mem [0:(RAM_size - 1)];
    integer i;
  assign data_out_port = data_out;

//read block
    always @(posedge clk ) begin
        if(rst) begin
            data_out <= 8'b0;
        end
        else 
        if(rd_en) begin
            data_out <= mem[rd_addr];
        end
        
    end

    
//write block
    always @(posedge clk ) begin
        if(rst) begin
            for ( i=0; i< RAM_size; i= i+1) begin
                mem[i] <= 8'b0;
            end
        end
        else 
        if(wr_en) begin
            mem[wr_addr] <= data_in;
        end
    end
endmodule