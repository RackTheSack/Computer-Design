/*
  hazard_unit interface
*/
`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  // import types
  import cpu_types_pkg::*;


  logic PCsrc, jal_mem, jalr_mem, flush;

  logic dmemr_exe;

  word_t imemload_exe, imemload_id;

  logic hazard_detected, IFID_write, PC_write;


  //register reads
  modport hu (
    input   PCsrc, jal_mem, jalr_mem, dmemr_exe,
     imemload_exe, imemload_id,

    output flush, hazard_detected, IFID_write, PC_write
  );
  // register file tb
  modport tb (
    output   PCsrc, jal_mem, jalr_mem, dmemr_exe,
     imemload_exe, imemload_id,

    input flush, hazard_detected, IFID_write, PC_write
  );
endinterface

`endif //HAZARD_UNIT_IF_VH
