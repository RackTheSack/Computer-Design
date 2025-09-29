`include "request_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;

module request_unit(
    input logic CLK,
    request_unit_if.ru ruif
);

    logic nxt_dmemREN, nxt_dmemWEN;

    always_ff @(posedge CLK, negedge ruif.nRST) begin 
        if(!ruif.nRST) begin 
            ruif.dmemREN <= 0;
            ruif.dmemWEN <= 0;

        end
        else begin 
            ruif.dmemREN <= nxt_dmemREN;
            ruif.dmemWEN <= nxt_dmemWEN;
        end
    end

    always_comb begin
        nxt_dmemREN = ruif.dmemREN;
        if(ruif.dmemr) begin 
            nxt_dmemREN = 1;
        end
        if(ruif.dmemREN & ruif.dhit) begin 
            nxt_dmemREN = 0;
        end
    end

    always_comb begin
        nxt_dmemWEN = ruif.dmemWEN;
        if(ruif.dmemw) begin 
            nxt_dmemWEN = 1;
        end
        if(ruif.dmemWEN & ruif.dhit) begin 
            nxt_dmemWEN = 0;
        end
    end

    assign ruif.imemREN = 1;

endmodule