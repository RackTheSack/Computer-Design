#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Test with beq taken
#--------------------------------------
  org 0x0000

  li $5, 1
  li $6, 2
  bne $5, $6, go
  li $7, 1
  push $7
  halt

  go:
  li $7, 2
  push $7
  halt


#uncomment to work with the simulator (sim)
# comment to use mmio

//  org 0x0F00
//  cfw 22
