.data
.text
.global main

fib:
    SUB SP, SP, #12
    STR r1, [SP, #8]
    STR r2, [SP, #4]
    STR r3, [SP]
loop:
    CMP r0, #0
    BEQ load        @ if r0 = 0 quit loop

    MOV r3, r1      @ temporary = current
    ADD r1, r2, r1  @ current = previous + current
    MOV r2, r3      @ previous = current
    SUB r0, r0, #1  @ N -= 1

    B loop

load:               @ load values back  
    MOV r0, r1 
    LDR r1, [SP, #8]
    LDR r2, [SP, #4]
    LDR r3, [SP]
    BX lr

main:
    MOV r0, #13 @ N
    MOV r1, #0  @ Current
    MOV r2, #1  @ Previous
    BL fib      @ call fib function
    MOV r1, r0
    LDR r0, =output_string
    BL printf
    MOV r0, r1
    MOV r7, #1  @ syscall number for exit
    MOV r0, #0  @ exit status
    SWI 0       @ software interrupt

@ The 'data' section contains static data for our program

output_string:
        .asciz "%d\n"
