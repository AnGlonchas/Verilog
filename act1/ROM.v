`timescale 1ns/1ns

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

module memorias_tb();
    reg clk;
    reg [7:0] direccion;
    reg [7:0] dato_in;
    reg enable;

    wire [7:0] dato_rom;
    wire [7:0] dato_srom;
    wire [7:0] dato_ram;

    // Instancias de los módulos
    rom u_rom(.direccion(direccion), .dato(dato_rom));
    srom u_srom(.clk(clk), .direccion(direccion), .dato(dato_srom));
    ram u_ram(.direccion(direccion), .dato_in(dato_in), .enable(enable), .dato(dato_ram));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // ROM
        direccion = 8'd0; enable = 0; #10;
        direccion = 8'd1; #10;
        direccion = 8'd2; #10;

        // SROM
        direccion = 8'd3; #10;
        direccion = 8'd4; #10;

        // RAM
        direccion = 8'd5; dato_in = 8'd99; enable = 1; #10;
        enable = 0; #10;

        direccion = 8'd6; dato_in = 8'd77; enable = 1; #10;
        enable = 0; #10;

        direccion = 8'd7; dato_in = 8'd55; enable = 1; #10;
        enable = 0; #10;

        $finish;
        //Que se vaya al tilín José Preciado 
        // Ese we
    end
endmodule