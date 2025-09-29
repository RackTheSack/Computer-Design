/*
  Fatma Alagroudy
  falagrou@purdue.edu

  imm generator interface
*/
`ifndef IMM_GEN_IF_VH
`define IMM_GEN_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface imm_gen_if;
  // import types
  import cpu_types_pkg::*;

    word_t inst, imm;

  // imm generator ports
  modport ig (
    input   inst,
    output  imm
  );
  // register file tb
  modport tb (
    input imm,
    output inst
  );

endinterface

`endif //imm_gen_if_vh
