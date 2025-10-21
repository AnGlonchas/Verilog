`timescale 1ns/1ns

module programCounter(
        input clk,
        input reg [31:0] counterIn,
        output reg [31:0] counterOut
    );

    initial begin 
        counterOut = 32'b0;
    end

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
    
    reg[31:0] Bank[0:255];

    initial begin
        $readmemb("Quesadilla/data.txt", Bank);
    end

    always @(dirIn) begin
        valueOut = Bank[dirIn];
    end

endmodule


module quesadilla(
        output [31:0] valueOut
    );
    
    reg clk;

    initial clk = 1'b0;

    always #50 clk = ~clk;

    wire [31:0] wPcIn, wPcOut;

    programCounter pc(
        .clk(clk),
        .counterIn(wPcIn),
        .counterOut(wPcOut)
    );

    adder add(
        .op1(4),
        .op2(wPcOut),
        .res(wPcIn)
    );

    memInstr memory(
        .dirIn(wPcOut),
        .valueOut(valueOut)
    );

endmodule