module extend (
	Instr,
	ImmSrc,
	ExtImm
);
	input wire [23:0] Instr;
	input wire [1:0] ImmSrc;
	output reg [31:0] ExtImm;
	always @(*)
		case (ImmSrc)
			2'b00: ExtImm = {{20 {Instr[31]}}, Instr[31:20] };
			2'b01: ExtImm = {{20 {Instr[31]}}, Instr[31:25], Instr[11:7] };
			2'b10: ExtImm = {{20 {Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
			default: ExtImm = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
		endcase
endmodule
