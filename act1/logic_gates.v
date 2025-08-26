
module logic_gates(input bit1, bit2, output _and, _nand, _or, _nor, _not, _xor, _xnor);
    assign _and = bit1 & bit2;
    assign _nand = !(bit1 & bit2);
    assign _or = bit1 | bit2;
    assign _nor = !(bit1 | bit2);
    assign _not = !bit1;
    assign _xor = bit1 ^ bit2;
    assign _and = !(bit1 ^ bit2);

endmodule