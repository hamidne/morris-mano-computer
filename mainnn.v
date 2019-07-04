`include "ControlUnit.v"
`include "PC.v"
`include "DR.v"	
`include "AC.v"
`include "SequenceCounter.v"  
`include "Priority_Encoder_8to3.v" 
`include "AC_Arithmetic.v"	
`include "Mux8to3.v"
`define	BLE	16'b0

module Mainn(input CLK,output reg[15:0] mem9);

	wire[15:0] write_data, read_data; 
	reg [4095*16:0] mem2;
	
	reg[15:0] mem[0:4095];
	reg [15:0] r;
  
	initial begin
		mem[0] = 16'b0010000000000111; 
		mem[1] = 16'b0001000000001000;
		mem[2] = 16'b0011000000001001;
		mem[7] = 16'b0000000000000001;
		mem[8] = 16'b0000000000000010;
		mem[9] = 16'b0000000000000000;
	end	 
	
 // wire[0:15] mem1[0:4095];
 
// assign mem[1]=4'h1008;
  
	//input [15:0]mem1[0:4095];
	 // wire [0:15] mem1[0:4095];
	//output [0:15]memory;		
    //  reg [0:15]memory;
	//input [4095:0]mem1;
	//output wire [15:0]m[4095:0];	
	 //output reg d-out[4095:0];
	//wire [0:15] mem[0:4095];	
	integer i,j;
	/*initial
		begin
	for (i=0;i<4095;i=i+1)
		assign mem[i]=mem1[i];	   
	//for(i=0;i<4095;i=i+1)
		//for (j=0;j<15;j=j+1)
		end	 */
	wire[15:0] DataRead;
	wire[15:0] DataWrite; 
	
	
	wire [15:0] IR,AC,DR;						   
	wire [6:0] T;
	wire CLRAC, INRAC, LoadAC, SHR,SHL ,COM, INPT,DR1, ADD, AND, CLRAR, INRAR, LoadAR, CLRPC, INRPC, LoadPC, STR, LoadRAM, INRDR, LoadDR, CLRSC, S, LoadIR, LoadTR, E;
	wire LDA, cout;
	wire [2:0] d_out;
	
	wire compare;  
	wire[7:0] INPTR;

	wire[11:0] A;
	wire[11:0] PC;
	wire[15:0] Data;
	wire [11:0] Data2;	
	//integer i=0;
	//for(i;i<4095;i=i+1)
	//assign mem[i] =memory[i];
	
	
	assign compare = (INPTR < 8'b0 ? 1'b1 : 1'b0);
	
	assign Data2 = Data[11:0]; 
	
	PC ar(A, INRAR, Data2 ,LoadAR, CLK, CLRAR); 
	
	wire[15:0] mux1, mux2, mux3, mux4, mux5, mux6;
	reg[15:0] mux7;
	assign mux1={ 4'b0000, A[11:0]}; 
	
	wire [11:0] Data3, qpc;
	assign Data3=Data[11:0];
	PC pc(qpc, INRPC, Data3, LoadPC, CLK, CLRPC); 
	assign mux2={ 4'b0000, qpc[11:0]}; 
	
	DR dr(DR, INRDR, Data, LoadDR, CLK, CLRDR);
	assign mux3=DR;
	
	wire[15:0] ACDATA;
	AC_Arthemetic_Unit Ac_Arth(AC, AND, DR, ADD, INPR,INPT, LDA, COM, SHL, E, SHR, ACDATA, cout);
	
	AC ac(AC, INRAC, ACDATA, LoadAC, CLK, CLRAC);	
	assign mux4=AC;	
	
	
	reg[15:0] DataIR,DataTR;	
	always @(posedge CLK)
		begin
	assign DataIR=LoadIR ? Data : DataIR;
	end	   
	assign mux5=DataIR;
	
	always @(posedge CLK)
		begin
	assign DataTR=LoadTR ? Data : DataTR;
	end	
	assign mux6=DataTR;	
	
    controlUnit ctrlUnit(T,AC, DR,cout,CLK, IR, CLRAC, INRAC, LoadAC, SHR, SHL ,COM, INPT,LDA, ADD, AND, CLRAR, INRAR, LoadAR, CLRPC, INRPC, LoadPC, STR, LoadRAM, INRDR, LoadDR, CLRSC, S, LoadIR, LoadTR, E, X);
	prio_enco_8x3 pdec(d_out,X);	 
	Mulitplexer mu(16'bx, mux1,mux2,mux3, mux4, mux5, mux6, mux7,d_out,Data);
	
	wire Cscn;
	assign Cscn = ~CLRSC;
    wire countCounter, loadCounter;
    wire [2:0] DataCounter, outsc;	
	assign countCounter = Cscn & S;
	assign loadCounter = CLRSC & S; 
	assign DataCounter = Cscn ? 3'b001 : 3'b000;	   
	SequenceCounter sc (loadCounter, countCounter, DataCounter, CLK, outsc);  
	Decoder3to8 dec(outsc, T);
	
	always@(posedge CLK)
		begin
		//Memory memory( LoadRAM,STR, A, write_data, read_data);  
	//Memory M(CLK, LoadRAM,STR, A, write_data, read_data);
	if(LoadRAM)
		assign mux7=mem[A];
    else if(STR)
		mem[A] = Data;
  	end	 
	  
	 always @(CLK)
		assign  mem9[15:0]=mem[1];
	
	  
//assign	m=mem;
endmodule