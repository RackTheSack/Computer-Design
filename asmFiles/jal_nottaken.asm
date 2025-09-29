#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Test with jal not taken
#--------------------------------------
  org 0x0000

  li $5, 1
  jal go
  addi  $5, $5, 1
  push $5
  halt

  go:
  addi $5, $5, 1
  push $5
  halt



#uncomment to work with the simulator (sim)
# comment to use mmio

//  org 0x0F00
//  cfw 22
