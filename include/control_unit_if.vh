/*
  Fatma Alagroudy
  falagrou@purdue.edu

  control unit
*/
`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  logic zero, halt, ALUsrc, jal, jalr, auipc, branch, lui;
  //aluop_t  [3:0] alu_op;
  logic dmemr, dmemw;
  aluop_t alu_op;
  word_t imemload, presult;
  logic WEN, memtoreg;

  // register file ports
  modport cu (
    input   imemload,
    output  halt, ALUsrc, jal, jalr, auipc, alu_op,
    branch, dmemr, dmemw, lui, WEN, memtoreg
  );
  // register file tb
  modport tb (
    output   imemload, presult, zero,
    input  halt, ALUsrc, jal, jalr, auipc, alu_op,
    branch, dmemr, dmemw, lui, WEN, memtoreg
  );

endinterface

`endif //ALU_IF_VH
