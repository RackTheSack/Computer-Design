`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"



module icache
(
	input logic CLK, nRST,
	datapath_cache_if.icache dcif, 
    caches_if.icache cif
);


import cpu_types_pkg::*;

word_t imemload;
icachef_t iaddr, imemaddr;

//logic imiss;

assign imemaddr = dcif.imemaddr;


//icache
icache_frame [15:0] icache, nxt_icache;

always_ff @(posedge CLK or negedge nRST) begin
    if(!nRST) begin 
        icache <= '0;
    end
    else begin 
        icache <= nxt_icache;
    end
end


//when do we get a miss
//assign imiss = !(icache[imemaddr.idx].valid && (icache[imemaddr.idx].tag == imemaddr.tag)) && dcif.imemREN;

//the icache FSM
typedef enum logic {  
    IDLE = 1'b0,
    MISS = 1'b1
} state_t;


state_t state, nxt_state;

always_ff @(posedge CLK or negedge nRST) begin
    if(!nRST)begin 
        state <= IDLE;
    end

    else begin 
        state <= nxt_state;
    end
end



//state transition and output logic 
always_comb begin

        nxt_state = state;
        nxt_icache = icache;


        dcif.ihit = 0;
        dcif.imemload = '0;

        cif.iREN = 0;
        cif.iaddr = '0;

    casez (state)
        IDLE: begin 

            if ((icache[imemaddr.idx].valid && (icache[imemaddr.idx].tag == imemaddr.tag)) && dcif.imemREN) begin//  V && tag_match && imemREN
                dcif.ihit = 1;
                dcif.imemload = icache[imemaddr.idx].data;
            end

            if (!(icache[imemaddr.idx].valid && (icache[imemaddr.idx].tag == imemaddr.tag)) && dcif.imemREN) begin 
                nxt_state = MISS;
            end
        end

        MISS: begin

            cif.iREN = 1'b1;
            cif.iaddr = dcif.imemaddr;

            if(!cif.iwait) begin 
                nxt_state = IDLE;
                nxt_icache[imemaddr.idx].data = cif.iload;
                nxt_icache[imemaddr.idx].valid = 1'b1;
                nxt_icache[imemaddr.idx].tag = imemaddr.tag;
            end
        end

    endcase
end

endmodule