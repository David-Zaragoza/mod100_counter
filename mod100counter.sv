module mod100counter
(
	input  logic       clk, 
	input  logic       rst, 
	input  logic       SW0, 
	input  logic       KEY0, 
	input  logic       KEY1, 
	output logic [6:0] HEX0, 
	output logic [6:0] HEX1
	);
	logic [3:0] counter1;
	logic [3:0] counter10;
	logic [26:0] count50;
	logic [26:0] count100;
	logic increment0;
	logic increment1;
	logic decrement0;
	logic decrement1;
	logic numberOne;
	logic numberTwo;
	assign numberOne = (!SW0 && (count50 == 27'd25000000));
	assign numberTwo = (SW0 && (count100 == 27'b0));
	assign increment0 = (KEY0 && !KEY1 && numberOne);
	assign increment1 = (KEY0 && !KEY1 && numberTwo);
	assign decrement0 = (KEY1 && !KEY1 && numberOne);
	assign decrement1 = (KEY1 && !KEY0 && numberTwo);
	counterthirteen #(50000000) counter50(.clk(clk), .rst(rst), .inc(1'b1), .dec(1'b0), .cnt(count50));
	counterthirteen #(100000000) counter100(.clk(clk), .rst(rst), .inc(1'b1), .dec(1'b0), .cnt(count100));
	counterthirteen #(10) onesPlace(.clk(clk), .rst(rst), .inc(increment0||increment1), .dec(decrement0||decrement1), .cnt(counter1));
	counterthirteen #(10) tensPlace(.clk(clk), .rst(rst), .inc(increment0 && counter1 == 9||increment1 && counter1 == 9), .dec(decrement0 && counter1 == 0||decrement1 && counter1 == 0), .cnt(counter10));
	lab1display unos (.a(counter1), .z(HEX0));
	lab1display diez (.a(counter10), .z(HEX1));
endmodule
