/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 1;

  always_comb begin //ram address assignment

    if(ccif.dREN || ccif.dWEN)begin 
      ccif.ramaddr = ccif.daddr;
    end

    else
      ccif.ramaddr = ccif.iaddr;

  end

  always_comb begin //ramREN and ramWEN

    ccif.ramREN = 1;
    ccif.ramWEN = 0;
    if(ccif.dWEN) begin 
        ccif.ramWEN = 1;
        ccif.ramREN = 0;
    end
  end

  always_comb begin //rasmstore 
      ccif.ramstore = ccif.dstore;
  end

  always_comb begin //dload and iload
      ccif.dload = ccif.ramload;
      ccif.iload = ccif.ramload;
  end

  always_comb begin 
    ccif.iwait = 1;
    ccif.dwait = 1;

    if(ccif.ramstate == ACCESS) begin

      if(ccif.dREN || ccif.dWEN) begin 
        ccif.dwait = 0;
      end
      else if(ccif.iREN)begin 
        ccif.iwait = 0;
      end
    end
  end
endmodule
