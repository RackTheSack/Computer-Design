`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"
`include "caches_if.vh"
`include "cpu_ram_if.vh"
`include "cache_control_if.vh"

`timescale 1 ns / 1 ns

import cpu_types_pkg::*;


module dcache_tb;

    parameter PERIOD = 10;

    logic CLK = 1, nRST;

    // clock
    always #(PERIOD/2) CLK++;

    logic CPUCLK = 0;

    always #(PERIOD) CPUCLK++;

    datapath_cache_if dcif ();
    caches_if cif ();
    // caches_if cif1 (); 
    // cpu_ram_if ramif ();
    // cache_control_if ccif (
    //     cif0, cif1
    // );
    
      // test program
    test #(.PERIOD (PERIOD)) PROG(
        CPUCLK, nRST, dcif, cif
    );


    `ifndef MAPPED
        dcache DUT(CLK, nRST, dcif, cif);
        //memory_control DUT(CPUCLK, nRST, ccif);
        //ram RAM (CLK, nRST, ramif);
    `else
    DUT(
    .\cif.dwait (cif.dwait),
    .\cif.dload (cif.dload),
    .\dcif.halt (dcif.halt),

    .\dcif.dmemREN (dcif.dmemREN),
    .\dcif.dmemWEN (dcif.dmemWEN),
    .\dcif.dmemstore (dcif.dmemstore),
    .\dcif.dmemaddr (dcif.dmemaddr),

    .\dcif.dhit (dcif.dhit),
    .\dcif.dmemload (dcif.dmemload),
    .\dcif.flushed (dcif.flushed),

    .\cif.dREN (cif.dREN),
    .\cif.dWEN (cif.dWEN),
    .\cif.daddr (cif.daddr),
    .\cif.dstore (cif.dstore)
    );

  //   MEMORY_CONTROL(
  //   .\ccif.iwait (ccif.iwait),
  //   .\ccif.dwait (ccif.dwait),
  //   .\ccif.iREN (ccif.iREN),
  //   .\ccif.dREN (ccif.dREN),
  //   .\ccif.dWEN (ccif.dWEN),
  //   .\ccif.iload (ccif.iload),
  //   .\ccif.dload (ccif.dload),
  //   .\ccif.dstore (ccif.dstore),
  //   .\ccif.iaddr (ccif.iaddr),
  //   .\ccif.daddr (ccif.daddr),
  //   .\ccif.ramload (ccif.ramload),
  //   .\ccif.ramstate (ccif.ramstate),
  //   .\ccif.ramWEN (ccif.ramWEN),
  //   .\ccif.ramREN (ccif.ramREN),
  //   .\ccif.ramstore (ccif.ramstore),
  //   .\ccif.ramaddr (ccif.ramaddr)
  // );

  // RAM(
  //   .\ramif.ramaddr (ramif.ramaddr),
  //   .\ramif.ramstate (ramif.ramstore),
  //   .\ramif.ramREN (ramif.ramREN),
  //   .\ramif.ramWEN (ramif.ramWEN),
  //   .\ramif.ramstate (ramif.ramstate),
  //   .\ramif.ramload (ramif.ramload)
  // );
  `endif


//assign ramif.ramaddr = ccif.ramaddr;
//assign ramif.ramstore = ccif.ramstore;
//assign ramif.ramREN = ccif.ramREN;
//assign ramif.ramWEN = ccif.ramWEN;
//assign ccif.ramstate = ramif.ramstate;
//assign ccif.ramload = ramif.ramload;

endmodule


program test(input logic CLK, output logic nRST, datapath_cache_if dcif, caches_if cif);

parameter PERIOD = 10;
word_t hit_counter; 


string test_case;

