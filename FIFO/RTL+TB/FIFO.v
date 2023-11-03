// Code your design here
module FIFO #(
    parameter data_width = 8,
    parameter FIFO_depth = 16,
    parameter addr_width = 4
) (
    input  [(data_width - 1):0] data_in,
    input CLK, RST, wr_en, rd_en,
    output  reg [(data_width - 1):0] data_out,
    output full, empty
);
  reg [(data_width-1):0] mem [0:(FIFO_depth-1)];
  reg [(addr_width):0] FIFO_count = 4'b0;
  reg [(addr_width-1):0] rd_ptr = 4'b0;
  reg [(addr_width-1):0] wr_ptr = 4'b0;
  integer i;

  assign full = (FIFO_count > 5'b01111);
  assign empty = (FIFO_count == 4'b0);

  always @(posedge CLK ) begin
    if(RST) begin
        FIFO_count <= 0;
    end
    else if(wr_en && !full) begin
        FIFO_count <= FIFO_count +1;
    end
    else if(rd_en && !empty) begin
        FIFO_count <= FIFO_count -1;
    end
    else begin
        FIFO_count <= FIFO_count;
    end
  end 
//write_data_in
  always @(posedge CLK ) begin
    if(RST) begin
        for (i =0; i<FIFO_depth; i=i+1 ) begin
            mem[i] <= 8'b0;     
        end
        wr_ptr <= 0;
    end
    else if(wr_en && ~full) begin
      mem[wr_ptr] <= data_in;
      wr_ptr <= wr_ptr +1;
    end
    else begin
        wr_ptr <= wr_ptr;
    end
  end  


//read_data_out
  always @(posedge CLK ) begin
    if(RST) begin
            data_out <= 8'b0;
            rd_ptr <= 0;
    end
    else if(rd_en & ~full) begin
      data_out <= mem[rd_ptr];
      rd_ptr <= rd_ptr +1;
    end
    else begin
        rd_ptr <= rd_ptr;
    end
  end
endmodule