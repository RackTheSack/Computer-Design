/*
  Fatma Alagroudy
  falagrou@purdue.edu

  id_exe interface
*/
`ifndef ID_EXE_IF_VH
`define ID_EXE_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface id_exe_if;
  // import types
  import cpu_types_pkg::*;

  //imemload is the instruction
  //imemaddr is the PC
  word_t imemaddr_id, imemaddr_exe, imemload_id, imemload_exe;


  //contol signals 
  logic
  branch_id, branch_exe,
  halt_id, halt_exe,
  ALUsrc_id, ALUsrc_exe, 
  jal_id, jal_exe,
  jalr_id, jalr_exe, 
  auipc_id, auipc_exe, 
  lui_id, lui_exe,
  dmemr_id, dmemr_exe, 
  dmemw_id, dmemw_exe,
  WEN_id, WEN_exe, 
  memtoreg_id, memtoreg_exe,
  ihit, dhit, flush, hazard_detected, pipeline_control;

  aluop_t alu_op_id, alu_op_exe;

  //register reads
  word_t rdat1_id, rdat1_exe,
  rdat2_id, rdat2_exe;

  //output of immediate generator
  word_t imm_id, imm_exe;

  // register file ports

  modport idexe (
    input   dhit, imemaddr_id, imemload_id,
    halt_id, ALUsrc_id, jal_id,
    jalr_id, auipc_id, lui_id, dmemr_id, dmemw_id,
    WEN_id, memtoreg_id, alu_op_id, 
    rdat1_id, rdat2_id, imm_id, ihit,flush, branch_id, hazard_detected, pipeline_control,


    output  imemaddr_exe, imemload_exe,
    halt_exe, ALUsrc_exe, jal_exe,
    jalr_exe, auipc_exe, lui_exe, dmemr_exe, dmemw_exe,
    WEN_exe, memtoreg_exe, alu_op_exe, 
    rdat1_exe, rdat2_exe, imm_exe, branch_exe
  );
  // register file tb
  modport tb (
    output   dhit, imemaddr_id, imemload_id,
    halt_id, ALUsrc_id, jal_id,
    jalr_id, auipc_id, lui_id, dmemr_id, dmemw_id,
    WEN_id, memtoreg_id, alu_op_id, 
    rdat1_id, rdat2_id, imm_id, 


    input  imemaddr_exe, imemload_exe,
    halt_exe, ALUsrc_exe, jal_exe,
    jalr_exe, auipc_exe, lui_exe, dmemr_exe, dmemw_exe,
    WEN_exe, memtoreg_exe, alu_op_exe, 
    rdat1_exe, rdat2_exe, imm_exe,ihit,flush
  );
endinterface

`endif //ID_EXE_IF_VH
