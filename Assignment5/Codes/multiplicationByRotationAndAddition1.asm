.model small

.stack 100h

.data
    num1 DW 5 ; multiplicant
    num2 DW 9 ; multiplier
    res DW 0

.code
    MOV AX, @data
    MOV DS, AX
    MOV AX, num1 ; AX-> multiplicant
    MOV BX, num2 ; BX-> multiplier
    MOV CX, 16
    XOR DX, DX 

    multiply_loop:
        SHR BX, 1 ; shift right by 1
        JNC skip_add ; If no carry skip addtion
        ADD DX, AX ; IF carry

    skip_add:
        SHL AX, 1  ;shift left by 1;
        LOOP multiply_loop

    MOV res, DX ;store result
HLT

