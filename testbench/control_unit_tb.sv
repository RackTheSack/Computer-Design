
// mapped needs this
`include "control_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;



// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

    logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  logic CPUCLK = 0;

  always #(PERIOD) CPUCLK++;


  control_unit_if cuif ();

  // test program
  test #(.PERIOD (PERIOD)) PROG(cuif);
  // DUT
`ifndef MAPPED
   control_unit DUT(cuif);
`else
   DUT(
    .\cuif.zero (cuif.zero),
    .\cuif.halt (cuif.halt),
    .\cuif.ALUsrc (cuif.ALULsrc),
    .\cuif.PCsrc (cuif.PCsrc),
    .\cuif.jal (cuif.jal),
    .\cuif.jalr (cuif.jalr),
    .\cuif.auipc (cuif.auipc),
    .\cuif.branch (cuif.branch),
    .\cuif.alu_op (cuif.alu_op),
    .\cuif.imemload (cuif.imemload),
    .\cuif.presult (cuif.presult),
  );
`endif

endmodule

program test(control_unit_if.tb cuif);

parameter PERIOD = 10;
string test_case;

initial begin

    cuif.zero = 0;
    cuif.presult = 0;
    
    test_case = "add x1, x1, x2";
    cuif.imemload = 32'h002080b3; //add x1, x1, x2
    #(PERIOD);

    test_case = "sub x1, x1, x2";
    cuif.imemload = 32'h402080b3; //sub x1, x1, x2
    #(PERIOD); 

    test_case = "addi x1, x1, 2";
    cuif.imemload = 32'h00208093; //addi x1, x1, 2
    #(PERIOD); 

    test_case = "jal x1, loop";
    cuif.imemload = 32'h004000ef; //jal x1, loop
    #(PERIOD); 

    test_case = "jalr x1, 0(x1)";
    cuif.imemload = 32'h000080e7; //jalr x1, 0(x1)
    #(PERIOD); 

    test_case = "lw x2, 0(x1)";
    cuif.imemload = 32'h0000a103; //lw x2, 0(x1)
    #(PERIOD);

    test_case = "sw x2, 0(x1)";
    cuif.imemload = 32'h0020a023; //sw x2, 0(x1)
    #(PERIOD); 

    test_case = "bqe x1, x1, loop";
    cuif.zero = 1;
    cuif.imemload = 32'h00108263; //bqe x1, x1, loop // it should take  branch
    #(PERIOD); 

    test_case = "beq x1, x2, loop";
    cuif.zero = 0;
    cuif.imemload = 32'h00208263; //beq x1, x2, loop // it should not take branch
    #(PERIOD); 

    test_case = "bne x1, x1, loop";
    cuif.zero = 1;
    cuif.imemload = 32'h00109263; //bne x1, x1, loop// it shouldn't branch
    #(PERIOD); 

    test_case = "bne x1, x2, loop";
    cuif.zero = 0;
    cuif.imemload = 32'h00109263; //bne x1, x2, loop, it should branch
    #(PERIOD); 


    test_case = "blt x1, x2, loop";
    cuif.presult = 1;
    cuif.imemload = 32'h0020c263; //blt x1, x2, loop, it should branch
    #(PERIOD); 

    test_case = "bge x1, x2, loop";
    cuif.presult = 1;
    cuif.imemload = 32'h0020d263; //bge x1, x2, loop, it should branch
    #(PERIOD); 


    $finish;

  end

endprogram

