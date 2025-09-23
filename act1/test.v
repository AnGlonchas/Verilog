´timescale 1ns/1ns


module halfadder(input a, b, output c, cout);
    
    assign c = a ^ b;
    assign cout = a & b;

endmodule

module fulladder(input a, b, cin, output c, cout);

    wire wSum, wCout;

    halfadder HA1(
        .a(a),
        .b(b),
        .c(wSum),
        .cout(wCout)
    );

    halfadder HA2(
        .a(wSum),
        .b(cin),
        .c(wSum),
        .cout(cout)

    );

endmodule