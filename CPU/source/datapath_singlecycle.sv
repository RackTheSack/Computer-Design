/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "request_unit_if.vh"
`include "imm_gen_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;


  word_t pc, nxt_pc; 

  word_t pb, wdat;

  imm_gen_if igif ();
  control_unit_if cuif();
  request_unit_if ruif();
  alu_if aluif ();
  register_file_if rfif ();

  imm_gen generator (igif);
  control_unit control (cuif);
  request_unit request (CLK, ruif);
  alu alu (aluif);
  register_file reg_file (CLK, nRST, rfif);


  always_ff @(posedge CLK or negedge nRST) begin

    if(!nRST) begin
      pc <= 0;
    end
    else if(dpif.ihit) begin 
      pc <= nxt_pc;
    end
  end

  always_comb begin 
    nxt_pc = pc + 4;

    if(cuif.PCsrc) begin 
      nxt_pc = pc + igif.imm;
    end

    if(cuif.jalr) begin 
      nxt_pc = aluif.presult;
    end

  end

  always_comb begin

   end

    assign cuif.imemload = dpif.imemload;
    assign cuif.presult = aluif.presult;
    assign cuif.zero = aluif.zero;

    assign igif.inst = dpif.imemload;

    assign ruif.dhit =  dpif.dhit;
    assign ruif.nRST = nRST;
    assign ruif.dmemr = cuif.dmemr && dpif.ihit;
    assign ruif.dmemw = cuif.dmemw && dpif.ihit;

    assign aluif.alu_op = cuif.alu_op;
    assign aluif.pa = rfif.rdat1;
    assign aluif.pb = pb;

    assign rfif.WEN = cuif.WEN && (dpif.ihit || dpif.dhit);
    assign rfif.wsel = dpif.imemload[11:7];
    assign rfif.rsel1 = dpif.imemload[19:15];
    assign rfif.rsel2 = dpif.imemload[24:20];
    assign rfif.wdat = wdat;

    assign pb = (cuif.ALUsrc)? igif.imm : rfif.rdat2;

  logic halt, nxt_halt;

  always_ff @(posedge CLK, negedge nRST) begin 
    if(!nRST)begin 
        halt <= 0;
    end  

    else begin 
      halt <= nxt_halt;
    end
  end

  always_comb begin 
    nxt_halt = halt;
    if(cuif.halt)begin 
      nxt_halt = 1;
    end
  end 

    assign dpif.halt = halt;
    assign dpif.imemREN = ruif.imemREN;
    assign dpif.dmemREN = ruif.dmemREN;
    assign dpif.dmemWEN = ruif.dmemWEN;
    //ASK ABOUT THIS
    assign dpif.imemaddr = pc;
    assign dpif.dmemstore = rfif.rdat2;
    assign dpif.dmemaddr = aluif.presult;


    always_comb begin 
      wdat = aluif.presult;
      if(cuif.memtoreg) begin 
        wdat = dpif.dmemload;
      end
      else if(cuif.auipc)begin
        wdat = pc + igif.imm;
      end
      else if(cuif.lui)begin 
        wdat = igif.imm;
      end
      else if(cuif.jal)begin 
        wdat = pc + 4;
      end
    end

  // pc init
  parameter PC_INIT = 0;  

endmodule
