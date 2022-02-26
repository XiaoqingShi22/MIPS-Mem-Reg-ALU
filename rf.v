module rf(output reg [31:0]BusA, reg [31:0] BusB , input RegWr , Clk, [31:0]BusW, [4:0]RA, [4:0]RB, [4:0]RW);
	reg [31:0] mem [0:31];

	
	always@(RA or mem[RA]) begin
		BusA <= mem[RA];
	end

	always@(RB or mem[RB]) begin
		BusB <= mem[RB];
	end

	always@(posedge Clk) begin
		if((RegWr) && (RW != 5'b00000))
			mem[RW] <= BusW;
		
	end

	initial 
		mem[0] = 32'b0;	
		
	

endmodule