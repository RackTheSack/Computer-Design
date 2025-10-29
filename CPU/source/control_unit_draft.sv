`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module control_unit(
    control_unit_if.cu cuif
);


logic [6:0] opcode;
aluop_t [3:0] b_alu_op;
logic branch;

assign opcode = cuif.imemload[6:0];

always_comb begin
    if(opcode == HALT) begin 
        cuif.halt = 1;
    end

    else begin 
        cuif.halt = 0;
    end
end


always_comb begin 
    if(opcode== ITYPE || opcode == ITYPE_LW || opcode == STYPE || opcode == BTYPE || opcode == JAL || opcode == JALR ) begin 
        cuif.ALUsrc = 1;
    end
    else begin 
        cuif.ALUsrc = 0;
    end
end

always_comb begin
    if(opcode == JAL )begin 
        cuif.jal = 1;
    end
    else begin
        cuif.jal = 0;
    end
end

always_comb begin
    if(opcode == JALR )begin 
        cuif.jalr = 1;
    end
    else begin 
        cuif.jalr = 0;
    end
end

always_comb begin
    if(opcode == AUIPC )begin 
        cuif.auipc = 1;
    end
    else begin 
        cuif.auipc = 0;
    end
end

//branch unit
always_comb begin 

    if(opcode == BTYPE) begin 

        if (cuif.imemload[14:12] == BEQ || cuif.imemload[14:12] == BNE) begin 
            b_alu_op = ALU_SUB;
        end
        else if (cuif.imemload[14:12] == BLT || cuif.imemload[14:12] == BGE) begin 
            b_alu_op = ALU_SLT;
        end
        else if (cuif.imemload[14:12] == BLTU || cuif.imemload[14:12] == BGEU) begin 
            b_alu_op = ALU_SLTU;
        end
    end
    else begin 
        b_alu_op = 4'hF;
    end

end

always_comb begin 

    branch = 0;

    case (cuif.imemload[14:12])

    BEQ: begin 
        if(cuif.zero) begin 
            branch = 1;
        end
    end

    BNE: begin 
        if(!cuif.zero) begin 
            branch = 1;
        end
    end

    BGE: begin 
        if(!cuif.presult) begin 
            branch = 1;
        end
    end

    BGEU: begin 
        if(!cuif.presult) begin 
            branch = 1;
        end
    end

    BLT: begin 
        if(cuif.presult) begin 
            branch = 1;
        end
    end

    BLTU: begin 
        if(cuif.presult) begin 
            branch = 1;
        end
    end
    endcase


end


//alu opcode control unit
always_comb begin 

    cuif.dmemr = 0;
    cuif.dmemw = 0;

casez (opcode)

RTYPE: begin 
    casez (cuif.imemload[14:12])
        ADD_SUB: begin
            case (cuif.imemload[31:25])  
                ADD: cuif.alu_op = ALU_ADD;
                SUB: cuif.alu_op = ALU_SUB;
            endcase
        end

        XOR: begin 
            cuif.alu_op = ALU_XOR;
        end

        OR: begin 
            cuif.alu_op = ALU_OR;
        end

        AND: begin 
            cuif.alu_op = ALU_AND;
        end

        SLL: begin 
            cuif.alu_op = ALU_SLL;
        end
        SRL_SRA: begin 
            case (cuif.imemload[31:25])  
                SRA: cuif.alu_op = ALU_SRA;
                SRL: cuif.alu_op = ALU_SRL;
            endcase
        end

        SLT: begin 
            cuif.alu_op = ALU_SLT;
        end

        SLTU: begin 
            cuif.alu_op = ALU_SLTU;
        end

    endcase
end

ITYPE: begin 
    casez(cuif.imemload[14:12])

    ADDI: begin  
        cuif.alu_op = ALU_ADD;
    end

    XORI: begin 
        cuif.alu_op = ALU_XOR;
    end

    ORI: begin 
        cuif.alu_op = ALU_OR;
    end

    ANDI: begin 
        cuif.alu_op = ALU_AND;
    end

    SLLI: begin 
        cuif.alu_op = ALU_SLL;
    end

    SRLI_SRAI: begin 
        case (cuif.imemload[31:25])  
            7'b0100000: cuif.alu_op = ALU_SRA;
            7'b0000000: cuif.alu_op = ALU_SRL;
        endcase
    end

    SLTI: begin 
        cuif.alu_op = ALU_SLT;
    end

    SLTIU: begin 
        cuif.alu_op = ALU_SLTU;
    end

endcase
end

ITYPE_LW: begin 
    cuif.dmemr = 1;
    cuif.alu_op = ALU_ADD;
end

JALR: begin 
    cuif.alu_op = ALU_ADD;
end

STYPE: begin 
    cuif.dmemw = 1;
    cuif.alu_op = ALU_ADD;
end

BTYPE: begin 
    cuif.alu_op = b_alu_op;
end

JAL: begin 
    cuif.alu_op = ALU_ADD;
end

endcase
end

always_comb begin
    
    if( branch || cuif.jal ) begin 
        cuif.PCsrc = 1;
    end
    else begin 
        cuif.PCsrc = 0;
    end

end

assign cuif.branch = branch;


endmodule