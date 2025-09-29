`include "forwarding_unit_if.vh"

`include "cpu_types_pkg.vh"


module forwarding_unit (
    forwarding_unit_if.fu fuif
);
    // import types
  import cpu_types_pkg::*;

// rd 11:7
// rs1 19:15
//rs2 24:20
// always_comb begin 
//     if((fuif.imemload_mem[11:7] == fuif.imemload_exe[19:15]) || (fuif.imemload_mem[11:7] == fuif.imemload_exe[24:20])) begin // rs1 rs2 - mem stage
//         forward_a = 
//     end
// end

// always_comb begin 
//     if((fuif.imemload_wb[11:7] == fuif.imemload_exe[19:15]) || (fuif.imemload_wb[11:7] == fuif.imemload_exe[24:20])) begin // rs1 rs2 - wb stage
//         forward_a = 
//     end
// end

// forward: 00 - rs1, 01 - output from mem, 10 - output from wb


// always_comb begin 
//     fuif.forward_2 = 1'b0;
//     if(fuif.imemload_exe[6:0] != ITYPE && fuif.imemload_exe[6:0] != ITYPE_LW
//     && fuif.imemload_exe[6:0] != JALR && fuif.imemload_exe[6:0] != LUI && fuif.imemload_exe[6:0] != AUIPC && fuif.imemload_exe[6:0] != JAL && fuif.imemload_exe[6:0] != STYPE) begin 
//         fuif.forward_2 = 1'b1;
//     end
// end

// always_comb begin 
//     fuif.forward_1 = 1'b0;
//     if( fuif.imemload_exe[6:0] != LUI && fuif.imemload_exe[6:0] != AUIPC && fuif.imemload_exe[6:0] != JAL) begin 
//         fuif.forward_1 = 1'b1;
//     end
// end


// always_comb begin // rsel1
// fuif.forward_a = 2'b00;
//     if(fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_mem) begin // rs1  - mem stage
//         fuif.forward_a = 2'b01; // output from mem,
//     end
//     else if (fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_wb)begin //rs1  - wb stage
//         fuif.forward_a = 2'b10; // output from wb
//     end
//     // else begin
//     //     fuif.forward_a = 2'b00; // normal rsel1
//     // end
//     fuif.forward_a[0]
// end

assign fuif.forward_a[0] = fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_mem;
assign fuif.forward_a[1] = fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[19:15]) && fuif.WEN_wb;

assign fuif.forward_b[0] = fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_mem;
assign fuif.forward_b[1] = fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_wb;

// always_comb begin // rsel2
// fuif.forward_b = 2'b00;
//     if(fuif.imemload_mem[11:7] && (fuif.imemload_mem[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_mem ) begin // rs2  - mem stage
//         fuif.forward_b = 2'b01; // output from mem,
//     end
//     else if (fuif.imemload_wb[11:7] && (fuif.imemload_wb[11:7] == fuif.imemload_exe[24:20]) && fuif.WEN_wb)begin // rs2  - wb stage
//         fuif.forward_b = 2'b10; // output from wb
//     end
//     // else begin
//     //     fuif.forward_b = 2'b00; // normal rsel2
//     // end
// end

endmodule