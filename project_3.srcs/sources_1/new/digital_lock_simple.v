module digital_lock_simple (
    input  wire clk,
    input  wire rst_n,         // active low reset
    input  wire [3:0] key_value, // digit entered (0-9)
    input  wire key_valid,     // 1 when a digit is pressed
    output reg unlock,
    output reg alarm           // 1 = wrong password
);
    // Parameters
    parameter DIGITS   = 4;
    parameter [15:0] PASSWORD = 16'h1234; // password = 1,2,3,4

    // Registers
    reg [15:0] entered; 
    reg [1:0] index;    

    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            index   <= 0;
            unlock  <= 0;
            alarm   <= 0;
            entered <= 0;
        end else begin
            if (key_valid) begin
                entered <= {entered[11:0], key_value};
                index   <= index + 1;

                if (index == DIGITS-1) begin
                    if ({entered[11:0], key_value} == PASSWORD) begin
                        unlock <= 1;
                        alarm  <= 0;
                    end else begin
                        unlock <= 0;
                        alarm  <= 1;
                    end
                    index <= 0; 
                end
            end
        end
    end
endmodule