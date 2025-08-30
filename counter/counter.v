// counter.v
module counter (
    input wire clk,
    input wire rst,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 0;
    else
        count <= count + 1;
end

endmodule
