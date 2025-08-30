// tb_first_trial.v
`timescale 1ns/1ps

module tb_first_trial;
reg clk;
reg rst;
wire y;
wire [31:0] count;


first_trial uut (
    .clk(clk),
    .rst(rst),
    .y(y),
    .count(count)
);

// Clock generation (10ns period)
always #5 clk = ~clk;

initial begin
    // Init signals
    clk = 0;
    rst = 1;
    #10;
    rst = 0;

    // Run for 200ns then stop
    #200;
    $finish;
end

// Dump waveform
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_first_trial);
end

endmodule
