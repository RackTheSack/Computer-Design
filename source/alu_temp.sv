`include "alu_if.vh"
`include "cpu_types_pkg.vh"

module alu (
    alu_if.alu aluif
);

import cpu_types_pkg::*;

always_comb begin 
    aluif.presult = 0;
    aluif.ovf = 0;
    casez (aluif.alu_op)

    ALU_ADD: begin
        aluif.presult = aluif.pa + aluif.pb;
        if(!aluif.pa[31] & !aluif.pb[31] & aluif.presult[31])begin
                aluif.ovf = 1;
        end

        else if(aluif.pb[31] & aluif.pa[31] & !aluif.presult[31]) begin 
                aluif.ovf = 1;
        end
    end

    ALU_SUB: begin
        aluif.presult = aluif.pa - aluif.pb;
        if((aluif.pb[31] ^ !aluif.pa[31]) & !aluif.presult[31] ) begin 
                aluif.ovf = 1;
        end

        else if((!aluif.pb[31] ^ aluif.pa[31]) & aluif.presult[31] ) begin 
                aluif.ovf = 1;
        end
    end

    ALU_XOR: begin
        aluif.presult = aluif.pa ^ aluif.pb;
    end

    ALU_OR: begin
        aluif.presult = aluif.pa | aluif.pb;
    end

    ALU_AND: begin
        aluif.presult = aluif.pa & aluif.pb;
    end

    ALU_SLL: begin
        aluif.presult = aluif.pa << aluif.pb[4:0];
    end

    ALU_SRL: begin
        aluif.presult = aluif.pa >> aluif.pb[4:0];
    end

    ALU_SRA: begin
        aluif.presult = $signed(aluif.pa) >>> aluif.pb[4:0];
    end

    ALU_SLT: begin
        aluif.presult = (aluif.pa < aluif.pb)? 1: 0;
    end

    ALU_SLTU: begin
        aluif.presult = ($unsigned(aluif.pa) < $unsigned(aluif.pb)) ? 1: 0;
    end

    default: 
        aluif.presult = 0;
    endcase
end

assign aluif.neg = aluif.presult[31];
assign aluif.zero = ! (|aluif.presult);

endmodule