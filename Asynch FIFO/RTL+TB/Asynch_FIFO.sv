`ifndef ASYNC_FIFO
`define ASYNC_FIFO
`include "transmitter.sv"
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

module transmitter #(
    parameter SIZE = 4
) (
    input            [(SIZE -1):0] signal_in,
    input                          dest_clk,
    input                          rst_n,
    output           [(SIZE -1):0] signal_out
);
    logic [(SIZE -1):0] gray_to_synch;
    logic [(SIZE -1):0] synch_to_bin;
    bin_to_gray #(.SIZE(SIZE)) tr_bin_to_gray_inst1 (.data_in(signal_in), .data_out(gray_to_synch));
    double_flop_synch #(.SIZE(SIZE)) tr_double_flop_synch_inst1 (.data_in(gray_signal_out), .dest_clk(dest_clk), .rst_n(rst_n) .data_out(synch_to_bin));
    gray_to_bin #(.SIZE(SIZE)) tr_gray_to_bin_inst1 (.data_in(synch_to_bin), .data_out(signal_out));

endmodule



module double_flop_synch #( //double_flop_synch + pulsed_out
    parameter SIZE = 4
)(
    input            [(SIZE -1):0] signal_in,
    input                          dest_clk,
    input                          rst_n,
    output           [(SIZE -1):0] signal_out
);

    logic [(SIZE -1):0] signal_thru1;
    logic [(SIZE -1):0] signal_thru2;
    logic [(SIZE -1):0] signal_thru3;
    always_comb begin
        signal_out = (~signal_thru3) & signal_thru2;
    end
    always_ff @(posedge dest_clk or negedge rst_n) begin
        if(~rst_n) begin
            signal_thru1 <= 0;
            signal_thru2 <= 0;
            signal_thru3 <= 0;
        end
        else begin
            signal_thru1  <= signal_in;
            signal_thru2  <= signal_thru1
            signal_thru3  <= signal_thru2;
        end
    end
    
endmodule



module bin_to_gray #(
    parameter SIZE = 4
) (
    input [(SIZE -1):0] data_in,
    output [(SIZE -1):0] data_out
);
    always_comb begin
        data_out = data_in ^ (data_in >>1);
    end
    
endmodule



module gray_to_bin #(
    parameter SIZE = 4
) (
    input [(SIZE -1):0] data_in,
    output [(SIZE -1):0] data_out
);
    logic [(SIZE -1):0] signal_in;
    logic [(SIZE):0] signal_out;

    always_comb begin
        signal_in = data_in;
        data_out  = signal_out[(SIZE - 1):0]; 
    end
    genvar i;
    generate;
        for ( i= 0; i< SIZE; i = i+1) begin
            signal_out[i] = signal_out[i+1] ^ signal_in[i];
        end
    endgenerate
    
endmodule

`endif //ASYNC_FIFO
