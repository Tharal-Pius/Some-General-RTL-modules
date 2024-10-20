`ifndef ASYNC_FIFO
`define ASYNC_FIFO
`include "transmitter_includes.svh"
module Async_FIFO #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 4
) (
    input                       wr_clk,
    input                       wr_en,
    input                       rd_clk,
    input                       rd_en,
    input                       rst_n,
    input  [(DATA_WIDTH - 1):0] data_in,
    output [(DATA_WIDTH - 1):0] data_out,
    output                      full,
    output                      empty,
);
    //Dual port RAM
    logic [(DATA_WIDTH -1):0] [(2**ADDR_WIDTH)-1:0] fifo_RAM;
    logic [(ADDR_WIDTH ):0] wr_ptr;
    logic [(ADDR_WIDTH ):0] wr_ptr_nxt;
    logic [(ADDR_WIDTH ):0] wr_ptr_in_rd_clk;
    logic [(ADDR_WIDTH ):0] rd_ptr;
    logic [(ADDR_WIDTH ):0] rd_ptr_nxt;
    logic [(ADDR_WIDTH ):0] rd_ptr_in_wr_clk; 


    transmitter #( .SIZE(ADDR_WIDTH)) tr_wr_clk_to_rd_clk (.data_in(wr_ptr), .dest_clk(rd_clk), .rst_n(rst_n), .data_out(wr_ptr_in_rd_clk));
    transmitter #( .SIZE(ADDR_WIDTH)) tr_rd_clk_to_wr_clk (.data_in(rd_ptr), .dest_clk(wr_clk), .rst_n(rst_n), .data_out(rd_ptr_in_wr_clk));


    always_comb begin

        wr_ptr_nxt = wr_ptr + (wr_en & (~full));
        rd_ptr_nxt = rd_ptr + (rd_en & (~empty));

        full = (wr_ptr[(ADDR_WIDTH - 1):0] == rd_ptr_in_wr_clk[(ADDR_WIDTH - 1):0]) & (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]);
        empty = (wr_ptr_in_rd_clk == rd_ptr);

    end

    //write

    always_ff @(posedge wr_clk or negedge rst_n) begin
        if(~rst_n) begin
            data_out <= {DATA_WIDTH{1'b0}};
            wr_ptr <= {ADDR_WIDTH{1'b0}};
        end
        else begin
            wr_ptr            <= wr_ptr_nxt;
            fifo_RAM [wr_ptr] <= data_in;
        end
    end

    //read
    always_ff @(posedge rd_clk or negedge rst_n) begin
        if(~rst_n) begin
            rd_ptr <= {ADDR_WIDTH{1'b0}};
        end
        else begin
            rd_ptr   <= rd_ptr_nxt;
            data_out <= fifo_RAM [rd_ptr];
        end
    end
    
    
endmodule

`endif //ASYNC_FIFO
