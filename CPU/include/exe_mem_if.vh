/*
  Fatma Alagroudy
  falagrou@purdue.edu

  exe_mem interface
*/
`ifndef EXE_MEM_IF_VH
`define EXE_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface exe_mem_if;
  // import types
  import cpu_types_pkg::*;

  //imemload is PC
  word_t imemaddr_mem, imemaddr_exe, imemload_mem, imemload_exe;


  //contol signals 
  logic
  branch_exe, branch_mem,
  halt_mem, halt_exe,
  jal_mem, jal_exe,
  jalr_mem, jalr_exe, 
  auipc_mem, auipc_exe, 
  lui_mem, lui_exe,
  dmemr_mem, dmemr_exe, 
  dmemw_mem, dmemw_exe,
  WEN_mem, WEN_exe, 
  memtoreg_mem, memtoreg_exe,
  ihit, dhit, flush, pipeline_control;

  //register reads
  word_t rdat2_exe, dmemstore; //dmemstore is just rdat2 after registering

  //output of immediate generator
  word_t imm_exe, imm_mem;

  //alu outputs
  word_t presult_exe, presult_mem;
  logic zero_exe, zero_mem;

  modport exemem (
    input   halt_exe, jalr_exe,
    imemload_exe, imemaddr_exe, jal_exe, auipc_exe, lui_exe, dmemr_exe, dmemw_exe,
    WEN_exe, memtoreg_exe, 
    rdat2_exe, imm_exe, presult_exe, zero_exe,ihit, flush, branch_exe,dhit, pipeline_control,


    output  imemaddr_mem, imemload_mem,
    halt_mem, jal_mem,
    jalr_mem, auipc_mem, lui_mem, dmemr_mem, dmemw_mem,
    WEN_mem, memtoreg_mem,
    dmemstore, imm_mem, presult_mem, zero_mem, branch_mem
  );
  // register file tb
  modport tb (
    output   halt_exe, jalr_exe,
    imemload_exe, imemaddr_exe, jal_exe, auipc_exe, lui_exe, dmemr_exe, dmemw_exe,
    WEN_exe, memtoreg_exe, 
    rdat2_exe, imm_exe, presult_exe, zero_exe,ihit, flush,


    input  imemaddr_mem, imemload_mem,
    halt_mem, jal_mem,
    jalr_mem, auipc_mem, lui_mem, dmemr_mem, dmemw_mem,
    WEN_mem, memtoreg_mem,
    dmemstore, imm_mem, presult_mem, zero_mem
  );
endinterface

`endif //EXE_MEM_IF_VH
