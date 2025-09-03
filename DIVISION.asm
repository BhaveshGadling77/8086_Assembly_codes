
.model small

.stack 100h

.data
divident DW 8080H
divisor DB 080H
res DB ?
.code
    MOV BX, @data;
    XOR CX, CX;
    XOR DX, DX;
    MOV DS, BX;
    MOV BX, 2020h;
    MOV CL, 80h; while divinding we need to keep in mind that the size of quotient and remainder should be capable of storing the result of operation.
    MOV AX, BX;
    DIV CL 
    HLT