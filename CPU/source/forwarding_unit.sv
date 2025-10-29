`include "forwarding_unit_if.vh"

`include "cpu_types_pkg.vh"


module forwarding_unit (
    forwarding_unit_if.fu fuif
);
    // import types
  import cpu_types_pkg::*;

assign fuif.forward_a[0] = fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_mem;
assign fuif.forward_a[1] = fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_wb;

assign fuif.forward_b[0] = fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_mem;
assign fuif.forward_b[1] = fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_wb;

endmodule
