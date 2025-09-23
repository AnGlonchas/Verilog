´timescale 1ns/1ns

module rom(input [7:0] direccion, output reg [7:0] dato);

    reg [7:0] ROM [0:10];

    initial begin
        ROM[0] = 8'd90;
        ROM[1] = 8'd80;
        ROM[2] = 8'd70;
        ROM[3] = 8'd60;
        ROM[4] = 8'd50;
        ROM[5] = 8'd40;
        ROM[6] = 8'd30;
        ROM[7] = 8'd20;
        ROM[8] = 8'd10;
        ROM[9] = 8'd01;
        ROM[10] = 8'd100;
    end

    always @* begin

        dato = ROM[direccion];

    end

endmodule

module srom(input [7:0] direccion, input clk, output reg [7:0] dato);

    reg [7:0] ROM [0:10];

    initial begin
        ROM[0] = 8'd90;
        ROM[1] = 8'd80;
        ROM[2] = 8'd70;
        ROM[3] = 8'd60;
        ROM[4] = 8'd50;
        ROM[5] = 8'd40;
        ROM[6] = 8'd30;
        ROM[7] = 8'd20;
        ROM[8] = 8'd10;
        ROM[9] = 8'd01;
        ROM[10] = 8'd100;
    end

    always @(posedge clk) begin

        dato = ROM[direccion];

    end

endmodule

module ram(input [7:0] direccion, input [7:0] dato_in, input enable, output reg [7:0] dato);

    reg [7:0] RAM [0:10];

    initial begin
        RAM[0] = 8'd90;
        RAM[1] = 8'd80;
        RAM[2] = 8'd70;
        RAM[3] = 8'd60;
        RAM[4] = 8'd50;
        RAM[5] = 8'd40;
        RAM[6] = 8'd30;
        RAM[7] = 8'd20;
        RAM[8] = 8'd10;
        RAM[9] = 8'd01;
        RAM[10] = 8'd100;
    end

    always @* begin

        if(enable) begin
            RAM[direccion] = dato_in;
        end
        else begin
            dato = RAM[direccion];
        end

    end

endmodule

module rom_tb();

    

endmodule