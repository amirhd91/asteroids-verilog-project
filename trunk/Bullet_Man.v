module Bullet_Man(
input [9:0] px,
input [9:0] py,
input clk_60hz,

input [9:0]shipX,
input shootUp,
input shootDown,
input [3:0]reset,
output [9:0] DEBUG,

output [3:0]pixel
);

//reg [3:0]direction; //not usedanymore
//reg [3:0]start_bullet; //not used anymore 
wire fire_delay;
wire [3:0] inUse;

wire direction;
assign direction = shootUp;

assign DEBUG[3:0] = inUse; //DEBUG
assign DEBUG[7:4] = fire; //DEBUG

Bullet B0(
	.px(px),
	.py(py),
	.clk_60hz(clk_60hz),
	.direction(direction),
	.start_bullet(fire[0]),
	.reset(reset[0]),
	.shipX(shipX),
	.pixel(pixel[0]),
	.inUse(inUse[0])
);

Bullet B1(
	.px(px),
	.py(py),
	.clk_60hz(clk_60hz),
	.direction(direction),
	.start_bullet(fire[1]),
	.reset(reset[1]),
	.shipX(shipX),
	.pixel(pixel[1]),
	.inUse(inUse[1])
);
Bullet B2(
	.px(px),
	.py(py),
	.clk_60hz(clk_60hz),
	.direction(direction),
	.start_bullet(fire[2]),
	.reset(reset[2]),
	.shipX(shipX),
	.pixel(pixel[2]),
	.inUse(inUse[2])
);
Bullet B3(
	.px(px),
	.py(py),
	.clk_60hz(clk_60hz),
	.direction(direction),
	.start_bullet(fire[3]),
	.reset(reset[3]),
	.shipX(shipX),
	.pixel(pixel[3]),
	.inUse(inUse[3])
);


/*
clk_5seconds(
	clk_60hz,
	clk_5seconds,
	ready,
	start);
*/

/* Shooting mechanism */
wire shoot = (shootUp || shootDown);
reg [3:0] fire;

always @ (clk_60hz) begin
	
	if (clk_60hz) begin
	@(posedge shoot) begin
		if (~inUse[0])
			fire[0] = 1'b1;
		else if (~inUse[1])
			fire[1] = 1'b1;
		else if (~inUse[2])
			fire[2] = 1'b1;
		else if (~inUse[3])
			fire[3] = 1'b1;
	end 
	
	end else @(negedge clk_60hz)fire = 4'b0000;
	
end

endmodule