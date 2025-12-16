module top (
	clk,
	reset,
	WriteData,
	DataAdr,
	MemWrite
);
	
	input wire clk;
	input wire reset;
	output wire [31:0] WriteData;
	

	wire [31:0] ReadData;

	risc risc(
		.clk(clk),
		.reset(reset),
		.PC(PC),
		.Inst(Instr),
		.MemWrite(MemWrite),
		.ALUResult(DataAdr),
		.WriteData(WriteData),
		.ReadData(ReadData)
	);
	
	imem imem(
		.a(PC),
		.rd(Instr)
	);

	dmem dmem(
		.clk(clk),
		.we(MemWrite),
		.a(DataAdr),
		.wd(WriteData),
		.rd(ReadData)
	);


endmodule
