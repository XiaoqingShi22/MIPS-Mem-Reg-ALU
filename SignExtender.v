module SignExtender(SignExtImm, Imm, SignExtend);
	
	input [15:0] Imm;
	input SignExtend;
	output [31:0] SignExtImm;
	
	assign SignExtImm = (SignExtend) ? {{16{Imm[15]}},Imm[15:0]} : {16'h0000,Imm[15:0]};
	
endmodule