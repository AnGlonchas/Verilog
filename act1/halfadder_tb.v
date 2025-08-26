`timescale 1ns/1ns

module halfadder_tb();
    
    reg bit1_tb, bit2_tb;
    wire sum_tb, extra_tb;

    halfadder DUV(
        .bit1(bit1_tb),
        .bit2(bit2_tb),
        .sum(sum_tb),
        .extra(extra_tb)
    );

    initial begin
        bit1_tb = 0;
        bit2_tb = 0;
        #100;

        bit1_tb = 1;
        bit2_tb = 0;
        #100;

        bit1_tb = 0;
        bit2_tb = 1;
        #100;

        bit1_tb = 1;
        bit2_tb = 1;
        #100;

        $stop;

    end
endmodule