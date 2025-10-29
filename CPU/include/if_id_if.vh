/*
  Fatma Alagroudy
  falagrou@purdue.edu

  if_id interface
*/
`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface if_id_if;
  // import types
  import cpu_types_pkg::*;

  word_t imemaddr_if, imemload_if;
  word_t imemaddr_id, imemload_id;
  logic  ihit,flush, enable, pipeline_control;
  // register file ports
  modport ifid (
    input   imemaddr_if, imemload_if, ihit, flush, enable, pipeline_control,
    output  imemaddr_id, imemload_id
  );
  // register file tb
  modport tb (
    output   imemaddr_if, imemload_if,
    input  imemaddr_id, imemload_id, ihit,flush
  );
endinterface

`endif //IF_ID_IF_VH
