`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module control_unit(
    control_unit_if.cu cuif
);

opcode_t opcode;
assign opcode = opcode_t'(cuif.imemload[6:0]);

always_comb begin 
    
    cuif.halt = 0;
    cuif.ALUsrc = 0;
    cuif.jal = 0;
    cuif.jalr = 0;
    cuif.auipc = 0;
    cuif.lui = 0;
    cuif.alu_op = ALU_OR;
    cuif.branch = 0;
    cuif.dmemr = 0;
    cuif.dmemw = 0;
    cuif.WEN = 0;
    cuif.memtoreg = 0;

    casez (opcode)

    RTYPE: begin 

        cuif.WEN = 1;

        casez (funct3_r_t'(cuif.imemload[14:12]))
        ADD_SUB: begin
            casez (funct7_r_t'(cuif.imemload[31:25]))  
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
            casez (funct7_srla_r_t'(cuif.imemload[31:25]))  
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
        cuif.WEN = 1;

        cuif.ALUsrc = 1;

        casez(funct3_i_t'(cuif.imemload[14:12]))

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
            casez (cuif.imemload[31:25])  
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
        cuif.WEN = 1;

        cuif.memtoreg = 1;
        cuif.ALUsrc = 1;
        cuif.dmemr = 1;
        cuif.alu_op = ALU_ADD;
    end

    JALR: begin 
        cuif.WEN = 1;

        cuif.jalr = 1;
        cuif.ALUsrc = 1;
        cuif.alu_op = ALU_ADD;
    end

    STYPE: begin 
        cuif.ALUsrc = 1;
        cuif.dmemw = 1;
        cuif.alu_op = ALU_ADD;
    end

    BTYPE: begin 
        cuif.ALUsrc = 0;
        cuif.branch = 1;
        casez (funct3_b_t'(cuif.imemload[14:12]))
        
        BEQ: begin 
            cuif.alu_op = ALU_SUB;
            // if(cuif.zero) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        BNE: begin 
            cuif.alu_op = ALU_SUB;
            // if(!cuif.zero) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        BGE: begin 
            cuif.alu_op = ALU_SLT;
            // if(!cuif.presult) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        BGEU: begin 
            cuif.alu_op = ALU_SLTU;
            // if(!cuif.presult) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        BLT: begin 
            cuif.alu_op = ALU_SLT;
            // if(cuif.presult) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        BLTU: begin 
            cuif.alu_op = ALU_SLTU;
            // if(cuif.presult) begin 
            //     cuif.branch = 1;
            //     cuif.PCsrc  = 1;
            // end
        end

        endcase
    end

    JAL: begin 
        cuif.alu_op = ALU_ADD;
        cuif.jal = 1;
        cuif.ALUsrc = 1;
        //cuif.PCsrc  = 1;
        cuif.WEN = 1;

    end

    LUI: begin 
        cuif.WEN = 1;
        cuif.ALUsrc = 1;
        cuif.lui = 1;
    end

    AUIPC: begin 
        cuif.WEN = 1;
        cuif.ALUsrc = 1;
        cuif.auipc = 1;
    end

    HALT: begin 
        cuif.halt = 1;
    end

    endcase
end

endmodule