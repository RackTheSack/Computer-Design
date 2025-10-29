
// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

// alu op type
typedef enum logic [3:0] {
ALU_SLL     = 4'b0000,
ALU_SRL     = 4'b0001,
ALU_SRA     = 4'b0010,
ALU_ADD     = 4'b0011,
ALU_SUB     = 4'b0100,
ALU_AND     = 4'b0101,
ALU_OR      = 4'b0110,
ALU_XOR     = 4'b0111,
ALU_SLT     = 4'b1010,
ALU_SLTU    = 4'b1011
} aluop_t;

module alu_tb;

  parameter PERIOD = 10;


  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  alu_if aluif ();
  // test program
  test #(.PERIOD (PERIOD)) PROG(
    aluif
  );
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluif.alu_op (aluif.alu_op),
    .\aluif.neg (aluif.neg),
    .\aluif.ovf (aluif.ovf),
    .\aluif.zero (aluif.zero),
    .\aluif.presult (aluif.presult),
    .\aluif.pa (aluif.pa),
    .\aluif.pb (aluif.pb)
  );
`endif

endmodule

program test(alu_if.tb aluif);

parameter PERIOD = 10;

task set_ports;

input logic [31:0] a, b;
begin 
    aluif.pa = a;
    aluif.pb = b;
end
endtask

task operation;
input logic [3:0] op;
input logic [31:0] a, b;

begin 
    aluif.alu_op = op;
    set_ports(a,b);
    #(PERIOD);
end

endtask

initial begin
    
    
    operation(ALU_XOR, 'hAAAAAAAA, 'hFFFFFFFF);
    operation(ALU_ADD, 'h7FFFFFFF, 'h80000000);//presult = FFFFFFFF //adding +ve and negative
    operation(ALU_ADD, 'h80000000, 'h80000000);//presult = 100000000 and ovf //adding -ve and -ve overflow
    operation(ALU_SUB, 'hFFFFFFFF, 'h00000000);//presult = FFFFFFFF //sub +ve and -ve
    operation(ALU_SUB, 'hFFFFFFFD, 'hFFFFFFFC);//presult = 1 //sub -ve and -ve
    operation(ALU_SUB, 'hFFFFFFFC, 'hFFFFFFFD);//presult = FFFFFFFF and neg flag
    operation(ALU_AND, 'hAAAAAAAA, 'hFFFFFFFF);//presult = AAAAAAAA 
    operation(ALU_OR, 'hAAAAAAAA, 'h55555555);//presult = FFFFFFFF 
    operation(ALU_SLT, 'hA, 'h5);//presult = 0
    operation(ALU_SLT, 'hFFFFFFFF, 'h00000000);//presult = 1 
    operation(ALU_SLT, 'hFFFFFFFF, 'h80000000);//presult = 0 
    operation(ALU_SLTU, 'hFFFFFFFF, 'h00000000);//presult = 0
    operation(ALU_SLTU, 'hAAAAAAAA, 'hDDDDDDDD);//presult = 1
    operation(ALU_SLL, 'h2, 'h2);//8
    operation(ALU_SRL, 'h16, 'h3);//2
    operation(ALU_SRA, 'hFFFFFFF0,'h4);//all FF

   $finish;

  end
endprogram

