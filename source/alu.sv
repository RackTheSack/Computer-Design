// `include "alu_if.vh"
// `include "cpu_types_pkg.vh"
// import cpu_types_pkg::*;

// module alu (
//     alu_if.alu aluif
// );

// // alu op type
// typedef enum logic [3:0] {
// ALU_SLL     = 4'b0000,
// ALU_SRL     = 4'b0001,
// ALU_SRA     = 4'b0010,
// ALU_ADD     = 4'b0011,
// ALU_SUB     = 4'b0100,
// ALU_AND     = 4'b0101,
// ALU_OR      = 4'b0110,
// ALU_XOR     = 4'b0111,
// ALU_SLT     = 4'b1010,
// ALU_SLTU    = 4'b1011
// } aluop_t;

// logic [31:0] sll_res, srl_res, sra_res,
//              add_res, sub_res, 
//              and_res, or_res, xor_res,
//              slt_res, sltu_res;




// assign  sll_res = aluif.pa << aluif.pb[4:0]; //logical left shift
// assign  srl_res = aluif.pa >> aluif.pb[4:0]; //logical right shift
// assign  sra_res = $signed(aluif.pa) >>> aluif.pb[4:0]; //arithmetic right shift

// always_comb begin //signed add and subtract

//     add_res = aluif.pa + aluif.pb;
//     sub_res = aluif.pa - aluif.pb;

//     if(aluif.alu_op == ALU_ADD && !aluif.pa[31] && !aluif.pb[31] & add_res [31])begin
//             aluif.ovf = 1;
//     end

//     else if(aluif.alu_op == ALU_ADD && aluif.pb[31] && aluif.pa[31] & !add_res [31]) begin 
//             aluif.ovf = 1;
//     end

//     else if(aluif.alu_op == ALU_SUB && (aluif.pb[31] ^ !aluif.pa[31]) & !sub_res[31] ) begin 
//             aluif.ovf = 1;
//     end

//     else if(aluif.alu_op == ALU_SUB && (!aluif.pb[31] ^ aluif.pa[31]) & sub_res[31] ) begin 
//             aluif.ovf = 1;
//     end

//     else
//         aluif.ovf = 0;
// end

// assign and_res = aluif.pa & aluif.pb;
// assign or_res = aluif.pa | aluif.pb;
// assign xor_res = aluif.pa ^ aluif.pb;

// always_comb begin 
//     if(!(aluif.pa[31] ^ aluif.pb[31]))begin
//         slt_res = (aluif.pa < aluif.pb)? 1: 0;
//     end

//     else if(aluif.pa[31] & !aluif.pb[31]) begin 
//         slt_res = 1;
//     end

//     else
//         slt_res = 0;
// end

// assign sltu_res = (aluif.pa < aluif.pb)? 1: 0;

// always_comb begin 
// casez (aluif.alu_op)

// ALU_ADD: begin
//     aluif.presult = add_res;
// end

// ALU_SUB: begin
//     aluif.presult = sub_res;
// end

// ALU_XOR: begin
//     aluif.presult = xor_res;
// end

// ALU_OR: begin
//     aluif.presult = or_res;
// end

// ALU_AND: begin
//     aluif.presult = and_res;
// end

// ALU_SLL: begin
//     aluif.presult = sll_res;
// end

// ALU_SRL: begin
//     aluif.presult = srl_res;
// end

// ALU_SRA: begin
//     aluif.presult = sra_res;
// end

// ALU_SLT: begin
//     aluif.presult = slt_res;
// end

// ALU_SLTU: begin
//     aluif.presult = sltu_res;
// end

// default: 
//     aluif.presult = 0;
// endcase
// end

// always_comb begin 

//     if(aluif.presult[31])begin 
//         aluif.neg = 1;
//     end

//     else begin 
//         aluif.neg = 0;
//     end

//     // if(aluif.presult == 0)begin 
//     //     aluif.zero = 1;
//     // end

//     // else begin 
//     //     aluif.zero = 0;
//     // end
// end

// assign aluif.zero = ! (|aluif.presult);

// endmodule

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