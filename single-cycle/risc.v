module risc(
	clk,
	reset,
	PCF,
	Instr,
	MemWrite,
	ALUResult,
	WriteData,
	ReadData
);

	input wire clk;
	input wire reset;
	output wire [31:0] PC;
	input wire [31:0] Instr;
	output wire MemWrite;
	output wire [31:0] ALUResult;
	output wire [31:0] WriteData;
	input wire [31:0] ReadData;

	controller cl(
		.clk(clk),
		.reset(reset),
		.Funct7(Instr[31:25]),
		.Funct3(Instr[14:12]),
		.OPcode(Instr[6:0]),
		.PCsrc(PCSrc),
		.ResultSrc(ResultSrc),
		.MemWrite(MemWrite),
		.ALUControl(ALUControl),
		.ALUSrc(ALUSrc),
		.ImmSrc(ImmSrc),
		.RegWrite(RegWrite)
	);


	datapath dp(
		.clk(clk),
		.reset(reset),
		.PC(PC),
		.Instr(Instr),
		.PCSrc(PCSrc),
		.ResultSrc(ResultSrc),
		.ALUControl(ALUControl),
		.ALUSrc(ALUSrc),
		.ImmSrc(ImmSrc),
		.RegWrite(RegWrite),
		.ALUResult(ALUResult),
		.WriteData(WriteData),
		.ReadData(ReadData)
	);

endmodule
