`include "datapath_cache_if.vh"
`include "caches_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;

module icache_tb();

    parameter PERIOD = 10;

    logic CLK = 1, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    logic CPUCLK = 0;

    always #(PERIOD) CPUCLK++;

    datapath_cache_if dcif ();
    caches_if cif ();

    test #(.PERIOD (PERIOD)) PROG(
        CPUCLK, nRST, dcif, cif
    );

    icache DUT(CLK, nRST, dcif, cif);

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if dcif, caches_if cif);

parameter PERIOD = 10;

endprogram