`include "hazard_unit_if.vh"

`include "cpu_types_pkg.vh"


module hazard_unit (
    hazard_unit_if.hu huif
);
    // import types
  import cpu_types_pkg::*;

  always_comb begin 
    huif.flush = 0; 
    huif.hazard_detected = 0;
    if(huif.PCsrc || huif.jalr_mem || huif.jal_mem) begin 
        huif.flush = 1;
    end else if((huif.imemload_exe[11:7] != 0) && huif.dmemr_exe && ((huif.imemload_id[19:15] == huif.imemload_exe[11:7])
     || (huif.imemload_id[24:20] == huif.imemload_exe[11:7]))) begin 
        huif.hazard_detected = 1;
     end
  end

  assign huif.PC_write = ~huif.hazard_detected;
  assign huif.IFID_write = ~huif.hazard_detected;


endmodule