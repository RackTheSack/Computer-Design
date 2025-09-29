 org 0x0000

  li x3, 0x14

loop:
  lw x5, 0(x3)
  addi x3, x3, -4
  bne x3, x0, loop

  halt
