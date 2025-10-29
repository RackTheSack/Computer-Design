`include "cpu_types_pkg.vh"
`include "if_id_if.vh"

module if_id
(
	input logic CLK, nRST,
	if_id_if.ifid ifid
);

    import cpu_types_pkg::*;
    always_ff @(posedge CLK, negedge nRST) begin
	if (!nRST) begin	
		ifid.imemaddr_id <= 0;
        ifid.imemload_id <= 0;
    end
    //else if (ifid.ihit && ifid.flush) begin
    else if (ifid.pipeline_control && ifid.flush) begin
		ifid.imemaddr_id <= 0;
        ifid.imemload_id <= 0;
    end
    //else if (ifid.ihit && ifid.enable)begin
    else if (ifid.pipeline_control && ifid.enable)begin
        ifid.imemaddr_id <= ifid.imemaddr_if;
        ifid.imemload_id <= ifid.imemload_if;
    end
    end 

endmodule