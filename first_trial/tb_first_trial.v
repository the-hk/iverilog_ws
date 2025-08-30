// tb_first_trial.v
`timescale 1ns/1ps

module tb_first_trial;
reg a, b;
wire y;

first_trial uut (
    .a(a),
    .b(b),
    .y(y)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_first_trial);

    a = 0; b = 0;
    #10 a = 1;
    #10 b = 1;
    #10 a = 0;
    #10 $finish;
end
endmodule
