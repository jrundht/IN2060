@ The two numbers we want to add
num1:       .word   0x40000000
num2:       .word   0x3f010000
exp:        .word   0x7f800000
mantissa:   .word   0x007fffff

.text
.global main
main:
    @ Load numbers
    LDR r0, num1
    LDR r1, num2

    @ Extract exponent
    LDR r7, exp        @ masking out sign and mantissa to leave the exp
    AND r2, r0, r7     @ r0 exp = r2
    LSR r2, r2, #23    @ Move to LSB 
    AND r3, r1, r7     @ r1 exp = r3
    LSR r3, r3, #23
               
    @ Extract mantissa
    LDR r8, mantissa   @ masking out the sign and exp to leave mantissa
    AND r4, r0, r8     @ r0 = mantissa
    AND r5, r1, r8     @ r1 = mantissa
    
    @ Prepend leading 1 to form the mantissa
    ORR r4, r4, #0x00800000
    ORR r5, r5, #0x00800000

    @ Compare exponents
    CMP r2, r3
    BGT greater
    BLT smaller
    
    B addM             @ if equal
  
greater:               @ Shift mantissa of smaller exponent
    SUB r6, r2, r3     @ Diff
    LSR r5, r5, r6
    B addM

smaller:               @ Shift mantissa of smaller exponent
    SUB r6, r3, r2     @ Diff
    LSR r4, r4, r6
    MOV r2, r3         @ Set r2 as the higher exponent

addM:
    @Add mantissas
    ADD r0, r4, r5
    
    @ Check if ormalize is necessary
    TST r0, #0x1000000 @ check if there is an overflow into bit 25
    BEQ removeLeading

tooLarge:    
    LSR r0, r0, #1
    ADD r2, r2, #1     @ Increment exponent

removeLeading:    
    AND r0, r0, r8 

    @Assemble exponent and fraction
    LSL r2, r2, #23    @ move back to correct position
    ORR r0, r0, r2
    
    BX lr
