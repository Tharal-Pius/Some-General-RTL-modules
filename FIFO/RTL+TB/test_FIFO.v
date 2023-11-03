// Code your testbench here
// or browse Examples
module test_FIFO ();

parameter data_width = 8;
parameter FIFO_depth = 16;
parameter addr_width = 4;

integer seed;

  reg  [(data_width - 1):0] data_in;
    reg  CLK, RST, wr_en, rd_en;
  wire [(data_width - 1):0] data_out;
    wire full, empty;

FIFO #(
    data_width,
    FIFO_depth,
    addr_width
) DUT (
    data_in,
    CLK, RST, wr_en, rd_en,
    data_out,
    full, empty
);

always 
#10 CLK <= ~CLK;

task initialize(); begin
  data_in = 8'bz;
  CLK = 0;
  RST = 0;
  wr_en = 0;
  rd_en = 0;
end
endtask

task RESET(); begin
    @(negedge CLK);
    RST = 1;
    @(negedge CLK);
    RST = 0;
end
endtask

task WRITE(input [(data_width - 1):0] data); begin
    @(negedge CLK);
    data_in <= data;
    wr_en = 1;
    @(negedge CLK);
    wr_en = 0;
end
endtask

task READ(); begin
    @(negedge CLK);
    rd_en = 1;
    @(negedge CLK);
    rd_en = 0;
end
endtask
initial begin
    seed = $realtime;
    $monitor("Data_out = %b Data_in = %b wr_en = %b rd_en = %b Reset = %b time = %t", data_out, data_in, wr_en, rd_en, RST, $time);
    $dumpfile("temp.vcd");
    $dumpvars;
    initialize();
    RESET();
  WRITE(8'hfa);
    READ();
  READ();
end
endmodule //test_FIFO