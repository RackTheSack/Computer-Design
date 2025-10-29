/*
  Fatma Alagroudy
  fatma.alagroudy@gmail.com

    request unit test bench
*/

// mapped needs this
`include "request_unit_if.vh"
// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;



// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

    logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;


  request_unit_if ruif ();

  // test program
  test #(.PERIOD (PERIOD)) PROG(CLK, ruif);
  // DUT
`ifndef MAPPED
   request_unit DUT (CLK, ruif);
`else
   DUT(
    .\ruif.ihit (ruif.ihit),
    .\ruif.dhit (ruif.dhit),
    .\ruif.nRST (ruif.nRST),
    .\ruif.dmemr (ruif.dmemr),
    .\ruif.dmemw (ruif.dmemw),
    .\ruif.dmemWEN (ruif.dmemWEN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.imemREN (ruif.imemREN)
  );
`endif

endmodule

program test(input logic CLK, request_unit_if.tb ruif);

parameter PERIOD = 10;

task reset_dut;
begin
  ruif.nRST = 0;
  @(posedge CLK);
  @(posedge CLK);
  @(negedge CLK);

  ruif.nRST = 1;
  @(posedge CLK);
  @(posedge CLK);

end
endtask 

initial begin

    ruif.dhit = 0;
    ruif.dmemr = 0;
    ruif.dmemw = 0;
    reset_dut;

    @(negedge CLK);

    ruif.dmemr = 1;
    @(negedge CLK);
    ruif.dmemr = 0;
    @(negedge CLK);
    ruif.dhit = 1;
    @(negedge CLK);
    @(negedge CLK);

    ruif.dhit = 0;
    ruif.dmemw = 1;
    @(negedge CLK);
    ruif.dmemr = 0;
    @(negedge CLK);
    ruif.dhit = 1;
    @(negedge CLK);
    @(negedge CLK);

    ruif.dhit = 0;
    @(negedge CLK);


    $finish;

  end

endprogram