initial begin

    //initialize everything
    test_case = "Starting Processor";
    dcif.halt = 0;
    dcif.dmemREN = 0;
    dcif.dmemWEN = 0;
    dcif.dmemstore = '0;
    dcif.dmemaddr = '0;
    nRST = 0;
    hit_counter = 0;

    cif.dwait = 1;
    cif.dload = 32'h0;

    @(posedge CLK);
    @(negedge CLK);

    nRST=1;
    @(negedge CLK);

    test_case = "Clean Miss lw";
    dcif.dmemREN = 1'b1;
    dcif.dmemaddr = 32'hC;//dhit should be low now 

    @(negedge CLK);//state should now be load 0
    if(cif.dREN == 0 || cif.daddr != 32'h8 || dcif.dhit != 0) begin 
      $display("Failed: dREN should be high, daddr should be 8, dhit should be low");
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be load1
    cif.dload = 32'hDEADBEEF;

    @(negedge CLK);//state is now load1

    if(cif.dREN == 0 || cif.daddr != 32'hC || dcif.dhit != 0) begin 
      $display("Failed: dREN should be high, daddr should be C, dhit should be low");
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be idle
    cif.dload = 32'hBABAFEFE;

    @(negedge CLK);//a dhit should now be asserted
    dcif.dmemREN = 0;
    if(dcif.dhit != 1 || dcif.dmemload != 32'hBABAFEFE || cif.dREN == 1 ) begin 
      $display("Failed: dmemload should be BABAFEFE and dhit should be high");
    end
    else begin 
      $display("Passed");
      hit_counter ++;
    end


    @(negedge CLK);//should still be an idle
    test_case = "Clean Miss sw";
    //I am attempting to drive the dcache have a dirty frame
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hBEBAFEFE;
    dcif.dmemaddr = 32'h10;
    cif.dwait = 1;
    //this should drive the design to load0 then load1
    
    @(negedge CLK);//load0
    if(cif.dREN == 0 || cif.daddr != 32'h10 || dcif.dhit != 0) begin 
      $display("Failed: dREN should be high, daddr should be 'h10, dhit should be low");
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be load1
    cif.dload = 32'hDEDEBABA;

    @(negedge CLK);

    if(cif.dREN == 0 || cif.daddr != 32'h14 || dcif.dhit != 0) begin 
      $display("Failed: dREN should be high, daddr should be 'h14, dhit should be low");
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be idle
    cif.dload = 32'hCECEBABA;//this value should be in the cache at index 2 and dirty bit of that frame is high

    @(negedge CLK); //now to idle
    hit_counter ++;

    dcif.dmemREN = 0;
    dcif.dmemWEN = 0;
    cif.dwait = 1;

    @(negedge CLK);//should still be an idle
    test_case = "Clean Miss sw";
    //I am attempting to drive the dcache have a dirty frame
    dcif.dmemWEN = 1;
    dcif.dmemstore = 32'hBEBAFEFE;
    dcif.dmemaddr = 32'h50;//same index of 2
    cif.dwait = 1;
    //this should drive the design to load0 then load1
    
    @(negedge CLK);//load0
    if(cif.dREN == 0 || cif.daddr != 32'h50 || dcif.dhit != 0) begin 
      $display("Failed: dREN should be high, daddr should be 'h50, dhit should be low");
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be load1
    cif.dload = 32'hDEDEBABA;

    @(negedge CLK);

    if(cif.dREN == 0 || cif.daddr != 32'h54 || dcif.dhit != 0) begin 
      $display("Failed: dREN should be 1, not %b, daddr should be 'h54, not %h, dhit should be, 0 not %b", cif.dREN, cif.daddr, dcif.dhit);
    end
    else begin 
      $display("Passed");
    end

    cif.dwait = 0;//nxt state should be idle
    cif.dload = 32'hCECEBABA;//this value should be in the cache at index 2 and dirty bit of that frame is high

    @(negedge CLK);//still idle
    test_case = "Dirty Miss lw";
    dcif.dmemREN = 1;
    dcif.dmemaddr = 32'h14;//this should take us to state W0
    cif.dwait = 1;

    @(posedge CLK);//W0
    if(cif.dWEN != 1 || cif.daddr != 32'h10 || cif.dstore != 32'hBEBAFEFE) begin
       $display("Failed: dWEN should be high, not %b daddr should be 'h50, not %h, and dstore should be 32'hBEBAFEFE, not %h",
        cif.dWEN, cif.daddr, cif.dstore);
    end
    cif.dwait = 1'b0;

    @(posedge CLK);//W1
    if(cif.dWEN != 1 || cif.daddr != 32'h14 || cif.dstore != 32'hBEBAFEFE) begin
       $display("Failed: dWEN should be high, not %b daddr should be 'h50, not %h, and dstore should be 32'hBEBAFEFE, not %h",
        cif.dWEN, cif.daddr, cif.dstore);
    end
    cif.dwait = 1'b0;

    @(negedge CLK);//L0
    @(negedge CLK);//L1

    dcif.halt = 1'b1;
    @(negedge CLK);//idle

    dcif.dmemREN = 0;
    dcif.dmemWEN = 0;

    //count 16*3 cycles + 1 cycle halt ~50 cycles to check all dcache for dirty  bits
    for (int i = 0; i<52; i++) begin 
      @(negedge CLK);
    end
    //should go back to halt state

    $finish;
  

  end


endprogram