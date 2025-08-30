// tb_counter.v
`timescale 1ns/1ps

module tb_counter;

reg clk;
reg rst;
wire [3:0] count;

// Instantiate DUT
counter uut (
    .clk(clk),
    .rst(rst),
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
    $dumpvars(0, tb_counter);
end

endmodule
