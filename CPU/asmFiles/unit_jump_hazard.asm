li t0, 1
li t2, 0xBAD
li t3, branch
jal $2, branch
sw t0, 0(a0) #bad
halt
branch:
    sw t2, 0(a1)
    halt
