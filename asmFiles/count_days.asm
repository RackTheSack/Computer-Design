#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# Algorithm to count days
#--------------------------------------

//days = current day + 30*(current month - 1) + 356 * (current year - 2000)


org 0x0000

main:

    addi sp, $0, 0xFFFC

    addi $3, $0, 20 //current day = 20 (14 hex)
    addi $4, $0, 1 //current month = 1
    addi $9, $0, 2001 //current year

    addi $4, $4, -1 //cuurent month - 1
    addi $9, $9, -2000 //current year - 2000

    addi $10, $0, 30
    addi $11, $0, 356

    addi sp, sp, -4
    sw $4, 0(sp)

    addi sp, sp, -4
    sw $10, 0(sp)

    jal $1, multiply
    lw $12, 0(sp)
    addi sp, sp, 4

    addi sp, sp, -4
    sw $9, 0(sp)

    addi sp, sp, -4
    sw $11, 0(sp)


    jal $1, multiply
    lw $13, 0(sp)
    addi sp, sp, 4
    

    add $3, $3, $12
    add $3, $3, $13

    addi sp, sp, -4
    sw $3, 0(sp)
    halt

multiply:
    //load 
    lw $5, 0(sp)
    addi sp, sp, 4

    lw $6, 0(sp)
    addi sp, sp, 4


    //initialize a loop counter variable
    addi $7, $0, 0

    //initialize multiplication result
    addi $8, $0, 0


loop:
    //check if the first operand was added the times of the second operand
    beq $7, $6, end # if $7 = $6 then end


    add $8, $8, $5
    addi $7, $7, 1

    j loop//loop again until the condition is satisfied

end:
    addi sp, sp, -4
    sw $8, 0(sp)
    jalr $0, 0($1)
