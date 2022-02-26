module forwardingunit(UseShamt,UseImmed,ID_Rs,ID_Rt,EX_Rw,MEM_Rw,EX_RegWrite,MEM_RegWrite,
					  AluOpCtrlA,AluOpCtrlB,DataMemForwardCtrl_EX,DataMemForwardCtrl_MEM);

	input 			UseShamt;				// For shift
	input			UseImmed;				// For immediate
	input 		    EX_RegWrite;			// Register Write in EX stage	
	input 			MEM_RegWrite;			// Register Write in MEM stage	
	input[4:0] 		ID_Rs;					// Rs in Decode stage
	input[4:0] 		ID_Rt;					// Rt in Decode stage
	input[4:0] 		EX_Rw;					// Rw in Execute stage
	input[4:0] 		MEM_Rw;					// Rw in Memory stage

	output reg 		DataMemForwardCtrl_EX;	// Memory Forwarding in Execute stage
	output reg 		DataMemForwardCtrl_MEM; // Memory Forwarding in Memory stage
	output reg[1:0] AluOpCtrlA; 			// Alu busA select
	output reg[1:0] AluOpCtrlB;				// Alu busB select

	always@(*) begin
		if(UseShamt) begin
			AluOpCtrlA <= 2'b00;
		end
		else if((ID_Rs != 5'b0) && (ID_Rs == EX_Rw) && EX_RegWrite) begin
			AluOpCtrlA <= 2'b10;
		end
		else if((ID_Rs != 5'b0) && (ID_Rs == MEM_Rw) && MEM_RegWrite) begin
			AluOpCtrlA <= 2'b01;
		end
		else begin
			AluOpCtrlA <= 2'b11;
		end

		
	end // always@(*)

	always@(*) begin
		if(UseImmed) begin
			AluOpCtrlB <= 2'b00;
		end
		else if((ID_Rt == EX_Rw) && EX_RegWrite) begin
			AluOpCtrlB <= 2'b10;
		end
		else if((ID_Rt == MEM_Rw) && MEM_RegWrite) begin
			AluOpCtrlB <= 2'b01;
		end
		else begin
			AluOpCtrlB <= 2'b11;
		end

		if(ID_Rt == MEM_Rw) begin
			DataMemForwardCtrl_EX <= 1'b1;
		end
		else begin
			DataMemForwardCtrl_EX <= 1'b0;
		end

		if(ID_Rt == EX_Rw) begin
			DataMemForwardCtrl_MEM <= 1'b1;
		end
		else begin
			DataMemForwardCtrl_MEM <= 1'b0;
		end
		
	end // always@(*)
endmodule 	