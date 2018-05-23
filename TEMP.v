`timescale 1ns / 1ns

`define BLOCKING

module TEMP(input wire CLK,
            input wire RST,
            input wire SHIFT,
            input wire [31:0] DATA_IN,
            output reg [31:0] DATA_OUT
           );
    
    always @(posedge CLK, posedge RST) begin
        if (RST) begin
            DATA_OUT <= 0;
        end
        else if (SHIFT) begin
            `ifdef BLOCKING
                DATA_OUT = DATA_OUT << 1;
            `else
                DATA_OUT <= DATA_OUT << 1;
            `endif
        end
        else begin 
            DATA_OUT <= DATA_IN;
        end
    end
    
endmodule
