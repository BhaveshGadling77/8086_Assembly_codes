.model small

.stack 100h

.data
    a DB 05H
    b DB 06H
    c DB 10H
    d DB 40H

.code                 
    ;(a + b)
    MOV AX, @data;
    MOV DS, AX;
    XOR AX, AX;
    XOR BX, BX;
    XOR CX, CX
    XOR DX, DX
    LEA SI, a;
    LEA DI, b;
    MOV AL, [SI]
    MOV BL, [DI]
    ADD AL, BL;
    ;(c + d)
    LEA SI, c;
    LEA DI, d;
    MOV CL, [SI]
    MOV DL, [DI]
    ADD CL, DL;
    ;(a + b) * (c + d)
    MUL CL
    HLT