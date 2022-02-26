module DataMemory (output reg [31:0]ReadData, input MemoryRead, MemoryWrite, Clock, [5:0] Address, [31:0]WriteData);

reg [31:0] mem[0:63];

always @(posedge Clock) begin
	if(MemoryRead)
		ReadData <= mem[Address];
end

always @(negedge Clock) begin
	if(MemoryWrite)
		mem[Address] <= WriteData;
end

endmodule
