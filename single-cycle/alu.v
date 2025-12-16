module alu(preSrcA,preSrcB,ALUControl,ALUResult,zero);
	input wire  [31:0] preSrcA;
	input wire  [31:0] preSrcB;
	input wire [2:0] ALUControl; 
	output reg [31:0] ALUResult;
	output wire zero;
	 
	wire [31:0] condinvb;
	wire [32:0] sum;
	wire [31:0] SrcA,SrcB;
	 
	assign SrcA = ALUControl[3] ? preSrcB: preSrcA; //reverse
	assign SrcB = ALUControl[3] ? preSrcA: preSrcB;
	 
	assign condinvb = ALUControl[0] ? ~SrcB : SrcB; //~Src2
	assign sum = SrcA + condinvb;
	
	assign zero = (ALUResult == 32'b0);

	always@(*)
	 	begin
			casex (ALUControl[2:0])
				3'b000:ALUResult = sum; //add
				3'b001:ALUResult = sum; //sub
				3'b011:ALUResult = SrcA || SrcB; //or
				4'b010:ALUResult = SrcA && SrcB; //and
				default:ALUResult =  sum;
			endcase
		end
endmodule
