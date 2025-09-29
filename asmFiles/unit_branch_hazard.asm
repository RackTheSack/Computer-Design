li t0, 0
li t2, 0xBAD
beq t0, $0, branch1
sw t0, 0(a0) #bad
halt
branch1:
    sw t2, 0(a1)
    halt
