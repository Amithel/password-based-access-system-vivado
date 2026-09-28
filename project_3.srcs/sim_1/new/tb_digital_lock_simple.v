module tb_digital_lock_simple;
  reg clk;
  reg rst_n;
  reg [3:0] key_value;
  reg key_valid;
  wire unlock;
  wire alarm;

  digital_lock_simple uut (
    .clk(clk),
    .rst_n(rst_n),
    .key_value(key_value),
    .key_valid(key_valid),
    .unlock(unlock),
    .alarm(alarm)
  );

  // Clock generator
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0; rst_n = 0; key_value = 0; key_valid = 0;

    // Reset release
    #10 rst_n = 1;

    // Correct Password
    #10 key_value=4'd1; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd2; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd3; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd4; key_valid=1; #10 key_valid=0;
     
    #10;

    #10 rst_n = 0; key_value = 0; key_valid = 0;
    
    #10 rst_n=1; 
    
    // Wrong Password
    #10 key_value=4'd1; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd2; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd3; key_valid=1; #10 key_valid=0;
    #10 key_value=4'd5; key_valid=1; #10 key_valid=0;

    #10;
    
    #10;
    
    $finish;
  end
endmodule
