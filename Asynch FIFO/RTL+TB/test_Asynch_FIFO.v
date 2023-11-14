// Code your testbench here
// or browse Examples
module test_Asynch_FIFO ();

parameter data_width = 8;
parameter Asynch_FIFO_depth = 16;

integer seed;

  reg  [(data_width - 1):0] data_in;
  reg  wr_CLK, rd_CLK, RST, wr_en, rd_en;
  wire [(data_width - 1):0] data_out;
  wire full, empty;

Asynch_FIFO #(
    data_width,
    Asynch_FIFO_depth
) DUT (
    data_in,
    wr_CLK, rd_CLK, RST, wr_en, rd_en,
    data_out,
    full, empty
);

integer i, i2;

always 
#10 wr_CLK <= ~wr_CLK;

always 
#15 rd_CLK <= ~rd_CLK;

task initialize(); begin
  wr_CLK = 0;
  rd_CLK = 0;
  RST = 0;
  wr_en = 0;
  rd_en = 0;
end
endtask

task RESET(); begin
    RST = 1;
    #37
    RST = 0;
end
endtask

task WRITE(input [(data_width - 1):0] data); begin
    @(negedge wr_CLK);
    data_in <= data;
    wr_en = 1;
    @(negedge wr_CLK);
    wr_en = 0;
end
endtask

task READ(); begin
    @(negedge rd_CLK);
    rd_en = 1;
    @(negedge rd_CLK);
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
    RESET();
    fork
    for(i =0; i< (Asynch_FIFO_depth + 3); i = i+1) begin 
        WRITE(i+10);
    end
    
    for(i2 =0; i2< 3; i2 = i2+1) begin 
        READ();
    end
    join
end
endmodule //test_Asynch_FIFO