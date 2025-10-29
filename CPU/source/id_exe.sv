`include "cpu_types_pkg.vh"
`include "id_exe_if.vh"

module id_exe
(
	input logic CLK, nRST,
	id_exe_if.idexe idex
);


import cpu_types_pkg::*;

always_ff @(posedge CLK, negedge nRST) begin
	if (!nRST) begin
		idex.imemaddr_exe <= 0;
		idex.imemload_exe <= 0;
		idex.halt_exe <= 0;
		idex.ALUsrc_exe <= 0;
		idex.jal_exe <= 0;
		idex.jalr_exe <= 0;
		idex.auipc_exe <= 0;
		idex.lui_exe <= 0;
		idex.dmemr_exe <= 0;
		idex.dmemw_exe <= 0;
		idex.WEN_exe <= 0;
		idex.memtoreg_exe <= 0;
		idex.alu_op_exe <= ALU_SLL;
		idex.rdat1_exe <= 0;
		idex.rdat2_exe <= 0;
		idex.imm_exe <= 0;
		idex.branch_exe <= 0;
    end
	//else if (idex.ihit && (idex.flush || idex.hazard_detected)) begin
	else if (idex.pipeline_control && (idex.flush || idex.hazard_detected)) begin
		idex.imemaddr_exe <= 0;
		idex.imemload_exe <= 0;
		idex.halt_exe <= 0;
		idex.ALUsrc_exe <= 0;
		idex.jal_exe <= 0;
		idex.jalr_exe <= 0;
		idex.auipc_exe <= 0;
		idex.lui_exe <= 0;
		idex.dmemr_exe <= 0;
		idex.dmemw_exe <= 0;
		idex.WEN_exe <= 0;
		idex.memtoreg_exe <= 0;
		idex.alu_op_exe <= ALU_SLL;
		idex.rdat1_exe <= 0;
		idex.rdat2_exe <= 0;
		idex.imm_exe <= 0;
		idex.branch_exe <= 0;
    end
	//else if (idex.ihit)begin
	else if (idex.pipeline_control)begin
		idex.imemaddr_exe <= idex.imemaddr_id;
		idex.imemload_exe <= idex.imemload_id;
		idex.halt_exe <= idex.halt_id;
		idex.ALUsrc_exe <= idex.ALUsrc_id;
		idex.jal_exe <= idex.jal_id;
		idex.jalr_exe <= idex.jalr_id;
		idex.auipc_exe <= idex.auipc_id;
		idex.lui_exe <= idex.lui_id;
		idex.dmemr_exe <= idex.dmemr_id;
		idex.dmemw_exe <= idex.dmemw_id;
		idex.WEN_exe <= idex.WEN_id;
		idex.memtoreg_exe <= idex.memtoreg_id;
		idex.alu_op_exe <= idex.alu_op_id;
		idex.rdat1_exe <= idex.rdat1_id;
		idex.rdat2_exe <= idex.rdat2_id;
		idex.imm_exe <= idex.imm_id;
		idex.branch_exe <= idex.branch_id;
	end
	//else if (idex.dhit) begin 
	// 	idex.rdat1_exe <= idex.rdat1_id;
	// 	idex.rdat2_exe <= idex.rdat2_id;
	// end
	
end
endmodule