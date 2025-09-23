`timescale 1ns/1ns
// Testbench at the bottom of the file

 

module halfadder(input bit1, bit2, output sum, extra);
    
    assign sum = bit1 ^ bit2;
    assign extra = bit1 & bit2;

endmodule

module fulladder(input bit1, bit2, cin, output sum, extra);
    
    wire wSum, wCarry;

    halfadder sum1(
        .bit1(bit1),
        .bit2(bit2),
        .sum(wSum),
        .extra(wCarry)
    );

    halfadder sum2(
        .bit1(wSum),
        .bit2(wCarry),
        .sum(sum),
        .extra(extra)
    );

endmodule

module fulladder4bits(input [3:0] num1, [3:0] num2, [3:0] cin, output [3:0] sum, [3:0] extra);

        fulladder addbit1(
            .bit1(num1[0]),
            .bit2(num2[0]),
            .cin(cin[0]),
            .sum(sum[0]),
            .extra(extra[0])
        );

        fulladder addbit2(
            .bit1(num1[1]),
            .bit2(num2[1]),
            .cin(cin[1]),
            .sum(sum[1]),
            .extra(extra[1])
        );

        fulladder addbit3(
            .bit1(num1[2]),
            .bit2(num2[2]),
            .cin(cin[2]),
            .sum(sum[2]),
            .extra(extra[2])
        );

        fulladder addbit4(
            .bit1(num1[3]),
            .bit2(num2[3]),
            .cin(cin[3]),
            .sum(sum[3]),
            .extra(extra[3])
        );
    
endmodule


module extendedALU(
        input [3:0] iNibble1, 
        input [3:0] iNibble2, 
        input [2:0] selector, 
        input [3:0] cin,
        output reg [3:0] result
    );

    wire [3:0] resultWire;
    wire [3:0] extraWire;

    fulladder4bits add(
        .num1(iNibble1),
        .num2(iNibble2),
        .cin(cin),
        .sum(resultWire),
        .extra(extraWire)
    );

    always @* begin
        case(selector)

            3'd0:
                begin
                    result = iNibble1 + iNibble2;
                end

            3'd1:
                begin 
                    result = iNibble1 - iNibble2;
                end

            3'd2:
                begin 
                    result = iNibble1 & iNibble2;
                end

            3'd3:
                begin 
                    result = iNibble1 | iNibble2;
                end

            3'd4:
                begin
                    result = iNibble1 ^ iNibble2;
                end
        endcase
    end

    //assign oNibble = result;

endmodule


//Testbench
module testbenchFullALU();
        
    reg [3:0] Input1, Input2, Output, cin;
    reg Selector;
    wire [3:0] Result;

    extendedALU DUV(
        .iNibble1(Input1), 
        .iNibble2(Input2), 
        .cin(cin),
        .selector(Selector), 
        .result(Result)
    );

    initial begin
        #100;
        Input1 <= 4'd5;
        Input2 <= 4'd7;
        Selector <= 1'b0;

        #100;
        Input1 <= 4'd5;
        Input2 <= 4'd10;
        Selector <= 1'b1;

    end

endmodule