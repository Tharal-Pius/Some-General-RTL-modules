// Code your testbench here
// or browse Examples
module ARAM_sp_test ();


    parameter data_width = 8;
    parameter address_width = 4;
    parameter RAM_size = 16;

    wire [(data_width-1):0] data;
    reg [(address_width-1):0] address;
    reg wr_rd_en; //wr = 1, rd = 0 


    ASYNCH_RAM_SP #(
        data_width, address_width, RAM_size
    ) DUT (
    data, address, wr_rd_en 
);

    integer i, seed;
    reg [(data_width-1):0] data_in;

  assign data = (wr_rd_en)? data_in :  8'bz;

  task initialize(); begin
        wr_rd_en = 0;
        address = 4'b0;
    end
    endtask

    task RAM_write( input [(data_width-1):0] data_val, 
                 input [(address_width-1):0] addr); begin
                    address = addr;
                    data_in = data_val;
                    wr_rd_en = 1;
                    #10
                    wr_rd_en = 0;
                    data_val = 8'bz;
                 end 
    endtask

    task RAM_read( input [(address_width-1):0] addr); begin
                    address = addr;
                    wr_rd_en = 0;
                 end 

    
    endtask

    initial begin
        $monitor(" data = %b addr = %b wr_rd_en = %b", data, address, wr_rd_en);
        $dumpfile("sim.vcd");
        $dumpvars;
        RAM_write(8'h0F, 4'b1010);
        RAM_write(8'hF0, 4'b1011);
        #5 RAM_read(4'b1010);
      	#5 RAM_read(4'b1010);
    end


endmodule //ARAM_sp_test