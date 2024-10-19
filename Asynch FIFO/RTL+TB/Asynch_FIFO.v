module Async_FIFO #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4  // Depth = 2^ADDR_WIDTH
) (
    input                   wr_clk,   // Write clock
    input                   rd_clk,   // Read clock
    input                   rst_n,    // Asynchronous reset (active low)
    input                   wr_en,    // Write enable
    input                   rd_en,    // Read enable
    input   [DATA_WIDTH-1:0] data_in, // Data to be written
    output  [DATA_WIDTH-1:0] data_out, // Data to be read
    output                  full,     // FIFO full flag
    output                  empty     // FIFO empty flag
);

    // FIFO memory
    logic [DATA_WIDTH-1:0] mem [(2**ADDR_WIDTH)-1:0];

    // Gray code pointers
    logic [ADDR_WIDTH:0] wr_ptr_gray, wr_ptr_gray_next;  // Write pointer (Gray code)
    logic [ADDR_WIDTH:0] rd_ptr_gray, rd_ptr_gray_next;  // Read pointer (Gray code)
    
    // Binary versions of the pointers
    logic [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_bin_next;    // Write pointer (binary)
    logic [ADDR_WIDTH:0] rd_ptr_bin, rd_ptr_bin_next;    // Read pointer (binary)
    
    // Synchronized pointers in opposite domains
    logic [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2;  // Synced read pointer in write domain
    logic [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2;  // Synced write pointer in read domain

    // Full and empty flag logic
    logic fifo_full, fifo_empty;

    // Synchronizing read pointer into write clock domain
    always_ff @(posedge wr_clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
        end else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end

    // Synchronizing write pointer into read clock domain
    always_ff @(posedge rd_clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
        end else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end

    // Write pointer logic
    always_ff @(posedge wr_clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr_bin <= 0;
            wr_ptr_gray <= 0;
        end else if (wr_en && !fifo_full) begin
            wr_ptr_bin <= wr_ptr_bin_next;
            wr_ptr_gray <= wr_ptr_gray_next;
            mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= data_in;
        end
    end

    // Read pointer logic
    always_ff @(posedge rd_clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr_bin <= 0;
            rd_ptr_gray <= 0;
        end else if (rd_en && !fifo_empty) begin
            rd_ptr_bin <= rd_ptr_bin_next;
            rd_ptr_gray <= rd_ptr_gray_next;
        end
    end

    // Next write pointer
    always_comb begin
        wr_ptr_bin_next = wr_ptr_bin + (wr_en && !fifo_full);
        wr_ptr_gray_next = (wr_ptr_bin_next >> 1) ^ wr_ptr_bin_next;  // Gray code conversion
    end

    // Next read pointer
    always_comb begin
        rd_ptr_bin_next = rd_ptr_bin + (rd_en && !fifo_empty);
        rd_ptr_gray_next = (rd_ptr_bin_next >> 1) ^ rd_ptr_bin_next;  // Gray code conversion
    end

    // Full condition
    assign fifo_full = (wr_ptr_gray_next == {~rd_ptr_gray_sync2[ADDR_WIDTH], rd_ptr_gray_sync2[ADDR_WIDTH-1:0]});

    // Empty condition
    assign fifo_empty = (wr_ptr_gray_sync2 == rd_ptr_gray);

    // Output data
    assign data_out = mem[rd_ptr_bin[ADDR_WIDTH-1:0]];

    // Full and empty flags
    assign full = fifo_full;
    assign empty = fifo_empty;

endmodule
