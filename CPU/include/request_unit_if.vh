/*
  Fatma Alagroudy
  falagrou@purdue.edu

  request unit interface
*/
`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic dhit, nRST;
  logic dmemr, dmemw, dmemWEN, dmemREN, imemREN;

  // register file ports
  modport ru (
    input   dmemr, dmemw, dhit, nRST,
    output  dmemWEN, dmemREN, imemREN
  );
  // register file tb
  modport tb (
    output   dmemr, dmemw, dhit, nRST,
    input  dmemWEN, dmemREN, imemREN
  );

endinterface

`endif //REQUEST_UNIT_IF
