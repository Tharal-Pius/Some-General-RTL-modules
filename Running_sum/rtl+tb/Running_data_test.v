
module Running_data_test ();
    
    parameter data_width = 8;
    parameter out_width = 16;

    
    reg   data_in_valid, rst, clk, eof;
    reg  [(data_width-1):0] data_in, temp_data;
    wire data_out_valid;
    wire [(out_width-1):0] data_out;
    integer  fptr;

Running_data #(data_width, out_width
) DUT ( data_in_valid, rst, clk, data_in, data_out_valid, data_out
);


initial begin
  clk = 0;
  rst =0;
  data_in = 0;
  data_in_valid = 0;
  eof = 0;
end

always
   #10  clk <= ~clk;

task reset (); begin
  @(negedge clk);
  rst <= 1;
  @(negedge clk);
  rst <= 0;
end
endtask

task input_data(input [(data_width-1):0] data); begin
  @(negedge clk);
  data_in <= data;
  data_in_valid <= 1;
  @(negedge clk);
  data_in_valid <= 0;
end 
endtask

task read_from_file(output [(data_width-1):0] data); begin
    eof = $feof(fptr);
    if(!eof) begin
        $fscanf(fptr, "%d", data);
    end
end
endtask

initial begin
    
    fptr = $fopen("testdat.mem","r");//open file in read mode
    $monitor ($time, "data_in = %b data_out = %b ", data_in, data_out);
    reset();
    while(!eof) begin//loop till eof
        read_from_file(temp_data);
        input_data(temp_data);
    end
    $fclose(fptr);
end
endmodule //Running_data_test