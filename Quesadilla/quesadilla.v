`timescale 1ns/1ns

module shiftLeft(
        input [25:0] number,
        output [27:0] outNumber
    );
    
    assign outNumber = number << 2;
    
endmodule

module RAM(
        input reg memRead,
        input reg memWrite,
        input reg [31:0] addrIn,
        input reg [31:0] dataIn,
        output reg [31:0] dataOut
    );
    
    reg[31:0] memory [0:255];

    always@* begin
        if(memRead) begin
            dataOut = memory[addrIn];
        end
        if(memWrite) begin 
            memory[addrIn] = dataIn;
        end
    end

endmodule

module RegisterBank(
        input [4:0] ReadReg1,
        input [4:0] ReadReg2,
        input [4:0] WriteReg,
        input [31:0] writeData,
        input regWrite,
        output reg[31:0] ReadData1,
        output reg[31:0] ReadData2
    );

    reg[31:0] Bank[0:31];
    integer i;

    initial begin

        $readmemb("data.txt", Bank);
    end
    always @* begin

        ReadData1 = Bank[ReadReg1];
        ReadData2 = Bank[ReadReg2];

        if(regWrite) begin

            Bank[WriteReg] = writeData;
        end 
    end 

endmodule

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


module testbench();
        
    reg [31:0] tbdataOut, tbaddrIn, tbdataIn;
    reg read;
    reg write;

    RAM ram(
        .memRead(read),
        .memWrite(write),
        .addrIn(tbaddrIn),
        .dataIn(tbdataIn),
        .dataOut(tbdataOut)
    );

    initial begin
        #50;
        read = 0;
        write = 1;
        tbaddrIn = 32'd5;
        tbdataIn = 32'd99;

        #50;
        read = 1;
        write = 0;
        tbaddrIn = 32'd5;
        
        $stop;

    end
endmodule