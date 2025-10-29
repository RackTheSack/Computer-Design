`include "cpu_types_pkg.vh"
`include "exe_mem_if.vh"

module exe_mem
(
	input logic CLK, nRST,
	exe_mem_if.exemem exmem
);


import cpu_types_pkg::*;
    always_ff @(posedge CLK, negedge nRST) begin
	if (!nRST) begin
		exmem.imemaddr_mem <= 0;
		exmem.imemload_mem <= 0;
		exmem.halt_mem <= 0;
		exmem.jal_mem <= 0;
		exmem.jalr_mem <= 0;
		exmem.auipc_mem <= 0;
		exmem.lui_mem <= 0;
		exmem.dmemr_mem <= 0;
		exmem.dmemw_mem <= 0;
		exmem.WEN_mem <= 0;
		exmem.memtoreg_mem <= 0;
		exmem.dmemstore <= 0;
		exmem.imm_mem <= 0;
        exmem.presult_mem <= 0;
        exmem.zero_mem <= 0;
		exmem.branch_mem <= 0;

    end
	//else if (exmem.ihit && exmem.flush)begin
	else if (exmem.pipeline_control && exmem.flush)begin
        exmem.imemaddr_mem <= 0;
		exmem.imemload_mem <= 0;
		exmem.halt_mem <= 0;
		exmem.jal_mem <= 0;
		exmem.jalr_mem <= 0;
		exmem.auipc_mem <= 0;
		exmem.lui_mem <= 0;
		exmem.dmemr_mem <= 0;
		exmem.dmemw_mem <= 0;
		exmem.WEN_mem <= 0;
		exmem.memtoreg_mem <= 0;
		exmem.dmemstore <= 0;
		exmem.imm_mem <= 0;
        exmem.presult_mem <= 0;
        exmem.zero_mem <= 0;
		exmem.branch_mem <= 0;
    end
	else if (exmem.dhit && !exmem.ihit)begin
        // exmem.imemaddr_mem <= 0;
		// exmem.imemload_mem <= 0;
		// exmem.halt_mem <= 0;
		// exmem.jal_mem <= 0;
		// exmem.jalr_mem <= 0;
		// exmem.auipc_mem <= 0;
		// exmem.lui_mem <= 0;
		exmem.dmemr_mem <= 0;
		exmem.dmemw_mem <= 0;
		// exmem.WEN_mem <= 0;
		// exmem.memtoreg_mem <= 0;
		// exmem.dmemstore <= 0;
		// exmem.imm_mem <= 0;
        // exmem.presult_mem <= 0;
        // exmem.zero_mem <= 0;
		// exmem.branch_mem <= 0;
    end
    //else if(exmem.ihit && !exmem.flush)begin
	else if(exmem.pipeline_control && !exmem.flush)begin
        exmem.imemaddr_mem <= exmem.imemaddr_exe;
		exmem.imemload_mem <= exmem.imemload_exe;
		exmem.halt_mem <= exmem.halt_exe;
		exmem.jal_mem <= exmem.jal_exe;
		exmem.jalr_mem <= exmem.jalr_exe;
		exmem.auipc_mem <= exmem.auipc_exe;
		exmem.lui_mem <= exmem.lui_exe;
		exmem.dmemr_mem <= exmem.dmemr_exe;
		exmem.dmemw_mem <= exmem.dmemw_exe;
		exmem.WEN_mem <= exmem.WEN_exe;
		exmem.memtoreg_mem <= exmem.memtoreg_exe;
		exmem.dmemstore <= exmem.rdat2_exe;
		exmem.imm_mem <= exmem.imm_exe;
        exmem.presult_mem <= exmem.presult_exe;
        exmem.zero_mem <= exmem.zero_exe;
		exmem.branch_mem <= exmem.branch_exe;
	end
    
end
endmodule