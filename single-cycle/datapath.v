module datapath(
	clk,
	reset,
	PC,
	Instr,
	PCSrc,
	ResultSrc,
	ALUControl,
	ALUSrc,
	ImmSrc,
	RegWrite,
	ALUResult,
	WriteData,
	ReadData
);

	input wire clk;
	input wire reset;
	output wire [31:0] PC;
	input wire [31:0] Instr;
	input wire PCSrc;
	input wire ResultSrc;
	input wire [2:0] ALUControl;
	input wire ALUSrc;
	input wire [1:0] ImmSrc;
	input wire RegWrite;
	output wire [31:0] ALUResult;
	output wire [31:0] WriteData;
	input wire [31:0] ReadData;

	
	mux #(32) pcmux(
		.d0(PCPlus4),
		.d1(PCTarget),
		.s(PCSrc),
		.y(PCNext)
	);

	
	flopr #(32) pcreg(
		.clk(clk),
		.reset(reset),
		.d(PCNext),
		.q(PC)
	);

	
	adder #(32) adder_pcplus(
		.a(PC),
		.b(32'b100),
		.y(PCPlus4)
	);
	

	regfile(
		.clk(clk),
		.we3(RegWrite),
		.ra1(Instr[19:15]),
		.ra2(Instr[24:20]),
		.ra3(Instr[11:7]),
		.wd3(Result),
		.rd1(SrcA),
		.rd2(preSrcB)
	);

	extend ex(
		.Instr(Instr[31:7]),
		.ImmSrc(ImmSrc),
		.ExtImm(ImmExt)
	);


	mux #(32) SrcBmux(
		.d0(preSrcB),
		.d1(ImmExt),
		.s(ALUSrc),
		.y(SrcB)
	);

	alu al(
		.preSrcA(SrcA),
		.preSrcB(SrcB),
		.ALUControl(ALUControl),
		.ALUResult(ALUResult),
		.zero(zero)
	);

	adder #(32) adder_pctarget(
		.a(PC),
		.b(ImmExt),
		.y(PCTarget)
	);


	mux3 #(32) Resultmux(
		.d0(ALUResult),
		.d1(ReadData),
		.d2(PCPlus4),
		.s(ResultSrc),
		.y(Result)
	);



endmodule
