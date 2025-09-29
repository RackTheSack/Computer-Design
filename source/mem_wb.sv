`include "cpu_types_pkg.vh"
`include "mem_wb_if.vh"

module mem_wb
(
	input logic CLK, nRST,
	mem_wb_if.memwb memwb
);

import cpu_types_pkg::*;
    always_ff @(posedge CLK, negedge nRST) begin
        if (!nRST) begin
		memwb.imemaddr_wb <= 0;
		memwb.imemload_wb <= 0;
		memwb.jal_wb <= 0;
		memwb.jalr_wb <= 0;
		memwb.auipc_wb <= 0;
		memwb.lui_wb <= 0;
		memwb.WEN_wb <= 0;
		memwb.memtoreg_wb <= 0;
		memwb.dmemload_wb <= 0;
		memwb.imm_wb <= 0;
        memwb.presult_wb <= 0;
		memwb.wdat_mem_ff <= 0;
    end
    //else if (memwb.ihit || memwb.dhit)begin
	else if (memwb.pipeline_control)begin
        memwb.imemaddr_wb <= memwb.imemaddr_mem;
		memwb.imemload_wb <= memwb.imemload_mem;
		memwb.jal_wb <= memwb.jal_mem;
		memwb.jalr_wb <= memwb.jalr_mem;
		memwb.auipc_wb <= memwb.auipc_mem;
		memwb.lui_wb <= memwb.lui_mem;
		memwb.WEN_wb <= memwb.WEN_mem;
		memwb.memtoreg_wb <= memwb.memtoreg_mem;
		memwb.dmemload_wb <= memwb.dmemload_mem;
		memwb.imm_wb <= memwb.imm_mem;
        memwb.presult_wb <= memwb.presult_mem;
		memwb.wdat_mem_ff <= memwb.wdat_mem;
    end
	
    end
    endmodule