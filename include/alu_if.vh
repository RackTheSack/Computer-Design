/*
  Fatma Alagroudy
  falagrou@purdue.edu

  alu interface
*/
`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic [3:0] alu_op;
  logic neg, ovf, zero;
  word_t    pa, pb, presult;

  // register file ports
  modport alu (
    input   alu_op, pa, pb,
    output  neg, ovf, zero, presult
  );
  // register file tb
  modport tb (
    output   alu_op, pa, pb,
    input  neg, ovf, zero, presult
  );
endinterface

`endif //ALU_IF_VH
