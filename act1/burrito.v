`timescale 1ns/1ns

module registerBank(

        input reg[4:0] readReg1,
        input reg[4:0] readReg2,
        input reg[4:0] writeReg,
        
        input reg[31:0] writeData,
        
        input regWrite,
        
        output reg[31:0] readData1,
        output reg[31:0] readData2
    );


    reg[31:0] Bank[0:31];
    
    initial begin
        $readmemb("data.txt", Bank);
    end
    
    always @* begin
    
        readData1 = Bank[readReg1];
        readData2 = Bank[readReg2];
        
        if(regWrite) begin
        
            Bank[writeReg] = writeData;
        
        end
    
    end
    
endmodule

module ALU(
        input reg[31:0] a, b,
        input reg[2:0] sel,
        output reg[31:0] out
    );
    
    always @* begin
        case(sel)
            3'd0: out = a + b;
            3'd0: out = a - b;
            3'd0: out = (a > b) ? 3'b1 : 3'b0;
            3'd0: out = a & b;
            3'd0: out = a | b;
            3'd0: out = a ^ b;
            
        endcase
    end
    
endmodule

module burrito(
        input[4:0] readReg1, readReg2, writeReg,
        input[2:0] selector
    );
    
    /*
    burrito(input[17:0] instruction);
    wire[4:0] readReg1 = instruction[0:4];
    wire[4:0] readReg2 = instruction[5:9];
    wire[4:0] writeReg = instruction[10:14];
    wire[2:0] selector;
    */

    wire[31:0] bankOut1, bankOut2, bankInData;
    
    ALU tortilla(
        .a(bankOut1),
        .b(bankOut1),
        .sel(selector),
        .out(bankInData)
    );
    
    registerBank regBank(
        .readReg1(readReg1),
        .readReg2(readReg2),
        .writeReg(writeReg),
        .writeData(bankInData),
        .regWrite(1'b0),
        .readData1(bankOut1),
        .readData2(bankOut2)
    );
    
endmodule

module burritoTB();
    
    reg[4:0] readAddr1, readAddr2, writeAddr;
    reg[2:0] selector;
     
    burrito DUV(
        .selector(selector),
        .readReg1(readAddr1),
        .readReg2(readAddr2),
        .writeReg(writeAddr)
    );

    initial begin
        selector = 3'd0;
        readAddr1 = 5'd13;
        readAddr2 = 5'd10;
        writeAddr = 5'd8;
        #10;
        
        selector = 3'd1;
        readAddr1 = 5'd12;
        readAddr2 = 5'd9;
        writeAddr = 5'd1;
        #10;
        
        selector = 3'd2;
        readAddr1 = 5'd11;
        readAddr2 = 5'd8;
        writeAddr = 5'd5;
        #10;
        
        selector = 3'd3;
        readAddr1 = 5'd10;
        readAddr2 = 5'd7;
        writeAddr = 5'd6;
        #10;
        
        selector = 3'd0;
        readAddr1 = 5'd19;
        readAddr2 = 5'd6;
        writeAddr = 5'd9;
        #10;
        
        selector = 3'd1;
        readAddr1 = 5'd18;
        readAddr2 = 5'd5;
        writeAddr = 5'd3;
        #10;
        
        selector = 3'd2;
        readAddr1 = 5'd17;
        readAddr2 = 5'd4;
        writeAddr = 5'd18;
        #10;
        
        selector = 3'd3;
        readAddr1 = 5'd16;
        readAddr2 = 5'd3;
        writeAddr = 5'd22;
        #10;
        
        $stop;

    end
    
endmodule
