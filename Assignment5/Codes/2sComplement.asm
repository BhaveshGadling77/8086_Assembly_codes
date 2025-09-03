.model small

.stack 100h
.data

.code
    MOV BL, 0FFH; 8 bit number
    MOV AX, 0FFFFH; 16 bit number
    NEG BL ; 2's complement of 8 bit number
    NEG AX; 2's complement of 16 bit number.
    HLT
    