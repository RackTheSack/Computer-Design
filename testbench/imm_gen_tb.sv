/*
  Fatma Alagroudy
  fatma.alagroudy@gmail.com

    immediate generator test bench
*/

// mapped needs this
`include "imm_gen_if.vh"
// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;



// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module imm_gen_tb;

  parameter PERIOD = 10;

    logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;


  imm_gen_if igif ();

  // test program
  test #(.PERIOD (PERIOD)) PROG(igif);
  // DUT
`ifndef MAPPED
   imm_gen DUT (igif);
`else
   DUT(
    .\igif.inst (igif.inst),
    .\igif.inst (igif.inst)
  );
`endif

endmodule

program test(imm_gen_if.tb igif);

parameter PERIOD = 10;

initial begin



    $finish;

  end

endprogram
