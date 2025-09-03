.model small

.stack 100h
.data

.code
    MOV BL, 0FFH; 8 bit number
    MOV AX, 0FFFFH; 16 bit number
    NOT BL ; 1's complement of 8 bit number
    NOT AX; 1's complement of 16 bit number.
    HLT
    