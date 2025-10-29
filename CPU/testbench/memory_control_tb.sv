/*
  Fatma Alagroudy
  fatma.alagroudy@gmail.com

    memory control test bench
*/

// mapped needs this
`include "caches_if.vh"
// memory types
`include "cpu_types_pkg.vh"
// ram interface
`include "cpu_ram_if.vh"

`include "cache_control_if.vh"


// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;

  parameter PERIOD = 10;

    logic CLK = 1, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  logic CPUCLK = 0;

  always #(PERIOD) CPUCLK++;


  caches_if cif0 ();
  caches_if cif1 (); 
  cpu_ram_if ramif ();

  cache_control_if ccif (
    cif0, cif1
  );
  // test program
  test #(.PERIOD (PERIOD)) PROG(
    CPUCLK, nRST, cif0
  );
  // DUT
`ifndef MAPPED
  memory_control DUT(CPUCLK, nRST, ccif);
  ram RAM (CLK, nRST, ramif);
`else
   DUT(
    .\ccif.iwait (ccif.iwait),
    .\ccif.dwait (ccif.dwait),
    .\ccif.iREN (ccif.iREN),
    .\ccif.dREN (ccif.dREN),
    .\ccif.dWEN (ccif.dWEN),
    .\ccif.iload (ccif.iload),
    .\ccif.dload (ccif.dload),
    .\ccif.dstore (ccif.dstore),
    .\ccif.iaddr (ccif.iaddr),
    .\ccif.daddr (ccif.daddr),
    .\ccif.ramload (ccif.ramload),
    .\ccif.ramstate (ccif.ramstate),
    .\ccif.ramWEN (ccif.ramWEN),
    .\ccif.ramREN (ccif.ramREN),
    .\ccif.ramstore (ccif.ramstore),
    .\ccif.ramaddr (ccif.ramaddr)
  );

  RAM(
    .\ramif.ramaddr (ramif.ramaddr),
    .\ramif.ramstate (ramif.ramstore),
    .\ramif.ramREN (ramif.ramREN),
    .\ramif.ramWEN (ramif.ramWEN),
    .\ramif.ramstate (ramif.ramstate),
    .\ramif.ramload (ramif.ramload)
  );
`endif

assign ramif.ramaddr = ccif.ramaddr;
assign ramif.ramstore = ccif.ramstore;
assign ramif.ramREN = ccif.ramREN;
assign ramif.ramWEN = ccif.ramWEN;
assign ccif.ramstate = ramif.ramstate;
assign ccif.ramload = ramif.ramload;

endmodule

program test(input logic CLK, output logic nRST, caches_if.caches cif0);

parameter PERIOD = 10;

initial begin

    nRST = 0;
    #(PERIOD*2);

    nRST=1;
    
    cif0.dstore = 32'hAAAAAAAA;
    cif0.daddr = 32'hCC;


    //trying to read instruction address BB
    cif0.iREN = 1;
    cif0.iaddr = 32'h00;
    cif0.dREN = 0;
    cif0.dWEN = 0;
    #(PERIOD*2);

    cif0.daddr = 32'h20;
    cif0.dREN = 0;
    cif0.dWEN = 1;
    cif0.dstore = 'h75;
    #(PERIOD*2);


    cif0.daddr = 32'h20;
    cif0.dREN = 1;
    cif0.dWEN = 0;
    #(PERIOD*2);

    dump_memory();
    $finish;


  

  end

  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask


endprogram
