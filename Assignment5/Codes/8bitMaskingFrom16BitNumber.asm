.model small

.stack 100h

.data

.code 
    XOR AX, AX;
    XOR BX, BX;
    XOR CX, CX;
    XOR DX, DX
    MOV AX, 01DCAH;
    MOV BX, 0FF00H;
    MOV CX, 0ABCDH;
    MOV DX, 000FFH;
    AND AX, BX;
    AND CX, DX;
    HLT