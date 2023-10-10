@ The two numbers we want to add
num1:   .word   0x3f800000
num2:   .word   0x3f800000
exp:    .word   0x7f800000
mant:   .word   0x003fffff

.text
.global main
main:
    @ Load numbers
    LDR r0, num1
    LDR r1, num2

    @ Extract exponent
    LDR r7, exp    @ masking out sign and mantissa to leave the exp
    AND r2, r0, r7 @ r0 exp ->
    LSR r2, r2, #23 @ Move to LSB 
    AND r3, r1, r7 @ r1 exp 
    LSR r3, r3, #23
               
    @ Extract mantissa
    LDR r8, mant   @ masking out the sign and exp to leave mantissa
    AND r4, r0, r8 @ r0 = mantissa
    AND r5, r1, r8 @ r1 = mantissa
    
    @ Prepend leading 1 to form the mantissa
    ORR r4, r4, #0x00400000
    ORR r5, r5, #0x00400000

    @ Compare exponents
    CMP r2, r3
    BGT greater
    BLT smaller
    
    B addM @ if equal
  
greater:
    SUB r6, r2, r3 @ Diff
    LSL r5, r5, r6
    B addM

smaller:
    SUB r6, r3, r2 @ Diff
    LSL r4, r4, r6
    MOV r2, r3     @ Set r2 as the higher exponent

addM:
    @Add mantissas
    ADD r0, r4, r5
    
    @ Normalize if necessary
    
    @ Remove leading 1 
    
    @Assemble exponent and fraction
    LSL r2, r2, #23 @ move back to correct position
    ORR r0, r0, r2
    @ When done, return
    BX lr

