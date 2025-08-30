// first_trial.v
module first_trial(
    input wire clk,
    input wire rst,
    output reg y,
    output reg [31:0] count
);

localparam IDLE = 3'b000;
localparam SUM = 3'b001;
localparam MULT = 3'b010;
localparam DIV = 3'b011;
localparam EXT = 3'b100;

reg a = 1;
reg b = 1;

reg [2:0]curr_state;
reg [2:0]next_state;
reg [31:0]firstArr = 32'h00000002;
reg [31:0]secondArr = 32'h00000003;
reg [31:0]thirdArr = 32'h00000000;
reg [31:0]fourthArr = 32'h00000000;
reg [31:0]result1Arr = 32'h00000000;
reg [31:0]result2Arr = 32'h00000000;

always @(*) begin
    y = a & b;
end
 
// first process
always @(posedge clk or posedge rst) begin

    if (rst) begin
        curr_state <= IDLE;  // asynchronous reset
        count <= 0;
        firstArr <= 32'h00000002;
        result1Arr <= 32'h00000003;
    end
    else begin
        case(curr_state)
            IDLE: begin
                firstArr <= 32'h00000002;
                result1Arr <= 32'h00000003;
                count <= result1Arr;
                curr_state <= SUM;
            end 
            SUM: begin
                result1Arr <= firstArr + result1Arr;
                curr_state <= MULT;
                b <= 0;
            end
            MULT: begin
                result1Arr <= firstArr * result1Arr;
                firstArr <= firstArr + 2'b11;
                a <= 0;
                curr_state <= DIV;
            end
            DIV: begin
                result1Arr <= result1Arr / firstArr;
                a <= 1;
                b <= 1;
                curr_state <= EXT;
            end
            EXT: begin
                result1Arr <= firstArr - result1Arr;
                curr_state <= IDLE;
            end
            default: begin
                curr_state <= IDLE;
            end
        endcase
    end

end
// second process
always @(posedge clk or posedge rst) begin
 if (rst) begin
        next_state <= IDLE;  // asynchronous reset
        thirdArr <= 32'h3;
        fourthArr <= 32'h4;
        result2Arr <= 32'h5;
    end
    else begin
        case(next_state)
            IDLE: begin
                thirdArr <= 32'h3;
                fourthArr <= 32'h4;
                result2Arr <= 32'h5;
                next_state <= SUM;
            end 
            SUM: begin
                thirdArr <= 32'h6;
                fourthArr <= 32'h7;
                result2Arr <= 32'h8;
                next_state <= MULT;
            end 
            MULT: begin
                thirdArr <= 32'h9;
                fourthArr <= 32'ha;
                result2Arr <= 32'hb;
                next_state <= DIV;
            end
            DIV: begin
                thirdArr <= 32'hc;
                fourthArr <= 32'hd;
                result2Arr <= 32'he;
                next_state <= EXT;
            end
            EXT: begin
                thirdArr <= 32'hf;
                fourthArr <= 32'h10;
                result2Arr <= 32'h11;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
