// Code your testbench here
// or browse Examples

module SRAM_test (
);
    reg [7:0] data_in;
    reg [3:0] wr_addr, rd_addr;
    reg wr_en, rd_en, clk, rst;
    wire [7:0] data_out;

  SRAM_dual_port #(.data_width(8), .RAM_size(16), .address_width(4) ) DUT (
        data_in, 
        wr_addr, rd_addr,      
        wr_en, rd_en, clk, rst,
        data_out
    );

    task initialize; begin
        clk = 0;
        rst = 0;
        wr_en = 0;
        rd_en = 0; 
        data_in = 8'b0;
    end
    endtask

    task RAM_rst; begin
        @(negedge clk);
            rst = 1;
      		data_in = 8'b0;
        @(negedge clk);
            rst = 0;
    end 
    endtask

  task RAM_in (input [7:0] data, input [3:0] addr ); begin
        @(negedge clk);
            data_in = data;
            wr_addr = addr;
            wr_en = 1;
    	    rd_en = 0;
    	@(negedge clk);
    	    wr_en = 0;
    end
    endtask

  task RAM_out (input [3:0] addr ); begin
        @(negedge clk);
            rd_addr = addr;
            rd_en = 1;
    		wr_en = 0;
    	@(negedge clk);
    	    rd_en = 0;
    end
    endtask


    always 
    #10 clk <= ~clk;
  

    initial begin
      $dumpfile("test.vcd");
      $dumpvars;
      $monitor("WR= %b RD = %b Data_in = %b Data_out = %b at time %t", wr_en, rd_en, data_in,  data_out, $time);
        initialize();
      #5 RAM_rst();
      #5 RAM_in(8'hAB, 4'b1011);
      #5 RAM_out(4'b1011);
      #5 RAM_in(8'hBB, 4'b1001);
      #5
      fork  	
         RAM_in(8'hFF, 4'b1011);
        RAM_out(4'b1011);
      join
      #20 $finish;
    end

endmodule //SRAM_test