`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"

module dcache
(
	input logic CLK, nRST,
	datapath_cache_if.dcache dcif,
    caches_if.dcache cif
);


import cpu_types_pkg::*;

typedef enum logic [3:0]{
    IDLE, STORE1, STORE2, LOAD1, LOAD2, D_CHECK, D_STORE1, D_STORE2, C_STORE, HALT
} state_t;

dcachef_t cache_add;
logic en;
logic selL, selR;
//logic next_dhit;
dcache_frame [7:0] [1:0] dcache, next_dcache;
logic [7:0] lru, next_lru;
logic [3:0] counter, next_counter;
logic [31:0] hit_counter, next_hit_counter;

assign en = dcif.dmemREN || dcif.dmemWEN;

assign cache_add.tag = dcif.dmemaddr[31:6];
assign cache_add.idx = dcif.dmemaddr[5:3];
assign cache_add.blkoff = dcif.dmemaddr[2];
assign cache_add.bytoff = dcif.dmemaddr[1:0];

assign selL = (dcache[cache_add.idx][0].valid && (dcache[cache_add.idx][0].tag == cache_add.tag) && en);
assign selR = (dcache[cache_add.idx][1].valid && (dcache[cache_add.idx][1].tag == cache_add.tag) && en);

assign dcif.dhit = (selL||selR) ? 1: 0;



state_t state, next_state;



always_ff @(posedge CLK or negedge nRST) begin //the ff
    if(!nRST)begin 
        state <= IDLE;
        lru <= '0;
        counter <= '0;
        dcache <= '0;
        hit_counter <='0;
        //dcif.dhit <= '0;
        
    end

    else begin 
        state <= next_state;
        lru <= next_lru;
        counter <= next_counter;
        dcache <= next_dcache;
        hit_counter <= next_hit_counter;
        //dcif.dhit <= next_dhit;
    end
end

always_comb begin //lru logic
    next_lru = lru;
    if(dcif.dhit == 1) begin
        next_lru[cache_add.idx] = selL ? 1: 0;
    end
end

always_comb begin //ohhh I am amking my state transitions here
    //next_dhit = (selL||selR) ? 1: 0;
    next_state = state;
    next_dcache = dcache;
    next_counter = counter;
    cif.dREN = 0;
    cif.dWEN = 0;
    cif.daddr = '0;
    cif.dstore = '0;
    dcif.dmemload = '0;
    dcif.flushed= 0;
    next_hit_counter = hit_counter;
    casez(state)
        IDLE: begin
            next_counter = 0;
            cif.dREN = 0;
            cif.dWEN = 0;
            cif.daddr = '0;
            cif.dstore = '0;
            dcif.dmemload = '0;
            dcif.flushed= 0;
            if(dcif.halt) begin
                next_state = D_CHECK;
            end
            else if (dcif.dhit) begin
                next_hit_counter = hit_counter +1;
                //next_dhit = '0;
                if(dcif.dmemREN) begin
                    //reading from cache here lol
                    dcif.dmemload = selL ? dcache[cache_add.idx][0].data[cache_add.blkoff]: dcache[cache_add.idx][1].data[cache_add.blkoff];

                end
                else begin
                    //writing from datapath to cache here lol
                    //next_dcache[cache_add.idx][lru[cache_add.idx]].data[cache_add.blkoff] = dcif.dmemstore;
                    next_dcache[cache_add.idx][selR].data[cache_add.blkoff] = dcif.dmemstore;
                    //set the dirty bit to 1
                    next_dcache[cache_add.idx][selR].dirty = 1;

                end
            end
            else if (en) begin
                if((dcif.dhit == 0) && dcache[cache_add.idx][lru[cache_add.idx]].dirty) begin
                    next_state = STORE1;
                end
                else if(dcif.dhit == 0) begin
                    next_state = LOAD1;
                end
                else begin
                    next_state =state;
                end                   
            end  
        end
        STORE1: begin
            cif.dREN = 0;
            cif.dWEN = 1;
            cif.daddr = {dcache[cache_add.idx][lru[cache_add.idx]].tag, cache_add.idx,  1'b0, cache_add.bytoff};
            cif.dstore = dcache[cache_add.idx][lru[cache_add.idx]].data[0];
            dcif.dmemload = '0;
            
            if(cif.dwait == 0) begin
                next_state = STORE2;
            end
            else begin
                next_state =state;
            end
        end
        STORE2: begin
            cif.dREN = 0;
            cif.dWEN = 1;
            cif.daddr = {dcache[cache_add.idx][lru[cache_add.idx]].tag, cache_add.idx,  1'b1, cache_add.bytoff};
            cif.dstore = dcache[cache_add.idx][lru[cache_add.idx]].data[1];
            dcif.dmemload = '0;
            if(cif.dwait == 0) begin
                next_state = LOAD1;
            end
            else begin
                next_state =state;
            end
        end
        LOAD1: begin
            
            cif.dREN = 1;
            cif.dWEN = 0;
            cif.daddr = {cache_add.tag, cache_add.idx,  1'b0, cache_add.bytoff};
            cif.dstore = '0;
            next_dcache[cache_add.idx][lru[cache_add.idx]].data[0] = cif.dload;
            if(cif.dwait == 0) begin
                next_hit_counter = hit_counter -1;
                next_state = LOAD2;
            end
            else begin
                next_hit_counter = hit_counter;
                next_state =state;
            end
        end
        LOAD2: begin
            cif.dREN = 1;
            cif.dWEN = 0;
            cif.daddr = {cache_add.tag, cache_add.idx,  1'b1, cache_add.bytoff};
            cif.dstore = '0;
            
            if(cif.dwait == 0) begin
                next_state = IDLE;
                next_dcache[cache_add.idx][lru[cache_add.idx]].data[1] = cif.dload;
                next_dcache[cache_add.idx][lru[cache_add.idx]].tag = cache_add.tag;
                next_dcache[cache_add.idx][lru[cache_add.idx]].valid = 1;
                next_dcache[cache_add.idx][lru[cache_add.idx]].dirty = 0;
                //next_dhit = 1;
            end
            else begin
                next_state =state;
            end
        end
        D_CHECK: begin
            cif.dREN = 0;
            cif.dWEN = 0;
            if(counter >= 4'd15 && !dcache[3'b111][1'b1].dirty) begin
                next_state = C_STORE;
            end
            else if(dcache[counter[2:0]][counter[3]].dirty) begin
                next_state =D_STORE1;
            end
            else begin
                next_counter = counter + 1;
            end
        end
        D_STORE1: begin
            cif.dREN = 0;
            cif.dWEN = 1;
            cif.daddr = {dcache[counter[2:0]][counter[3]].tag, counter[2:0],  1'b0, 2'b0};
            cif.dstore = dcache[counter[2:0]][counter[3]].data[0];
            dcif.dmemload = '0;
            if(cif.dwait == 0) begin
                next_state = D_STORE2;
                
            end
            else begin
                next_state =D_STORE1;
            end
        end
        D_STORE2: begin
            cif.dREN = 0;
            cif.dWEN = 1;
            cif.daddr = {dcache[counter[2:0]][counter[3]].tag, counter[2:0],  1'b1, 2'b0};
            cif.dstore = dcache[counter[2:0]][counter[3]].data[1];
            next_dcache[counter[2:0]][counter[3]].dirty = '0;
            dcif.dmemload = '0;
            if(cif.dwait == 0) begin
                next_state = D_CHECK;
                //next_counter = counter < 4'd15 ? counter +1 : 4'd15;
            end
            else begin
                next_state =D_STORE2;
            end
        end
        C_STORE: begin
            cif.dREN = 0;
            cif.dWEN = 1;
            cif.daddr = 32'h3100;
            cif.dstore = hit_counter;
            dcif.dmemload = '0;
            dcif.flushed= 0;
            if(cif.dwait == 0) begin
                next_state = HALT;
            end
            else begin
                next_state =C_STORE;
            end
        end
        HALT: begin
            cif.dREN = 0;
            cif.dWEN = 0;
            cif.daddr = '0;
            cif.dstore = '0;
            dcif.dmemload = '0;
            dcif.flushed= 1;
            next_state =HALT;
        end
        default: begin
            cif.dREN = 0;
            cif.dWEN = 0;
            cif.daddr = '0;
            cif.dstore = '0;
            dcif.dmemload = '0;
            dcif.flushed= 0;
            next_state =state;
        end
    endcase
end


endmodule