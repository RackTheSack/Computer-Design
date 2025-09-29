  org 0x0000

  li x3, 3
  li x4, 0x10


  loop:
    lw x5, 0(x4)
    addi x3, x3, -1
    bne x3, x0, loop

  halt
