module PS2(
	input clk25,
	input clr,
	input PS2C,
	input PS2D,
	output reg [7:0] data,
	output reg ready
);

	reg PS2Cf, PS2Df;
	reg [7:0] ps2c_filter, ps2d_filter;
	reg [10:0] shift1, shift2;

	always @(posedge clk25)// 取值防干扰，参考书上，不做赘述
	begin
		ps2c_filter[7] <= PS2C;
		ps2c_filter[6:0] <= ps2c_filter[7:1];
		ps2d_filter[7] <= PS2D;
		ps2d_filter[6:0] <= ps2d_filter[7:1];
		if (ps2c_filter == 8'b11111111)
		begin
			PS2Cf <= 1;
		end
		else
		if (ps2c_filter == 8'b00000000)
		begin
			PS2Cf <= 0;
		end
		if (ps2d_filter == 8'b11111111)
		begin
			PS2Df <= 1;
		end
		else
		if (ps2d_filter == 8'b00000000)
		begin
			PS2Df <= 0;
		end
	end

	always @(negedge PS2Cf)
	begin
		shift1 <= {PS2Df, shift1[10:1]};
		shift2 <= {shift1[0], shift2[10:1]};
	end
	
always @(posedge clk25)
begin
	if (shift2[8:1] != 8'hF0) begin ready <= 1; data <= shift1[8:1]; end
	else begin ready <= 0; data <= 8'b0; end
end

endmodule 