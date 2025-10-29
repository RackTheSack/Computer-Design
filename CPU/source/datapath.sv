
// data path interface
`include "datapath_cache_if.vh"
`include "control_unit_if.vh"
`include "imm_gen_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"

`include "if_id_if.vh"
`include "id_exe_if.vh"
`include "exe_mem_if.vh"
`include "mem_wb_if.vh"
`include "caches_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
  // import types
  import cpu_types_pkg::*;



  //functional blocks interfaces
  imm_gen_if igif ();
  control_unit_if cuif();
  alu_if aluif ();
  register_file_if rfif ();

  //lab 7 stuff
  forwarding_unit_if fuif ();
  hazard_unit_if huif ();

  //pipeline latches interfaces
  if_id_if ifid_if ();
  id_exe_if idexe_if ();
  exe_mem_if exemem_if ();
  mem_wb_if memwb_if ();
  
  //instantiations
  imm_gen generator (igif);
  control_unit control (cuif);
  alu alu (aluif);
  register_file reg_file (CLK, nRST, rfif);
  forwarding_unit forward (fuif);
  hazard_unit hazard (huif);

  if_id latch1 (CLK, nRST, ifid_if);
  id_exe latch2 (CLK, nRST, idexe_if);
  exe_mem latch3 (CLK, nRST, exemem_if);
  mem_wb latch4 (CLK, nRST, memwb_if);

    // pc init
  parameter PC_INIT = 0;  

  logic halt, nxt_halt;


    logic pipeline_control;

  always_comb begin 
    if (exemem_if.dmemr_mem || exemem_if.dmemw_mem) begin 
      pipeline_control = dpif.ihit && dpif.dhit;
    end
    else begin 
      pipeline_control = dpif.ihit;
    end
  end

  word_t pc, nxt_pc; 

  word_t pb, wdat_mem, wdat_wb;


  word_t dmemload_save;

  always_ff @(posedge CLK or negedge nRST) begin
    if(!nRST) begin 
      dmemload_save <= '0;
    end
    else if (dpif.dhit) begin 
      dmemload_save <= dpif.dmemload;
    end
  end

  always_ff @(posedge CLK or negedge nRST) begin

    if(!nRST) begin
      pc <= 0;
    end
    else if(pipeline_control) begin  
        pc <= nxt_pc;
    end
  end

  logic PCsrc;

  always_comb begin 
  PCsrc = 0;

    if(exemem_if.branch_mem) begin
        casez (exemem_if.imemload_mem[14:12])
        
        BEQ: begin 
            if(exemem_if.zero_mem) begin 
                PCsrc = 1;
            end
        end

        BNE: begin 
            if(!exemem_if.zero_mem) begin 
                PCsrc = 1;
            end
        end

        BGE: begin 
            if(exemem_if.presult_mem == 0) begin 
                PCsrc = 1;
            end
        end

        BGEU: begin 
            if(exemem_if.presult_mem == 0) begin 
                PCsrc = 1;
            end
        end

        BLT: begin 
            if(exemem_if.presult_mem != 0) begin 
                PCsrc = 1;
            end
        end

        BLTU: begin 
            if(exemem_if.presult_mem != 0) begin 
                PCsrc = 1;
            end
        end
        endcase
    end
  end


 //REMEMBER TO EDIT THIS
 
    always_comb begin 

      nxt_pc = pc;
      if (huif.PC_write) begin 
        nxt_pc = pc + 4;

        if(PCsrc|| exemem_if.jal_mem) begin 
          nxt_pc = exemem_if.imemaddr_mem + exemem_if.imm_mem;
        end

        if(exemem_if.jalr_mem) begin 
          nxt_pc = exemem_if.presult_mem;
        end
      end
    end

    assign cuif.imemload = ifid_if.imemload_id;
    //assign cuif.presult = aluif.presult;
    //assign cuif.zero = aluif.zero;

    assign igif.inst = ifid_if.imemload_id;

    //assign ruif.dhit =  dpif.dhit;
    //assign ruif.nRST = nRST;
    //assign ruif.dmemr = cuif.dmemr && dpif.ihit;
    //assign ruif.dmemw = cuif.dmemw && dpif.ihit;

    assign aluif.alu_op = idexe_if.alu_op_exe;
    //assign aluif.pa = idexe_if.rdat1_exe;
    always_comb begin  // port a output based on forward unit
      aluif.pa = idexe_if.rdat1_exe;
      casez(fuif.forward_a)
        2'b00: begin
          aluif.pa = idexe_if.rdat1_exe;
        end
        2'b?1: begin
          aluif.pa = wdat_mem;
        end
        2'b10: begin
          aluif.pa = wdat_wb;
        end
      endcase
    end

    always_comb begin  // port b output based on forward unit
      aluif.pb = idexe_if.rdat2_exe;
      if (idexe_if.ALUsrc_exe) aluif.pb = idexe_if.imm_exe;
      else begin
        casez(fuif.forward_b)
          2'b00: begin
            aluif.pb = idexe_if.rdat2_exe;
          end
          2'b?1: begin
            aluif.pb = wdat_mem;
          end
          2'b10: begin
            aluif.pb = wdat_wb;
          end
        endcase
      end
      
    end
    //assign aluif.pb = pb;

    assign rfif.WEN = memwb_if.WEN_wb; //&& (dpif.ihit || dpif.dhit);
    assign rfif.wsel = memwb_if.imemload_wb[11:7];

    //these two dont work
    //assign rfif.rsel1 = (dpif.dhit && (dd_hit == 0)) ? idexe_if.imemload_exe[19:15] : ifid_if.imemload_id[19:15];
    //assign rfif.rsel2 = (dpif.dhit && (dd_hit == 0))  ? idexe_if.imemload_exe[24:20] : ifid_if.imemload_id[24:20];

    //these are the original 2 (gets stuck at fib)
    //assign rfif.rsel1 = dpif.dhit ? idexe_if.imemload_exe[19:15] : ifid_if.imemload_id[19:15];
    //assign rfif.rsel2 = dpif.dhit ? idexe_if.imemload_exe[24:20] : ifid_if.imemload_id[24:20];
    
    //these two lines work for everything but count days
    assign rfif.rsel1 = ifid_if.imemload_id[19:15];
    assign rfif.rsel2 = ifid_if.imemload_id[24:20];


    assign rfif.wdat = wdat_wb;

    //assign pb = (idexe_if.ALUsrc_exe)? idexe_if.imm_exe : idexe_if.rdat2_exe;


    


  always_ff @(posedge CLK, negedge nRST) begin 
    if(!nRST)begin 
      dpif.halt <= 0;
    end  

    else begin 
      dpif.halt <= dpif.halt || exemem_if.halt_mem;
      //dpif.halt <= dpif.halt || dcif.flushed;
      //dpif.halt <= exemem_if.halt_mem || dcif.flushed;
    end
  end


    assign dpif.imemREN = 1'b1;
    assign dpif.dmemREN = exemem_if.dmemr_mem;
    assign dpif.dmemWEN = exemem_if.dmemw_mem;
    //ASK ABOUT THIS
    assign dpif.imemaddr = pc;
    assign dpif.dmemstore = exemem_if.dmemstore;
    assign dpif.dmemaddr = exemem_if.presult_mem;


    always_comb begin 
      wdat_mem = exemem_if.presult_mem;
      
      if(exemem_if.auipc_mem)begin
        wdat_mem = exemem_if.imemaddr_mem + exemem_if.imm_mem;
      end
      else if(exemem_if.lui_mem)begin 
        wdat_mem = exemem_if.imm_mem;
      end
      else if(exemem_if.jal_mem || exemem_if.jalr_mem)begin 
        wdat_mem = exemem_if.imemaddr_mem + 4;
      end
     
    end

    always_comb begin
      wdat_wb = memwb_if.wdat_mem_ff;
       if(memwb_if.memtoreg_wb) begin 
        wdat_wb = memwb_if.dmemload_wb;
      end
    end





  // logic flush;
  // assign flush = PCsrc|| exemem_if.jal_mem || exemem_if.jalr_mem;
  
  // ifid latch
  assign ifid_if.imemload_if = dpif.imemload;
  assign ifid_if.imemaddr_if = pc;
  assign ifid_if.ihit = dpif.ihit;
  assign ifid_if.flush = huif.flush;
  assign ifid_if.enable = huif.IFID_write;
  assign ifid_if.pipeline_control = pipeline_control;

  // idexe latch
  assign idexe_if.imemload_id = ifid_if.imemload_id; // output of prev latch connected to input of curr latch
  assign idexe_if.imemaddr_id = ifid_if.imemaddr_id;
  assign idexe_if.halt_id = cuif.halt;
  assign idexe_if.ALUsrc_id = cuif.ALUsrc;
  assign idexe_if.jal_id = cuif.jal;
  assign idexe_if.jalr_id = cuif.jalr;
  assign idexe_if.auipc_id = cuif.auipc;
  assign idexe_if.lui_id = cuif.lui;
  assign idexe_if.dmemr_id = cuif.dmemr;
  assign idexe_if.dmemw_id = cuif.dmemw;
  assign idexe_if.WEN_id = cuif.WEN;
  assign idexe_if.memtoreg_id = cuif.memtoreg;
  assign idexe_if.alu_op_id = cuif.alu_op;
  assign idexe_if.rdat1_id = rfif.rdat1;
  assign idexe_if.rdat2_id = rfif.rdat2;
  assign idexe_if.imm_id = igif.imm;
  assign idexe_if.ihit = dpif.ihit;
  assign idexe_if.branch_id = cuif.branch;
  assign idexe_if.flush = huif.flush;
  assign idexe_if.hazard_detected = huif.hazard_detected;
  assign idexe_if.dhit = dpif.dhit;
  assign idexe_if.pipeline_control = pipeline_control;


  
 

  

  //exmem latch
  assign exemem_if.imemload_exe = idexe_if.imemload_exe; // output of prev latch connected to input of curr latch
  assign exemem_if.imemaddr_exe = idexe_if.imemaddr_exe;
  assign exemem_if.halt_exe = idexe_if.halt_exe;
  //assign exmem_if.ALUsrc_id = cuif.ALUsrc; // connect where - alusrc output from idexe - idexe_if.ALUsrc_exe
  assign exemem_if.jal_exe = idexe_if.jal_exe;
  assign exemem_if.jalr_exe = idexe_if.jalr_exe;
  assign exemem_if.auipc_exe = idexe_if.auipc_exe;
  assign exemem_if.lui_exe = idexe_if.lui_exe;
  assign exemem_if.dmemr_exe = idexe_if.dmemr_exe;
  assign exemem_if.dmemw_exe = idexe_if.dmemw_exe;
  assign exemem_if.WEN_exe = idexe_if.WEN_exe;
  assign exemem_if.memtoreg_exe = idexe_if.memtoreg_exe;
  //assign exmem_if.rdat1_id = rfif.rdat1; do need rdat1
  // assign exemem_if.rdat2_exe = idexe_if.rdat2_exe;
  always_comb begin  // port b output based on forward unit
    exemem_if.rdat2_exe = idexe_if.rdat2_exe;
      casez(fuif.forward_b)
        2'b00: begin
          exemem_if.rdat2_exe = idexe_if.rdat2_exe;
        end
        2'b?1: begin
          exemem_if.rdat2_exe = wdat_mem;
        end
        2'b10: begin
          exemem_if.rdat2_exe = wdat_wb;
        end
      endcase
    end
  assign exemem_if.imm_exe = idexe_if.imm_exe;
  //assign exmem_if.branch_addr_exe = ; igif.imm or idexe_if.imm_exe
  assign exemem_if.presult_exe = aluif.presult; 
  assign exemem_if.zero_exe = aluif.zero; 
  assign exemem_if.ihit = dpif.ihit;
  assign exemem_if.branch_exe = idexe_if.branch_exe;
  assign exemem_if.dhit = dpif.dhit;
  assign exemem_if.flush = huif.flush;
  assign exemem_if.pipeline_control = pipeline_control;

  // memwb latch
  assign memwb_if.imemload_mem = exemem_if.imemload_mem; // output of prev latch connected to input of curr latch
  assign memwb_if.imemaddr_mem = exemem_if.imemaddr_mem;
  assign memwb_if.jal_mem = exemem_if.jal_mem;
  assign memwb_if.jalr_mem = exemem_if.jalr_mem;
  assign memwb_if.auipc_mem = exemem_if.auipc_mem;
  assign memwb_if.lui_mem = exemem_if.lui_mem;
  assign memwb_if.WEN_mem = exemem_if.WEN_mem;
  assign memwb_if.memtoreg_mem = exemem_if.memtoreg_mem;

  always_comb begin
    if (dpif.ihit && dpif.dhit) begin 
      memwb_if.dmemload_mem = dpif.dmemload;
    end
    else begin 
      memwb_if.dmemload_mem = dmemload_save;
    end
  end
  //assign memwb_if.dmemload_mem = dpif.dmemload;
  assign memwb_if.imm_mem = exemem_if.imm_mem;
  assign memwb_if.presult_mem = exemem_if.presult_mem;
  assign memwb_if.ihit = dpif.ihit;
  assign memwb_if.dhit = dpif.dhit;
  assign memwb_if.wdat_mem = wdat_mem;
  assign memwb_if.pipeline_control = pipeline_control;


  //hazard unit connection
  assign huif.PCsrc = PCsrc;
  assign huif.jal_mem = exemem_if.jal_mem;
  assign huif.jalr_mem = exemem_if.jalr_mem;
  assign huif.dmemr_exe = idexe_if.dmemr_exe;
  assign huif.imemload_exe = idexe_if.imemload_exe;
  assign huif.imemload_id = ifid_if.imemload_id;

  //  forward unit
  assign fuif.imemload_exe = idexe_if.imemload_exe;
  assign fuif.imemload_mem = exemem_if.imemload_mem;
  assign fuif.imemload_wb = memwb_if.imemload_wb;
  assign fuif.WEN_mem = exemem_if.WEN_mem;
  assign fuif.WEN_wb = memwb_if.WEN_wb ;
  
  

endmodule

