#----------------------------------------------------------
# RISC-V Assembly
#----------------------------------------------------------
#--------------------------------------
# multiplication procedure
#--------------------------------------

org 0x0000

main:
    addi sp, $0, 0xFFFC
    addi $21, $0, 0xFFF8

    addi $3, $0, 0x0009 //first operand = 9
    addi $4, $0, 0x0004 //second operand = 4 // the expected multiplication is 36
    addi $20, $0, 2

    //now the two operands need to be pushed to the stack
    addi sp, sp, -4
    sw $3, 0(sp)

    addi sp, sp, -4
    sw $4, 0(sp)

    addi sp, sp, -4
    sw $20, 0(sp)

    //now call the function multiply (jump and link)
    
loop1:
    beq sp, $21, end1
    jal $1, multiply

    j loop1

    //end the program after calling the function
    

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

end1:
    halt




 


    

