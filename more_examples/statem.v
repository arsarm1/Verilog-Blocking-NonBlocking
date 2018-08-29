// Code originally from:
// https://www.intel.com/content/www/us/en/programmable/support/support-resources/design-examples/design-software/verilog/ver_statem.html

`timescale 1 ns / 1 ps

`define BLOCK_NON_BLOCK <=

module statem(clk, in, reset, out, out2);

    input wire clk, in, reset;
    output wire [3:0] out;
    output reg [3:0] out2;

    reg [3:0] out;
    reg [1:0] state;
    
    parameter zero=0, one=1, two=2, three=3;
    
    always @(*) begin
        out2 `BLOCK_NON_BLOCK in & count;
    end
    
    reg [3:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
        end
        else begin
            count <= count + 1;
        end
    end
    
    always @(state) begin
        case (state)
            zero:
                out `BLOCK_NON_BLOCK 4'b0000;
            one:
                out `BLOCK_NON_BLOCK 4'b0001;
            two:
                out `BLOCK_NON_BLOCK 4'b0010;
            three:
                out `BLOCK_NON_BLOCK 4'b0100;
            default:
                out `BLOCK_NON_BLOCK 4'b0000;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= zero;
        end
        else begin
            case (state)
                zero:
                    state <= one;
                one:
                    if (in)
                        state <= zero;
                    else
                        state <= two;
                two:
                    state <= three;
                three:
                    state <= zero;
                default:
                    state <= zero;
            endcase
        end
    end

endmodule