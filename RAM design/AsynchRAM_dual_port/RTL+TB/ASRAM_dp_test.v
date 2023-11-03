module ASRAM_dp_test (    
);
    parameter data_width = 8;
    parameter address_width = 4;
    parameter RAM_size = 16;

    integer i,seed;

    reg [(data_width-1):0] data_in,
    reg [(address_width-1):0] wr_addr, rd_addr,
    reg wr_en, rd_en, wr_clk, rd_clk, rst,
    wire data_out 

    integer i;

    ASRAM_dp #(data_width,address_width,RAM_size 
) DUT (data_in, 
       wr_addr, rd_addr, 
       wr_en, rd_en, wr_clk, rd_clk, rst, 
       data_out 
);

task initialize(); begin
    data_in = data_width'bz;
    wr_addr = address_width'bz;
    rd_addr = address_width'bz;
    wr_en = 0;
    rd_en = 0;
    rd_clk = 0;
    wr_clk = 0;
    rst = 0;
end
endtask

task clock_gen(); begin
    #10 rd_clk = ~ rd_clk;
    #11 wr_clk = ~ wr_clk;
end
endtask


task RAM_rst(); begin
    rst = 1;
    #5
    rst = 0;
end
endtask

task RAM_in( input [(data_width-1):0] data, 
             input [(address_width-1):0] addr); begin
    @(negedge rd_clk); 
    wr_addr <= addr;
    data_in <= data;
    wr_en <= 1;
    @(negedge rd_clk);
    wr_en <= 0;
end
endtask

task RAM_out( input [(address_width-1):0] addr); begin
    @(negedge rd_clk);
    rd_addr <= addr;
    rd_en <= 1; 
    @(negedge rd_clk);
    rd_en <= 0;
end
endtask

task RAM_fill(); begin
    for(i=0; i<RAM_size; i= i+1) begin 
        RAM_in(($random(seed) % data_width),(i % address_width));
    end
end
endtask

task RAM_read_all(); begin
    for(i=0; i<RAM_size; i= i+1) begin 
        RAM_out((i % address_width));
    end
end
endtask

initial begin
    seed = $realtime;
    $monitor("Data_out = %b", data_out);
    $monitor("Data_in = %b", data_in);
    $monitor("wr_en = %b", wr_en);
    $monitor("rd_en = %b", rd_en);
    $monitor("time = %t", $time);
    $monitor("Reset = %b", rst);
    $dumpfile("temp.vcd");
    $dumpvars;
    intialize();
    clock_gen();
    #5 RAM_rst();
    #5 RAM_fill();
    #5 RAM_read_all();
    #5 RAM_in(({$random(seed)} % data_width),({$random(seed)} % address_width));
    #5 RAM_out(({$random(seed)} % address_width));
    #5 RAM_in(8'hAA,4'b1000);
    #5 RAM_out(4'b1000);
    #5
    fork 
        RAM_in(8'hAA,4'b1000);
        RAM_out(4'b1001);
    join
    #5
    fork 
        RAM_in(8'hAA,4'b1000);
        RAM_out(4'b1000);
    join
    #5 RAM_rst();   
    #100 $finish
end

endmodule //ASRAM_dp_test