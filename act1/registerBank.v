`timescale 1ns/1ns

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

module BankTB;

  reg [4:0] Direccion1, Direccion2, DirEsc;
  reg enable;
  reg [31:0] dato;
  wire [31:0] Resultado1, Resultado2;

  RegisterBank regBank(
	.ReadReg1(Direccion1),
	.ReadReg2(Direccion2),
	.WriteReg(DirEsc),
	.writeData(dato),
	.regWrite(enable),
	.ReadData1(Resultado1),
	.ReadData2(Resultado2)
  );

  initial begin
    enable = 1;
    DirEsc = 5'd3;
    dato = 100;
    #10;

    enable = 0;
    Direccion1 = 5'd3;
    Direccion2 = 5'd0;
    #10;

    enable = 1;
    DirEsc = 5'd10;
    dato = 250;
    #10;

    enable = 0;
    Direccion1 = 5'd10;
    Direccion2 = 5'd3;
    #10;

    enable = 1;
    DirEsc = 5'd31;
    dato = 9999;
    #10;

    enable = 0;
    Direccion1 = 5'd31;
    Direccion2 = 5'd10;
    #10;

    Direccion1 = 5'd5;
    Direccion2 = 5'd6;
    #10;

    $finish;
  end

endmodule