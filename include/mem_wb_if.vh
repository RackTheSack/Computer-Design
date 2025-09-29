/*
  Fatma Alagroudy
  falagrou@purdue.edu

  mem_wb interface
*/
`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface mem_wb_if;
  // import types
  import cpu_types_pkg::*;

  logic  jal_mem, jal_wb,
  jalr_mem, jalr_wb, 
  auipc_mem, auipc_wb, 
  lui_mem, lui_wb,
  WEN_mem, WEN_wb,
  memtoreg_mem, memtoreg_wb,
  ihit,dhit, pipeline_control;

  word_t presult_mem, presult_wb,
  dmemload_mem, dmemload_wb,
  
  imm_mem, imm_wb,

  imemaddr_mem, imemaddr_wb,
  imemload_mem, imemload_wb,
  
  wdat_mem, wdat_mem_ff;

  modport memwb (
    input   jal_mem, jalr_mem, auipc_mem, lui_mem, WEN_mem, memtoreg_mem,
    presult_mem, dmemload_mem, imm_mem, imemaddr_mem, imemload_mem,ihit,dhit, wdat_mem, pipeline_control,


    output  jal_wb, jalr_wb, auipc_wb, lui_wb, WEN_wb, memtoreg_wb,
    presult_wb, dmemload_wb, imemaddr_wb, imemload_wb, imm_wb, wdat_mem_ff
  );
  // register file tb
  modport tb (
    output   jal_mem, jalr_mem, auipc_mem, lui_mem, WEN_mem, memtoreg_mem,
    presult_mem, dmemload_mem, imm_mem, imemaddr_mem, imemload_mem,ihit,


    input  jal_wb, jalr_wb, auipc_wb, lui_wb, WEN_wb, memtoreg_wb,
    presult_wb, dmemload_wb
  );


 

endinterface

`endif //MEM_WB_IF_VH
