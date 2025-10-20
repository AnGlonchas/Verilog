`timescale 1ns/1ns

module programCounter(
        input clk,
        input reg [31:0] counterIn,
        output reg [31:0] counterOut
    );

    always @(clk) begin
        counterOut = counterIn + 4;
    end

endmodule

module adder(
        input [31:0] op1,
        input [31:0] op2,
        output [31:0] res
    );

    assign res = op1 + op2;

endmodule

module memInstr(
        input reg [31:0] dirIn,
        output reg [31:0] valueOut
    );
    
    reg [31:0] Bank [0:255];

    initial begin
        $readmemb("data.txt", Bank);
    end

    always @(dirIn) begin
        valueOut = Bank[dirIn];
    end

endmodule


module quesadilla(
        output [31:0] valueOut
    );
    
    wire clk, wCounter, wPcout, wSum;

    programCounter pc(
        .clk(clk),
        .counterIn(wCounter),
        .counterOut(wPcout)
    );

    memInstr memory(
        .dirIn(wPcout),
        .valueOut(valueOut)
    );

endmodule