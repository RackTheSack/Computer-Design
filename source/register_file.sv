`include "register_file_if.vh"

module register_file (
   input logic CLK,
   input logic nRST,
   register_file_if.rf rfif
);

logic [31:0] [31:0] reg_file;
logic [31:0] [31:0] nxt_reg_file;

assign rfif.rdat1 = reg_file[rfif.rsel1];
assign rfif.rdat2 = reg_file[rfif.rsel2];

always_ff @(negedge CLK, negedge nRST) begin

    if(!nRST) begin 
        reg_file <= '0;
    end
    else begin
        reg_file <= nxt_reg_file;
    end
end

always_comb begin

    nxt_reg_file = reg_file;

    if(rfif.WEN && rfif.wsel != 0) begin 
        nxt_reg_file[rfif.wsel] = rfif.wdat;
    end

    
end

endmodule
