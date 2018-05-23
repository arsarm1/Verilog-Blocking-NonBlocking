`timescale 1ns / 1ns

`define CLK_PERIOD 10

module tb_TEMP();
    
    reg CLK, RST, SHIFT;
    reg [31:0] DATA_IN;
    wire [31:0] DATA_OUT;
    
    TEMP UUT(.CLK       (CLK),
             .RST       (RST),
             .SHIFT     (SHIFT),
             .DATA_IN   (DATA_IN),
             .DATA_OUT  (DATA_OUT)
            );
    
    initial begin
        CLK = 1'b0;
        forever begin
            #(`CLK_PERIOD/2) CLK = ~CLK;
        end
    end
    
    initial begin
                        // Reset Circuit
                        RST = 1'b1; SHIFT = 1'b0; DATA_IN = 32'hF000_0001;
        #(`CLK_PERIOD)  $write("Reset Circuit: "); check(32'h0000_0000);
                            
                        // Test Regular Register Behavior
                        RST = 1'b0; SHIFT = 1'b0; DATA_IN = 32'hF000_0001;
        #(`CLK_PERIOD)  $write("Test Regular Register Behavior: "); check(32'hF000_0001);
                            
                        // Test Output Shift Behavior
                        RST = 1'b0; SHIFT = 1'b1; DATA_IN = 32'hF000_0001;
        #(`CLK_PERIOD)  $write("Test Output Shift Behavior: "); check(32'hE000_0002);
                            
                        // Halt simulation
                        $stop;
    end
    
    task check;
        input [31:0] expected_value;
    begin
        if (DATA_OUT == expected_value)
            $display("Pass");
        else
            $display("Fail");
    end
    endtask
        
endmodule
