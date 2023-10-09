.text
.global main
.type main, %function

@ Main function of program
main:
    .fnstart
    @ First load the desired Fibonacci number
    MOV r0, #13 @ N
    
    @ Initialize the first two numbers in the sequence
    MOV r1, #0  @ current
    MOV r2, #1  @ previous

@ Loop will do the main work calculating the Fibonacci sequence
loop:
    CMP r0, #0
    BEQ exit        @ if r0 = 0, quit loop

    MOV r3, r1      @ temporary = current
    ADD r1, r2, r1  @ current = previous + current
    MOV r2, r3      @ previous = current
    SUB r0, r0, #1  @ N -= 1

    B loop
@ To be a good citizen we branch (and exchange) on the lr register
@ to return to the caller
exit:
    MOV r0, r1
    BX lr
    .fnend
