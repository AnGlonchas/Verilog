`timescale 1ns/1ns

module halfadder(input bit1, bit2, output sum, extra);
    
    assign sum = bit1 ^ bit2;
    assign extra = bit1 & bit2;

endmodule