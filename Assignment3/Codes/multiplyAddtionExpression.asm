.model small

.stack 100h

.data
    a DB 05H
    b DB 06H
    c DB 10H
    d DB 40H

.code
    MOV AX, @data;
    MOV DS, AX;
    XOR AX, AX;
    XOR BX, BX;
    XOR CX, CX;
    XOR DX, DX;
    ;(a * b)
    LEA SI, a
    LEA DI, b;
    MOV AL, [SI]
    MOV BL, [DI]
    MUL BL;
    ;(c * d) then adding this two terms
    
    LEA SI, c;
    LEA DI, d;
    MOV CL, [SI]
    MOV DX, AX;
    MOV AL, [DI]
    MUL CL;
    ADD AX, DX;
    hlt