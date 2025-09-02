`timescale 1ns/1ns

module ALU(
        input [3:0] iNibble1, 
        input [3:0] iNibble2, 
        input selector, 
        output reg [3:0] result
    );

    always @* begin
        case(selector)

            0'b0:
                begin 
                    result = iNibble1 + iNibble2;
                end

            1'b0:
                begin 
                    result = iNibble1 & iNibble2;
                end
	    endcase
    end

    //assign oNibble = result;

endmodule


//Testbench
module testbench();
        
    reg [3:0] Input1, Input2, Output;
    reg Selector;
    wire [3:0] Result;

    ALU unit(
        .iNibble1(Input1), 
        .iNibble2(Input2), 
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