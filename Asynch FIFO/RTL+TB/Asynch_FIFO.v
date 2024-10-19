module Asynch_FIFO #(
    parameter depth = 16,
    parameter width = 32
) (
    input [(width - 1):0] data_in,
    input rst_n,
    input sys_clk,
    output logic [(width-1):0] data_out,
    output logic empty, 
    output logic full
);


localparam addr_size = $clog2(depth) + 1  // MSB extra bit for full/empty distinction

// FIFO memory array
logic [0:(depth-1)] [(width - 1):0] FIFO_mem_rd_wr;
logic [(addr_size-1):0] wr_ptr;  
logic [(addr_size-1):0] rd_ptr;  

always_comb begin
    // Empty when pointers are equal (including the extra bit)
    empty = (wr_ptr == rd_ptr);

    // Full when the next write pointer catches up to the read pointer
    full = ((wr_ptr[addr_size-2:0] == rd_ptr[addr_size-2:0]) && (wr_ptr[addr_size-1] != rd_ptr[addr_size-1]));
end

always_ff @(posedge sys_clk or negedge rst_n) begin
    if (~rst_n) begin
        wr_ptr <= {addr_size{1'b0}};
        rd_ptr <= {addr_size{1'b0}};
        data_out <= {width{1'b0}};
    end else begin
        // Read operation
        if (!empty) begin
            data_out <= FIFO_mem_rd_wr[rd_ptr[addr_size-2:0]];
            rd_ptr <= rd_ptr + 1'b1;  
        end

        // Write operation
        if (!full) begin
            FIFO_mem_rd_wr[wr_ptr[addr_size-2:0]] <= data_in;
            wr_ptr <= wr_ptr + 1'b1;  
        end
    end
end

endmodule
