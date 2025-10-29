`ifndef FORWARDING_UNIT_IF_VH
`define FORWARDING_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface forwarding_unit_if;
  // import types
  import cpu_types_pkg::*;


  word_t imemload_exe, imemload_mem, imemload_wb;

  logic [1:0]forward_a, forward_b;
  logic WEN_mem, WEN_wb;
  // logic forward_1, forward_2;

  //register reads
  modport fu (
    input   imemload_exe, imemload_mem, imemload_wb, WEN_wb, WEN_mem,

    output forward_a, forward_b
  );
  // register file tb
  modport tb (
    output   imemload_exe, imemload_mem, imemload_wb, 

    input forward_a, forward_b
  );
endinterface

`endif //HAZARD_UNIT_IF_VH
