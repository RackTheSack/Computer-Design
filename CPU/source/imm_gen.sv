`include "imm_gen_if.vh"

// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module imm_gen (
    imm_gen_if.ig igif
);

logic [6:0] opcode;
logic [31:0] imm;
logic [31:0] inst;

assign igif.imm = imm;
assign opcode = igif.inst[6:0];
assign inst = igif.inst;

always_comb begin

    imm = '0;

    casez (opcode)

    ITYPE: begin 
        if(inst[31]) begin
            imm = {20'hfffff, inst[31:20]};
        end
        else begin 
            imm = {20'h0, inst[31:20]};
        end
    end

    ITYPE_LW: begin 
        if(inst[31]) begin
            imm = {20'hfffff, inst[31:20]};
        end
        else begin 
            imm = {20'h0, inst[31:20]};
        end
    end

    JALR: begin 
        if(inst[31]) begin
            imm = {20'hfffff, inst[31:20]};
        end
        else begin 
            imm = {20'h0, inst[31:20]};
        end
    end

    STYPE: begin 
        if(inst[31])begin 
            imm = {20'hfffff, inst[31:25], inst[11:7]};
        end
        else begin 
            imm = {20'h0,  inst[31:25], inst[11:7]};
        end
    end

    BTYPE: begin 
        if(inst[31])begin 
            imm = {19'hfffff, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        end
        else begin 
            imm = {19'h0, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
        end
    end

    JAL: begin 
        if(inst[31])begin 
            imm = {19'hfffff, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        end
        else begin 
            imm = {19'h0, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
        end
    end

    LUI: begin 
        imm = {inst[31:12], 12'b0};
    end

    AUIPC: begin 
        imm = {inst[31:12], 12'b0};
    end
    endcase
end


endmodule