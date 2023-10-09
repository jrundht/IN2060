@ The two numbers we want to add
num1:   .word   0x3f800000
num2:   .word   0x3f800000
exp:    .word   0x7f800000
mant:   .word   0x7fffffff

.text
.global main
main:
    @ Load numbers
    LDR r0, num1
    LDR r1, num2
    
    @ ! Perform addition here !
    @ Extract exponent
    LDR r7, exp
    AND r2, r0, r7 @ r0 exp
    AND r3, r1, r7 @ r1 exp 
               
    @ Extract mantissa
    LDR r8, mant
    AND r4, r0, r8 @ r0 mantissa
    AND r5, r1, r8 @ r1 mantissa
    
    @ Prepend leading 1 to form the mantissa
    ORR r4, r4, #0x00800000
    ORR r5, r5, #0x00800000

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
    LSL r4, r5, r6

addM:
    ADD r0, r4, r5
    ADD r0, r0, r2
    @ When done, return
    BX lr


