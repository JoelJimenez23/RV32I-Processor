module alu(preSrcA,preSrcB,ALUControl,ALUResult,Zero,Sub);
	input wire  [31:0] preSrcA;
	input wire  [31:0] preSrcB;
	input wire [2:0] ALUControl; 
	output reg [31:0] ALUResult;
	output wire Zero;
	input wire Sub;

	wire [31:0] condinvb;
	wire [32:0] sum;
	wire [31:0] SrcA,SrcB;
	 
	//assign SrcA = ALUControl[3] ? preSrcB: preSrcA; //reverse
	//assign SrcB = ALUControl[3] ? preSrcA: preSrcB;
	assign SrcA = preSrcA;
	assign SrcB = preSrcB;

	assign condinvb = Sub ? ~SrcB : SrcB; //~Src2
	assign sum = SrcA + condinvb;
	
	assign Zero = (ALUResult == 32'b0);

	always@(*)
	 	begin
			casex (ALUControl[2:0])
				3'b000:ALUResult = sum; //add
				3'b001:ALUResult = SrcA << SrcB; //sll
				3'b010:ALUResult = (SrcA < SrcB) ? 1:0;  //slt
				3'b011:ALUResult = (SrcA < SrcB) ? 1:0; //sltu
				3'b100:ALUResult = SrcA ^ SrcB; //xor
				3'b101:ALUResult =  SrcA >> SrcB; //srl
				3'b110:ALUResult = SrcA || SrcB; //or
				3'b111:ALUResult = SrcA && SrcB; //and
				default:ALUResult =  sum;
			endcase
		end
endmodule
