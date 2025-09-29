#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Test with halt
#--------------------------------------
  org 0x0000

  li $5, 10
  halt

  li $5, 6
  push $5


#uncomment to work with the simulator (sim)
# comment to use mmio

//  org 0x0F00
//  cfw 22
